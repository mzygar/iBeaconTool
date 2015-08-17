//
//  BeaconTableViewCell.h
//  BeaconChart
//
//  Created by Michal Zygar on 14.08.2015.
//  Copyright (c) 2015 WIMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconTableViewCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *devicename;
@property(weak, nonatomic) IBOutlet UILabel *major;
@property(weak, nonatomic) IBOutlet UILabel *minor;
@property(weak, nonatomic) IBOutlet UILabel *distance;

@end
