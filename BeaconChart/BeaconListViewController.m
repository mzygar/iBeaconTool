//
//  BeaconListViewController.m
//  BeaconChart
//
//  Created by Michal Zygar on 14.08.2015.
//  Copyright (c) 2015 WIMZ. All rights reserved.
//

#import "BeaconListViewController.h"
#import "BeaconTableViewCell.h"
#import "BeaconScanner.h"

static NSString *const BEACON_CELL_ID = @"beaconCell";

@interface BeaconListViewController () <BeaconScannerDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *beacons;
@property(nonatomic, strong) BeaconScanner *scanner;
@end

@implementation BeaconListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanner = [BeaconScanner estimoteScannerWithDelegate:self];
    [self.scanner startRangingBeacons];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)refresh:(id)sender {
    [self.scanner startRangingBeacons];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BEACON_CELL_ID forIndexPath:indexPath];
    CLBeacon *beacon = self.beacons[(NSUInteger) indexPath.row];
    cell.devicename.text = @"unknown";
    cell.major.text = [beacon.major stringValue];
    cell.minor.text = [beacon.minor stringValue];
    cell.distance.text = [NSString stringWithFormat:@"%.2f m", beacon.accuracy];
    return cell;
}

- (void)beaconScanner:(BeaconScanner *)scanner didRangeBeacons:(NSArray *)beacons {
    [self.scanner stopRangingBeacons];
    self.beacons = beacons;
    [self.tableView reloadData];
    
}

@end
