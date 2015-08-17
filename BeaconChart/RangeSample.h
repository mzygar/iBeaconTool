//
// Created by Michal Zygar on 16.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface RangeSample : NSObject
@property(nonatomic) CLLocationAccuracy value;
@property(nonatomic) NSInteger index;

- (instancetype)initWithSampleIndex:(NSInteger)sampleIndex value:(CLLocationAccuracy)value;

+ (instancetype)sampleWithIndex:(NSInteger)sampleIndex andValue:(CLLocationAccuracy)value;


@end