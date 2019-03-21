//
//  YKGDMapViewController.m
//  iOSProject
//
//  Created by 姚凯 on 2019/3/21.
//  Copyright © 2019 姚凯. All rights reserved.
//

#import "YKGDMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface YKGDMapViewController ()<AMapLocationManagerDelegate>
@property (nonatomic,strong) AMapLocationManager *locationManager;
@end

@implementation YKGDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getLocation];
    [self initMap];
}
//地图
-(void)initMap{
    
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsIndoorMap = YES;
    
    [_mapView setMapType:MAMapTypeSatellite];
}
//定
//定位
-(void)getLocation{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    /**
     持续定位
     self.locationManager = [[AMapLocationManager alloc] init];
     self.locationManager.delegate = self;
     self.locationManager.distanceFilter = 100;
     self.locationManager.locatingWithReGeocode = YES;
     //允许后台定位
     self.locationManager.allowsBackgroundLocationUpdates = YES;
     [self.locationManager startUpdatingLocation];
     */
    //单次定位
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    self.locationManager.locationTimeout =10;
    self.locationManager.reGeocodeTimeout = 10;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed){
                return;
            }
        }
        NSLog(@"location:%@", location);
        if (regeocode){
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
    
}
#pragma mark - delegate
//持续定位代理方法
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode){
        NSLog(@"reGeocode:%@", reGeocode);
    }
}
@end
