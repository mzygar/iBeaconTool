//
//  RangeChartDataManager.m
//  BeaconChart
//
//  Created by Michal Zygar on 16.08.2015.
//  Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "RangeChartDataManager.h"
#import "BeaconRangeDataSet.h"
#import "RangeSample.h"
#import "CLBeaconRegion+EstimoteBeacons.h"

@import Charts;

@interface RangeChartDataManager ()
@property(nonatomic, strong) BeaconScanner *scanner;
@property(nonatomic, strong) NSMutableArray *measuredSamples;
@property(nonatomic) NSInteger currentSampleNumber;

@property(nonatomic, strong) NSMutableArray *xValues;

@property(nonatomic, weak) LineChartView *chartView;
@end


@implementation RangeChartDataManager


- (instancetype)initWithChart:(LineChartView *)chartView {
    return [self initWithChart:chartView showingRegion:[CLBeaconRegion estimoteDefaultRegion]];
}

- (instancetype)initWithChart:(LineChartView *)chartView showingRegion:(CLBeaconRegion *)region {
    self = [super init];
    if (self) {
        self.chartView = chartView;
        self.scanner = [[BeaconScanner alloc] initWithRegion:region delegate:self];
    }
    return self;
}

- (void)startRanging {
    [self resetSamples];
    [self.scanner startRangingBeacons];
}

- (void)stopRanging {
    [self.scanner stopRangingBeacons];
}

- (void)resetSamples {
    self.currentSampleNumber = 0;
    self.xValues = [NSMutableArray new];
    self.measuredSamples = [NSMutableArray new];

}

- (void)beaconScanner:(BeaconScanner *)scanner didRangeBeacons:(NSArray *)beacons {

    for (CLBeacon *beacon in beacons) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"beacon.major == %@ && beacon.minor == %@", beacon.major, beacon.minor];
        BeaconRangeDataSet *dataSet = [self.measuredSamples filteredArrayUsingPredicate:predicate].firstObject;
        if (!dataSet) {
            dataSet = [[BeaconRangeDataSet alloc] initWithBeacon:beacon];
            [self.measuredSamples addObject:dataSet];
        }
        [dataSet addSample:[RangeSample sampleWithIndex:self.currentSampleNumber andValue:beacon.accuracy]];
    }
    [self.xValues addObject:[NSString stringWithFormat:@"%ld", (long) self.currentSampleNumber]];
    self.currentSampleNumber++;

    [self updateChart];
}

- (void)updateChart {

    NSMutableArray *lineChartDataSets = [NSMutableArray new];
    for (BeaconRangeDataSet *dataSet in self.measuredSamples) {
        [lineChartDataSets addObject:[self lineChartDataSetWithBeaconData:dataSet]];

    }
    LineChartData *data = [[LineChartData alloc] initWithXVals:self.xValues dataSets:lineChartDataSets];
    self.chartView.data = data;

    [self.chartView setNeedsDisplay];

}

- (LineChartDataSet *)lineChartDataSetWithBeaconData:(BeaconRangeDataSet *)beaconRanges {
    NSString *label = [NSString stringWithFormat:@"%@/%@", beaconRanges.beacon.major, beaconRanges.beacon.minor];
    NSMutableArray *samples = [NSMutableArray new];
    for (RangeSample *sample in beaconRanges.samples) {
        [samples addObject:[[ChartDataEntry alloc] initWithValue:sample.value xIndex:sample.index]];
    }
    LineChartDataSet *lineChartDataSet = [[LineChartDataSet alloc] initWithYVals:samples label:label];
    lineChartDataSet.circleRadius = 3.0;

    UIColor *color = [self colorForBeaconDataSet:beaconRanges];
    lineChartDataSet.colors = @[color];
    lineChartDataSet.circleColors = @[color];
    return lineChartDataSet;
}

#pragma mark -
#pragma mark Chart Colors

- (UIColor *)colorForBeaconDataSet:(BeaconRangeDataSet *)beaconDataSet {
    NSInteger index = [self.measuredSamples indexOfObject:beaconDataSet];
    NSInteger colorCount = self.chartColors.count;
    return self.chartColors[index % colorCount];
}


- (NSArray *)chartColors {
    return @[
            [UIColor redColor],
            [UIColor blackColor],
            [UIColor blueColor],
            [UIColor greenColor],
            [UIColor orangeColor],
            [UIColor grayColor],
            [UIColor magentaColor],
            [UIColor yellowColor],
            [UIColor purpleColor],
            [UIColor cyanColor],
            [UIColor brownColor]

    ];
}

@end
