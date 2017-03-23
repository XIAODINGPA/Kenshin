//
//  LocMapVC.h
//  GYBase
//
//  Created by doit on 16/5/9.
//  Copyright © 2016年 kenshin. All rights reserved.
/*
 
     开发者在使用定位功能之前，需要在info.plist里添加（以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription）：
     NSLocationWhenInUseUsageDescription ，允许在前台使用时获取GPS的描述
     NSLocationAlwaysUsageDescription ，允许永久使用GPS的描述
 
 */

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
@interface LocMapVC : UIViewController

@property (nonatomic, strong)BMKMapView             *mapView;//地图
@property (nonatomic, strong)BMKLocationService     *locService;//定位服务

@end
