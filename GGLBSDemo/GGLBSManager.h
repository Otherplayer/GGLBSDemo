//
//  GGLBSManager.h
//  GGLBSDemo
//
//  Created by __无邪_ on 15/7/31.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GGLBSManager : CLLocationManager<CLLocationManagerDelegate>

+ (instancetype)sharedManager;

@property (nonatomic, assign) CGFloat minSpeed;     //最小速度
@property (nonatomic, assign) CGFloat minFilter;    //最小范围
@property (nonatomic, assign) CGFloat minInteval;   //更新间隔


@end
