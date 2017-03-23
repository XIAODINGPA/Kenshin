//
//  RadarVC.m
//  GYBase
//
//  Created by doit on 16/5/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "RadarVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

@interface RadarVC ()

@end

@implementation RadarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initRadarVCUI];
    [self initRadarService];
    [Tools toast:@"用时现学" andCuView:self.view];
    
}

- (void)initRadarVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"周边雷达";
    
}

- (void)initRadarService
{
//    self.radarManager = [BMKRadarManager getRadarManagerInstance];
    
//    在不需要时，通过下边的方法使引用计数减1
//    [BMKRadarManager releaseRadarManagerInstance];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
