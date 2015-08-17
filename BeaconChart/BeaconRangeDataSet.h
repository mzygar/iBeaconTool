//
// Created by Michal Zygar on 16.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;
@class RangeSample;

@interface BeaconRangeDataSet : NSObject
@property(nonatomic, strong) CLBeacon *beacon;
@property(nonatomic, strong) NSMutableArray *samples;

- (instancetype)initWithBeacon:(CLBeacon *)beacon;


- (void)addSample:(RangeSample *)sample;
@end