/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "LocationViewController.h"
#import "AZViewUtil.h"
#import "AZAlertUtil.h"
#import "CLLocation+Trans.h"

static LocationViewController *defaultLocation = nil;

@interface LocationViewController () <MKMapViewDelegate> {
    MKMapView *_mapView;
    MKPointAnnotation *_annotation;
    CLLocationCoordinate2D _currentLocationCoordinate;
    BOOL _isSendLocation;
}

@property (strong, nonatomic) NSString *addressString;

@end

@implementation LocationViewController

@synthesize addressString = _addressString;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isSendLocation = YES;
    }
    return self;
}

- (instancetype)initWithLocation:(CLLocationCoordinate2D)locationCoordinate {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _isSendLocation = NO;
        _currentLocationCoordinate = locationCoordinate;
    }
    return self;
}

- (void)initVariable {
    [super initVariable];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [AZViewUtil updateNavigationBarBackgroundWhite:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"位置信息";
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.zoomEnabled = YES;
    [self.view addSubview:_mapView];
    
    if (_isSendLocation) {
        _mapView.showsUserLocation = YES;//显示当前位置
        
        UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendLocation)];
        self.navigationItem.rightBarButtonItem = sendItem;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        [self startLocation];
    }
    else{
        [self removeToLocation:_currentLocationCoordinate];
    }
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - class methods

+ (instancetype)defaultLocation {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultLocation = [[LocationViewController alloc] initWithNibName:nil bundle:nil];
    });
    
    return defaultLocation;
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    __weak typeof(self) weakSelf = self;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (!error && array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            weakSelf.addressString = placemark.name;
            [self removeToLocation:userLocation.coordinate];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [AZAlertUtil tipOneMessage:@"定位失败"];
}

#pragma mark - public

- (void)startLocation {
    if (_isSendLocation) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    [AZAlertUtil showHudWithHint:@"正在定位..." inView:self.view];
}

- (void)createAnnotationWithCoords:(CLLocationCoordinate2D)coords {
    if (_annotation == nil) {
        _annotation = [[MKPointAnnotation alloc] init];
    } else {
        [_mapView removeAnnotation:_annotation];
    }
    _annotation.coordinate = coords;
    [_mapView addAnnotation:_annotation];
}

- (void)removeToLocation:(CLLocationCoordinate2D)locationCoordinate {
    [AZAlertUtil hideHud];
    
    _currentLocationCoordinate = locationCoordinate;
    float zoomLevel = 0.01;
    MKCoordinateRegion region = MKCoordinateRegionMake(_currentLocationCoordinate, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    
    if (_isSendLocation) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    
    [self createAnnotationWithCoords:_currentLocationCoordinate];
}

- (void)sendLocation {
    if (_delegate && [_delegate respondsToSelector:@selector(locationViewController:requestToSendLocation:)]) {
        
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(_currentLocationCoordinate.latitude, _currentLocationCoordinate.longitude);
//        coor = [CLLocation locationBaiduFromMars:coor];
        LCLocationModel *location = [[LCLocationModel alloc] init];
        location.address = self.addressString;
        location.lat = coor.latitude;
        location.lng = coor.longitude;
        [_delegate locationViewController:self requestToSendLocation:location];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end


@implementation LCLocationModel


@end
