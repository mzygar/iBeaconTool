//
// Created by Michal Zygar on 14.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "CLBeaconRegion+EstimoteBeacons.h"

static NSString *ESTIMOTE_PROXIMITY_UDID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";

@implementation CLBeaconRegion (EstimoteBeacons)

+ (CLBeaconRegion *)estimoteDefaultRegion {
    return [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:ESTIMOTE_PROXIMITY_UDID] identifier:@"Defaiult Estimote Region"];
}
@end