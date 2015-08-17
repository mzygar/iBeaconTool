//
//  ChartViewController.m
//  BeaconChart
//
//  Created by Michal Zygar on 14.08.2015.
//  Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "ChartViewController.h"
#import "BeaconScanner.h"
#import "RangeChartDataManager.h"


@import Charts;

@interface ChartViewController () <ChartViewDelegate>
@property(weak, nonatomic) IBOutlet UIBarButtonItem *toggleItem;
@property(nonatomic, weak) IBOutlet LineChartView *chart;
@property(nonatomic, strong) RangeChartDataManager *chartDataManager;
@property(nonatomic) BOOL isRanging;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chart.delegate = self;
    self.chart.rightAxis.enabled = NO;
    self.chart.pinchZoomEnabled = YES;
    self.chart.descriptionText = NSLocalizedString(@"if distance if <0.0 then it cannot be determined", @"chart description");
    self.chartDataManager = [[RangeChartDataManager alloc] initWithChart:self.chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleRangingStatus:(id)sender {
    self.isRanging = !self.isRanging;
    if (self.isRanging) {
        [self.chartDataManager startRanging];
    } else {
        [self.chartDataManager stopRanging];
    }
    [self updateToggleItem];
}

- (void)updateToggleItem {
    if (self.isRanging) {
        self.toggleItem.title = NSLocalizedString(@"Stop", @"");
    } else {
        self.toggleItem.title = NSLocalizedString(@"Start", @"");
    }
}

@end
