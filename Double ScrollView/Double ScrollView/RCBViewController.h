//
//  RCBViewController.h
//  Double ScrollView
//
//  Created by Jeroen Vloothuis on 30-04-14.
//  Copyright (c) 2014 Jeroen Vloothuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end
