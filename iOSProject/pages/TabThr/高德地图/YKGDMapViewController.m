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
@interface YKGDMapViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate>
@property (nonatomic,strong) AMapLocationManager *locationManager;
@end

@implementation YKGDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocation];
//    [self initMap];
}
//地图
-(void)initMap{
    
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//    _mapView.showsIndoorMap = YES;
    _mapView.delegate = self;
    [_mapView setMapType:MAMapTypeStandard];
    
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(32.49195828, 119.40345486);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    
    [_mapView addAnnotation:pointAnnotation];
}



- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


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
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//    if (reGeocode){
//        NSLog(@"reGeocode:%@", reGeocode);
//    }
//}
@end
