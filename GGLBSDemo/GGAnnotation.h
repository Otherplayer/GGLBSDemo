//
//  GGAnnotation.h
//  GGLBSDemo
//
//  Created by __无邪_ on 15/8/2.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GGAnnotation : NSObject<MKAnnotation>
-(id)initWithCoordinate:(CLLocationCoordinate2D) coords;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
