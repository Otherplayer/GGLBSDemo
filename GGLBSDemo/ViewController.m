//
//  ViewController.m
//  GGLBSDemo
//
//  Created by __无邪_ on 15/7/31.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "GGLBSManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[GGLBSManager sharedManager] startUpdatingLocation];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
