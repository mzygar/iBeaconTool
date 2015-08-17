//
// Created by Michal Zygar on 16.08.15.
// Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "RangeSample.h"


@implementation RangeSample {

}
- (instancetype)initWithSampleIndex:(NSInteger)sampleIndex value:(CLLocationAccuracy)value {
    self = [super init];
    if (self) {
        self.index = sampleIndex;
        self.value = value;
    }
    return self;
}


+ (instancetype)sampleWithIndex:(NSInteger)sampleIndex andValue:(CLLocationAccuracy)value {
    return [[self alloc] initWithSampleIndex:sampleIndex value:value];
}
@end