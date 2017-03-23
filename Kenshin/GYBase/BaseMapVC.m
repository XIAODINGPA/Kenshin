//
//  LocVC.m
//  GYBase
//
//  Created by doit on 16/5/5.
//  Copyright © 2016年 kenshin. All rights reserved.

//  AK : xmfYYgeNc1Yt9ygVKlVyPcxGBD2rRh7C

#import "BaseMapVC.h"
#import "Tools.h"
#import "BlockButton.h"

//
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
//
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
//
//#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
//
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
//
//#import < BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface BaseMapVC ()<BMKMapViewDelegate>
{
    
    BMKPointAnnotation  *myAnnotation;//标注
    
    BOOL                hiddenSwitch;
    BlockButton         *typeOneBtn;
    BlockButton         *typeTwoBtn;
    BlockButton         *typeThreeBtn;
    BlockButton         *tfaficBtn;
    BlockButton         *hotBtn;
    BlockButton         *delBtn;
    BlockButton         *addBtn;
    
}
@end

@implementation BaseMapVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLocVCUI];
    [self ctrlMenu];
    [Tools toast:@"功能很多 用时在学" andCuView:self.view];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

//添加标注
- (void)addAnnotation
{
    [self removeAnnotation];//比如删除之前的
    
    // 添加一个PointAnnotation[标注]
    if (myAnnotation == nil)
    {
        myAnnotation = [[BMKPointAnnotation alloc]init];
        
    }
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915; //纬度
    coor.longitude = 116.404; //经度
    myAnnotation.coordinate = coor;
    myAnnotation.title = @"这里是北京";//点击该标注时显示
    
    [self.mapView addAnnotation:myAnnotation];
    
}

//删除标注
- (void)removeAnnotation
{
    if (myAnnotation != nil) {
        [self.mapView removeAnnotation:myAnnotation];
    }
    
}

- (void)initLocVCUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"基础地图";
    [Tools toast:@"最简单需求" andCuView:self.view];
    
    //导航栏添加按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                  target:self
                                  action:@selector(ctrlMenu)];
    NSArray *arrBtns = @[shareItem];
    self.navigationItem.rightBarButtonItems = arrBtns;
    
    //基础地图
    CGFloat widthBtn = 60;
    CGFloat hBtn     = 36;
    CGFloat marginY  = 64 + margin_10;
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
    self.view = self.mapView;
    
    //空白
    typeOneBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, marginY, widthBtn, hBtn)];
    [typeOneBtn setTitle:@"空白" forState:UIControlStateNormal];
    [self setButtonStyle:typeOneBtn];
    
    //标准
    typeTwoBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*2 +widthBtn, marginY, widthBtn, hBtn)];
    [typeTwoBtn setTitle:@"标准" forState:UIControlStateNormal];
    [self setButtonStyle:typeTwoBtn];
    
    //卫星
    typeThreeBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*3 +widthBtn*2, marginY, widthBtn, hBtn)];
    [typeThreeBtn setTitle:@"卫星" forState:UIControlStateNormal];
    [self setButtonStyle:typeThreeBtn];
    
    
    //路况
    tfaficBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*4 +widthBtn*3, marginY, widthBtn, hBtn)];
    [tfaficBtn setTitle:@"路况" forState:UIControlStateNormal];
    [self setButtonStyle:tfaficBtn];
    
    //热力
    hotBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*5 + widthBtn*4, marginY, widthBtn, hBtn)];
    [hotBtn setTitle:@"热力" forState:UIControlStateNormal];
    [self setButtonStyle:hotBtn];
    
    //添加标注
    addBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10, 64+margin_10*2 + hBtn, widthBtn, hBtn)];
    [addBtn setTitle:@"加标" forState:UIControlStateNormal];
    [self setButtonStyle:addBtn];
    
    //删除标注
    delBtn = [[BlockButton alloc] initWithFrame:CGRectMake(margin_10*2 + widthBtn, 64+margin_10*2 + hBtn, widthBtn, hBtn)];
    [delBtn setTitle:@"删标" forState:UIControlStateNormal];
    [self setButtonStyle:delBtn];
    
    [self.view addSubview:typeOneBtn];
    [self.view addSubview:typeTwoBtn];
    [self.view addSubview:typeThreeBtn];
    [self.view addSubview:tfaficBtn];
    [self.view addSubview:hotBtn];
    [self.view addSubview:addBtn];
    [self.view addSubview:delBtn];
    
    WS(ws);
    //修改地图类型
    typeOneBtn.block = ^(BlockButton *btn){
        [ws setMapType:0];
    };
    
    typeTwoBtn.block = ^(BlockButton *btn){
        [ws setMapType:1];
    };
    
    typeThreeBtn.block = ^(BlockButton *btn){
        [ws setMapType:2];
    };
    
    ////路况开关
    tfaficBtn.block = ^(BlockButton *btn){
        if (ws.mapView.isTrafficEnabled)
        {
            [ws.mapView setTrafficEnabled:NO];
        }
        else
        {
            [ws.mapView setTrafficEnabled:YES];
        }
        
    };
    
    //热力开关
    hotBtn.block =^(BlockButton *btn){
        if (ws.mapView.isBaiduHeatMapEnabled)
        {
            //关闭百度城市热力图图层（百度自有数据）
            [ws.mapView setBaiduHeatMapEnabled:NO];
        }
        else
        {
            //打开百度城市热力图图层（百度自有数据）
            [ws.mapView setBaiduHeatMapEnabled:YES];
        }
    };
    
    //添加标注
    addBtn.block = ^(BlockButton *btn){
        [ws addAnnotation];
    };
    
    //删除标注
    delBtn.block = ^(BlockButton *btn){
        [ws removeAnnotation];
    };
    
}

