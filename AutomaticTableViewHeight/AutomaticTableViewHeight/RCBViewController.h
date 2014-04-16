//
//  RCBViewController.h
//  AutomaticTableViewHeight
//
//  Created by Jeroen Vloothuis on 16-04-14.
//  Copyright (c) 2014 Jeroen Vloothuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *fewRows;
@property (weak, nonatomic) IBOutlet UIButton *manyRows;

@end
