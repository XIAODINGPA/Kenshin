////
////  TodayViewController.m
////  IAMYourFather
////
////  Created by kenshin on 17/1/18.
////  Copyright © 2017年 kenshin. All rights reserved.
//// 【因为Widget中的mKeu库不支持模拟器 所以这个使用模拟器是时候把本类注释掉了】
////获取手机屏幕的宽、高
//#define screenWidth  [[UIScreen mainScreen] bounds].size.width
//#define screenHeight [[UIScreen mainScreen] bounds].size.height
//
//#import "TodayViewController.h"
//#import <NotificationCenter/NotificationCenter.h>
//#import "M2MBLEController.h"
//
//@interface TodayViewController () <NCWidgetProviding, M2MLockBasicCtrlCallback>
//@property (nonatomic, strong) UIButton  *btnTest;
//
//@end
//
//@implementation TodayViewController
//
//#pragma mark - 测试 蓝牙解锁
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self testDataShareFXW];
//    [self initUI];
//    [self testBluetoothOpenLock];
//    
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    //判断如果可以设置展开模式 就讲widget设置成可以展开
//    if([self.extensionContext respondsToSelector:@selector(setWidgetLargestAvailableDisplayMode:)])
//    {
//        //设置widget 的显示模式为 展开
//        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
//        
//    }
//    
//}
//
//
////让隐藏的Widget重新显示
//- (void)showWidgetFXW
//{
//    [[NCWidgetController widgetController] setHasContent:YES forWidgetWithBundleIdentifier:@"com.wangzz.app.extension"];
//    
//}
//
////让显示的Widget重新隐藏
//- (void)hidenWidgetFXW
//{
//    [[NCWidgetController widgetController] setHasContent:NO forWidgetWithBundleIdentifier:@"com.wangzz.app.extension"];
//    
//}
//
//#pragma mark 打开本APP 需要在info 的 URLTYPE 中设置 schme
//- (void)openSomeoneApp
//{
//    NSLog(@"%s",__func__);
//    
//    NSURL *url = [NSURL URLWithString:@"IAMYOURFATHER://red"];
//    
//    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
//        
//        NSLog(@"isSuccessed %d",success);
//    }];
//    
//}
//
//- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
//{
//    //在代理方法中处理 展开和折叠
//    if (activeDisplayMode == NCWidgetDisplayModeCompact)
//    {
//        //模式为折叠的时候 这个地方的高度貌似是固定的[因为我修改了没效果]
//        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
//    }
//    else
//    {
//        //模式为展开的时候 高度可以随便定义
//        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
//    }
//}
//
////iOS10之前，视图原点默认存在一个间距，可以实现以下方法来调整视图间距
////注：该方法在iOS10之后被遗弃，iOS10默认不存在间距。
//- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
//{
//    return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
//    
//}
//
//
//- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler
//{
//    // Perform any setup necessary in order to update the view.
//    
//    // If an error is encountered, use NCUpdateResultFailed
//    // If there's no update required, use NCUpdateResultNoData
//    // If there's an update, use NCUpdateResultNewData
//    
//    completionHandler(NCUpdateResultNewData);
//}
//
//#pragma mark 数据共享
//- (void)testDataShareFXW
//{
//    //App 内是在AppDelegate.m中设置的数据
//    
//    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.sanhe.kenshin"];
//    NSArray *value = [shared objectForKey:@"test"];
//    NSLog(@"数据共享采用NSUserDefaults方式：测试结果%@", value);
//    
//    NSError *err = nil;
//    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.sanhe.kenshin"];
//    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/good"];
//    NSString *value2 = [NSString stringWithContentsOfURL:containerURL encoding:NSUTF8StringEncoding error:&err];
//    NSLog(@"数据共享采用NSFileManager方式：测试结果%@", value2);
//    
//}
//
//- (void)initUI
//{
//    self.view.backgroundColor = [UIColor yellowColor];
//    
//    //设置WidgtUI展示的大小【这里设置的size是无效的】
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat height = 1000;
//    self.preferredContentSize = CGSizeMake(width, height);
//    
//    
//    CGFloat btnW = 100;
//    CGFloat btnH = 40;
//    CGFloat btnX = screenWidth/2 - btnW/2;
//    
//    _btnTest = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 40, btnW, btnH)];
//    [_btnTest setTitle:@"快捷开锁测试" forState:UIControlStateNormal];
//    //    [_btnTest addTarget:self action:@selector(openSomeoneApp) forControlEvents:UIControlEventTouchUpInside];
//    [_btnTest addTarget:self action:@selector(testOpenDoor) forControlEvents:UIControlEventTouchUpInside];
//    _btnTest.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_btnTest];
//    
//    
//    //    [self hidenWidgetFXW];
//
//}
//
//- (void)testBluetoothOpenLock
//{
//    // 初始化控制器设备、回调
//    [M2MBLEController getController].delegate = self;
//    [[M2MBLEController getController] disconnect];//由于Widget的生命周期问题 这里每次都断开一次最好
//    
//    //【下面的数据都是临时数据 用来测试用的】
//    //    NSString *aa= [M2MBLEMessage bytes2Hex:data];
//    NSString *a = @"15fa40ca16d4452e4ba1b6e606918e46";//7AF3
//                  //15fa40ca16d4452e4ba1b6e606918e46
//    NSData *ltk = [M2MBLEMessage hex2Bytes:a];
//    M2MLock *lock = [[M2MLock alloc]initWith:@"C3:79:4A:D2:7A:F3" type:TYPE_FLOCK4 comment:@"🐺🐩🐕" pin:1 rawLtk:ltk];
//    [[M2MBLEController getController] setDevice:lock];
//    
//}
//
//- (void)testOpenDoor
//{
//    [[M2MBLEController getController] connect];
//    [[M2MBLEController getController] unlock];
//    
//}
//
///*!
// @brief 锁连接状态回调
// */
//- (void) onLockConnecting:(ConnState)state
//{
//    switch (state) {
//        case CS_CONN_OK: // 锁连接成功，随即获取锁状态
//        {
//            [[M2MBLEController getController] unlock];//onLockStateChanged
//            
//        }
//            break;
//        case CS_SCANNING:
//        {
//            NSLog(@"scanning lock");
//        }
//            break;
//        case CS_OUT_OF_RANGE:
//        {
//            NSLog(@"failed to discover the lock");
//        }
//            break;
//        case CS_IN_DFU_MODE:
//        {
//            
//        }
//            break;
//        case CS_CONNECTING:
//        {
//            NSLog(@"connecting lock");
//        }
//            break;
//        case CS_MKEY_ERROR:
//        {
//
//        }
//            break;
//        case CS_BLE_ERROR:
//        {
//            
//        }
//            break;
//        case CS_CONN_TIMEOUT:
//        {
//            
//        }
//            break;
//        default:
//        {
//            
//        }
//            break;
//    }
//
//}
//
//
//- (void) onCommunicationError:(CommError)error{}
//
//- (void) onLockStateChanged{}
//
//- (void) onLockDisconnected{}
//
//- (void)dealloc
//{
//    NSLog(@"窗口小部件释放了");
//    
//}
//@end
