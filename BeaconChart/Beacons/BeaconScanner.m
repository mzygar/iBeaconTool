//
// Created by Michal Zygar on 14.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "BeaconScanner.h"
#import "CLBeaconRegion+EstimoteBeacons.h"

@interface BeaconScanner ()
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) CLBeaconRegion *rangedRegion;
@property(nonatomic, weak) id <BeaconScannerDelegate> delegate;
@property(nonatomic) BOOL isRanging;
@end

@implementation BeaconScanner

+ (instancetype)estimoteScannerWithDelegate:(id <BeaconScannerDelegate>)delegate {
    return [[self alloc] initWithRegion:[CLBeaconRegion estimoteDefaultRegion] delegate:delegate];
}


- (instancetype)initWithRegion:(CLBeaconRegion *)region delegate:(id <BeaconScannerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.rangedRegion = [CLBeaconRegion estimoteDefaultRegion];
        self.rangedRegion = region;
    }
    return self;
}


- (void)startRangingBeacons {
    if (self.isRanging) {
        return;
    }
    [self authorizeIfNeeded];
    // we start location updates as well to keep ranging beacons in background
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [self.locationManager startUpdatingLocation];

    NSLog(@"Starting ranging");
    [self.locationManager startRangingBeaconsInRegion:self.rangedRegion];
    self.isRanging = YES;
}


- (void)stopRangingBeacons {
    NSLog(@"Stopping ranging");
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopRangingBeaconsInRegion:self.rangedRegion];
    self.isRanging = NO;
}


- (void)authorizeIfNeeded {
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager requestAlwaysAuthorization];
    } else {
        NSLog(@"Already authorized");
    }
}

#pragma mark Location Manager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Detected %lu devices", (unsigned long)beacons.count);
    if ([self.delegate respondsToSelector:@selector(beaconScanner:didRangeBeacons:)]) {
        [self.delegate beaconScanner:self didRangeBeacons:beacons];
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"Error occured when ranging beacons: %@", error.localizedDescription);
}


@end