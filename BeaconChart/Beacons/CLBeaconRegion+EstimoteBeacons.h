//
// Created by Michal Zygar on 14.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface CLBeaconRegion (EstimoteBeacons)
+ (CLBeaconRegion *)estimoteDefaultRegion;
@end