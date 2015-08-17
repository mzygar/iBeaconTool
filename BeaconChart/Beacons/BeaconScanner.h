//
// Created by Michal Zygar on 14.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@class BeaconScanner;


@protocol BeaconScannerDelegate <NSObject>
- (void)beaconScanner:(BeaconScanner *)scanner didRangeBeacons:(NSArray *)beacons;
@end

@interface BeaconScanner : NSObject <CLLocationManagerDelegate>

+ (instancetype)estimoteScannerWithDelegate:(id <BeaconScannerDelegate>)delegate;

- (instancetype)initWithRegion:(CLBeaconRegion *)region delegate:(id <BeaconScannerDelegate>)delegate;

- (void)startRangingBeacons;

- (void)stopRangingBeacons;
@end