//按钮固定样式
- (void)setButtonStyle:(BlockButton *)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = RGB2Color(231, 111, 100);
    [Tools setCornerRadiusWithView:btn andAngle:8];
    btn.alpha = 0.6;
    
}

- (void)ctrlMenu
{
    if (hiddenSwitch)
    {
        hiddenSwitch = NO;
    }
    else
    {
        hiddenSwitch = YES;
    }
    
    typeOneBtn.hidden   = hiddenSwitch;
    typeTwoBtn.hidden   = hiddenSwitch;
    typeThreeBtn.hidden = hiddenSwitch;
    tfaficBtn.hidden    = hiddenSwitch;
    hotBtn.hidden       = hiddenSwitch;
    delBtn.hidden       = hiddenSwitch;
    addBtn.hidden       = hiddenSwitch;
}

#pragma mark 设置地图类型
- (void)setMapType:(NSInteger)type
{
    [self.mapView setMapType:type];
    
    /*BMKMapTypeNone      = 0,               ///< 空白地图
     BMKMapTypeStandard   = 1,               ///< 标准地图
     BMKMapTypeSatellite  = 2,               ///< 卫星地图*/
    
}

/*
     自2.0.0起，BMKMapView新增viewWillAppear、viewWillDisappear方法来控制BMKMapView的生命周期，
     并且在一个时刻只能有一个BMKMapView接受回调消息，因此在使用BMKMapView的viewController中需要在viewWillAppear、
     viewWillDisappear方法中调用BMKMapView的对应的方法，并处理delegate，代码如下：
 */

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    
}

#pragma mark - BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
    alert = nil;
    
}

#pragma mark 点击
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"map view: click blank");
    
}

#pragma mark 双击
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"map view: double click");
    
}

#pragma 标注[动画效果]
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
        
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    self.mapView      = nil;
    myAnnotation      = nil;
    
    typeOneBtn        = nil;
    typeTwoBtn        = nil;
    typeThreeBtn      = nil;
    tfaficBtn         = nil;
    hotBtn            = nil;
    delBtn            = nil;
    addBtn            = nil;
    
}

@end
