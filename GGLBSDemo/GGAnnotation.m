//
//  GGAnnotation.m
//  GGLBSDemo
//
//  Created by __无邪_ on 15/8/2.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "GGAnnotation.h"

@implementation GGAnnotation
-(id)initWithCoordinate:(CLLocationCoordinate2D) coords
{
    if (self = [super init]) {
        _coordinate = coords;
    }
    return self;
}
@end
