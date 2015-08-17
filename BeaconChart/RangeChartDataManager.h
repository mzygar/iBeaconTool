//
//  RangeChartDataManager.h
//  BeaconChart
//
//  Created by Michal Zygar on 16.08.2015.
//  Copyright (c) 2015 WIMZ. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "BeaconScanner.h"

@class LineChartView;

@interface RangeChartDataManager : NSObject <BeaconScannerDelegate>
- (instancetype)initWithChart:(LineChartView *)chartView;

- (instancetype)initWithChart:(LineChartView *)chartView showingRegion:(CLBeaconRegion *)region;

- (void)startRanging;

- (void)stopRanging;
@end
