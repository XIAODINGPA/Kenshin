//
//  RadarVC.h
//  GYBase
//
//  Created by doit on 16/5/6.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
        未实现功能 用时在学
 
 */

#import <UIKit/UIKit.h>//周边雷达   ：附近的人， 使用同款app的人 位置上传 等 真机测试
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>

@interface RadarVC : UIViewController

@property (nonatomic, strong)BMKRadarManager    *radarManager;
@end
