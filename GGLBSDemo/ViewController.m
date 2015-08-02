//
//  ViewController.m
//  GGLBSDemo
//
//  Created by __无邪_ on 15/7/31.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MKMapView+MapViewUtil.h"
#import "GGLBSManager.h"
#import "GGAnnotation.h"

static NSString *iDentifier = @"identifier";
static NSString *annotationIdentifier = @"annotationIdentifier";
static int indexNumber = 0;

@interface ViewController ()<GGLBSManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation ViewController

#pragma mark - lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.items = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:iDentifier];
    
    [[GGLBSManager sharedManager] setLbsDelegate:self];
    
    
    [[GGLBSManager sharedManager] startUpdatingLocation];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GGLBSManagerDelegate

- (void)didUpdateLocation:(CLLocation *)location{
    [self.items insertObject:location atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];

    [self addAnnotation:location];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDentifier forIndexPath:indexPath];
    
    CLLocation *loc = self.items[indexPath.row];
    NSString *locInfo = [NSString stringWithFormat:@"【%d】时间：%@ \n坐标：(%f,%f) \n速度：%f m/s",++indexNumber,loc.timestamp,loc.coordinate.latitude,loc.coordinate.longitude,loc.speed];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setText:locInfo];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"数据";
}

#pragma mark - MKViewDelegate
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
    newAnnotation.pinColor = MKPinAnnotationColorGreen;
    newAnnotation.animatesDrop = YES;
    return newAnnotation;
}

#pragma mark - private

- (void)addAnnotation:(CLLocation *)location{
    GGAnnotation *annotation = [[GGAnnotation alloc] initWithCoordinate:location.coordinate];
    [annotation setTitle:@"ad"];
    [annotation setSubtitle:@"asf"];
    [self.mapView addAnnotation:annotation];
    
    
    
    [self.mapView setCenterCoordinate:location.coordinate zoomLevel:13 animated:YES];
    

    
//    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}


@end
