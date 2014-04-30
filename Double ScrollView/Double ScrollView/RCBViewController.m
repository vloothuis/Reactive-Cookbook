//
//  RCBViewController.m
//  Double ScrollView
//
//  Created by Jeroen Vloothuis on 30-04-14.
//  Copyright (c) 2014 Jeroen Vloothuis. All rights reserved.
//

#import "RCBViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RCBViewController ()

@end

@implementation RCBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Bind the two scroll views to each other
    RACChannelTerminal *leftChannel = RACChannelTo(self.leftTableView, contentOffset);
    RACChannelTerminal *rightChannel = RACChannelTo(self.rightTableView, contentOffset);
    [[rightChannel map:^id(NSValue *offset) {
        CGPoint point = offset.CGPointValue;
        point.y /= 10;
        return [NSValue valueWithCGPoint:point];
    }] subscribe:leftChannel];
    [[leftChannel map:^id(NSValue *offset) {
        CGPoint point = offset.CGPointValue;
        point.y *= 10;
        return [NSValue valueWithCGPoint:point];
    }] subscribe:rightChannel];


//    leftChannel.leadingTerminal
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 100;
    }
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    return cell;
}

@end
