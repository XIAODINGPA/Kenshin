//
//  XcodeEightVC.m
//  GYBase
//
//  Created by kenshin on 16/9/19.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "XcodeEightVC.h"

@interface XcodeEightVC ()

@end

@implementation XcodeEightVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Xcode8滚动视图";
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
