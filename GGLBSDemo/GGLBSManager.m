//
//  GGLBSManager.m
//  GGLBSDemo
//
//  Created by __无邪_ on 15/7/31.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

//NSLocationWhenInUseUsageDescription
//NSLocationAlwaysUsageDescription


#import "GGLBSManager.h"

@implementation GGLBSManager

#pragma mark - lifeCircle

+ (instancetype)sharedManager{
    static GGLBSManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GGLBSManager alloc] init];
    });
    
    return instance;
}


- (instancetype)init{
    self = [super init];
    if (self){
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        }
        
        // 请求允许
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [self requestAlwaysAuthorization];
        }
        
        
//        self.minSpeed = 3;
//        self.minFilter = 50;
//        self.minInteval = 10;
        
        self.minSpeed = 0.5;
        self.minFilter = 5;
        self.minInteval = 5;
        
        self.delegate = self;
        self.distanceFilter  = self.minFilter;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        
    }
    return self;
}


#pragma mark - delegate


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations[0];
    
    NSLog(@"location ： %@",location);
    
    //根据实际情况来调整触发范围
    [self adjustDistanceFilter:location];
    
    //上传数据
    [self uploadLocation:location];
}


/**
 *  规则: 如果速度小于minSpeed m/s 则把触发范围设定为50m
 *  否则将触发范围设定为minSpeed*minInteval
 *  此时若速度变化超过10% 则更新当前的触发范围(这里限制是因为不能不停的设置distanceFilter,
 *  否则uploadLocation会不停被触发)
 */
- (void)adjustDistanceFilter:(CLLocation*)location
{
    NSLog(@"adjust location.speed : %f",location.speed);
    
    if ( location.speed < self.minSpeed )
    {
        if ( fabs(self.distanceFilter-self.minFilter) > 0.1f )
        {
            self.distanceFilter = self.minFilter;
        }
    }
    else
    {
        CGFloat lastSpeed = self.distanceFilter/self.minInteval;
        
        if ( (fabs(lastSpeed-location.speed)/lastSpeed > 0.1f) || (lastSpeed < 0) )
        {
            CGFloat newSpeed  = (int)(location.speed+0.5f);
            CGFloat newFilter = newSpeed*self.minInteval;
            
            self.distanceFilter = newFilter;
        }
    }
}
//这里仅用本地数据库模拟上传操作
- (void)uploadLocation:(CLLocation*)location
{
    NSLog(@"uploadLocation");
    
    if (_lbsDelegate && [_lbsDelegate respondsToSelector:@selector(didUpdateLocation:)]) {
        [_lbsDelegate didUpdateLocation:location];
    }
    
//    MMLoc *loc = [MMLoc new];
//    loc.date       = [NSDate date];
//    loc.background = ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground);
//    loc.loc        = [NSString stringWithFormat:@"speed:%.0f filter:%.0f",location.speed,self.distanceFilter];
//    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    
//    [realm transactionWithBlock:^{
//        [realm addObject:loc];
//        
//    }];
    
#warning 如果有较长时间的操作 比如HTTP上传 请使用beginBackgroundTaskWithExpirationHandler
    //    if ( [UIApplication sharedApplication].applicationState == UIApplicationStateActive )
    //    {
    //        //TODO HTTP upload
    //
    //        [self endBackgroundUpdateTask];
    //    }
    //    else//后台定位
    //    {
    //        //假如上一次的上传操作尚未结束 则直接return
    //        if ( self.taskIdentifier != UIBackgroundTaskInvalid )
    //        {
    //            return;
    //        }
    //
    //        [self beingBackgroundUpdateTask];
    //
    //        //TODO HTTP upload
    //        //上传完成记得调用 [self endBackgroundUpdateTask];
    //    }
    
}


//- (void)beingBackgroundUpdateTask
//{
//    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        [self endBackgroundUpdateTask];
//    }];
//}
//
//- (void)endBackgroundUpdateTask
//{
//    if ( self.taskIdentifier != UIBackgroundTaskInvalid )
//    {
//        [[UIApplication sharedApplication] endBackgroundTask: self.taskIdentifier];
//        self.taskIdentifier = UIBackgroundTaskInvalid;
//    }
//}


@end
