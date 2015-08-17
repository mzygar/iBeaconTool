//
// Created by Michal Zygar on 16.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "BeaconRangeDataSet.h"
#import "RangeSample.h"


@interface BeaconRangeDataSet ()

@end

@implementation BeaconRangeDataSet {

}


- (instancetype)initWithBeacon:(CLBeacon *)beacon {
    self = [super init];
    if (self) {
        self.beacon = beacon;
        self.samples = [NSMutableArray new];
    }

    return self;
}


- (void)addSample:(RangeSample *)sample {
    [self.samples addObject:sample];
}
@end