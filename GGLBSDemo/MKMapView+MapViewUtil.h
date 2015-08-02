//
//  MKMapView+MapViewUtil.h
//  GGLBSDemo
//
//  Created by __无邪_ on 15/8/2.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (MapViewUtil)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel ///large 28
                   animated:(BOOL)animated;

@end
