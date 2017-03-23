//
//  SelectMapTypeVC.m
//  GYBase
//
//  Created by doit on 16/5/6.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "SelectMapTypeVC.h"
#import "Tools.h"
#import "BlockButton.h"
#import "BaseMapVC.h"
#import "LocMapVC.h"
#import "RadarVC.h"

@interface SelectMapTypeVC ()

@end

@implementation SelectMapTypeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSelectMapTypeVCUI];
    
}

- (void)initSelectMapTypeVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"百度地图目录";
    
    
    //基础地图
    BlockButton *baseMapBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64 + margin_10, 100, height_normal)];
    [baseMapBtn setTitle:@"基础地图" forState:UIControlStateNormal];
    baseMapBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:baseMapBtn];
    
    //定位定图
    BlockButton *locMapBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*2 + 100, 64 + margin_10, 100, height_normal)];
    [locMapBtn setTitle:@"定位地图" forState:UIControlStateNormal];
    locMapBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:locMapBtn];
    
    //周边雷达
    BlockButton *radarMapBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*3 + 200, 64 + margin_10, 100, height_normal)];
    [radarMapBtn setTitle:@"周边雷达" forState:UIControlStateNormal];
    radarMapBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:radarMapBtn];
    
    
    WS(ws);
    //基础地图跳转
    baseMapBtn.block = ^(BlockButton *btn){
        BaseMapVC *vc = [BaseMapVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //定位地图跳转
    locMapBtn.block = ^(BlockButton *btn){
        LocMapVC *vc = [LocMapVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
    
    //周边雷达跳转
    radarMapBtn.block = ^(BlockButton *btn){
        RadarVC *vc = [RadarVC new];
        [ws.navigationController pushViewController:vc animated:YES];
        
    };
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
