//
//  LocMapVC.m
//  GYBase
//
//  Created by doit on 16/5/9.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "LocMapVC.h"
#import "Tools.h"

@interface LocMapVC ()<BMKLocationServiceDelegate>

@end

@implementation LocMapVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLocService];
    [self initLocMapVCUI];
    
}

- (void)initLocService
{
    //初始化BMKLocationService
    self.locService = [[BMKLocationService alloc]init];
    self.locService.delegate = self;
    //启动LocationService
    [self.locService startUserLocationService];
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [self.mapView updateLocationData:userLocation];//更新地图坐标
   
}

- (void)initLocMapVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"定位";
    
    //基础地图
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
    self.view = self.mapView;
    
    //添加导航栏按钮[用于更新定位]
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                  target:self
                                  action:@selector(refreshLocation)];
    NSArray *barBtns = @[shareItem];
    self.navigationItem.rightBarButtonItems = barBtns;
    
    
    
}

- (void)refreshLocation
{
    [Tools toast:@"正在定位自身位置..." andCuView:self.view];
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode  = BMKUserTrackingModeFollowWithHeading;
    self.mapView.showsUserLocation = YES;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.locService = nil;
    self.mapView    = nil;
    
}

@end
