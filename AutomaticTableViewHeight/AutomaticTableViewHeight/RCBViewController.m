//
//  RCBViewController.m
//  AutomaticTableViewHeight
//
//  Created by Jeroen Vloothuis on 16-04-14.
//  Copyright (c) 2014 Jeroen Vloothuis. All rights reserved.
//

#import "RCBViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RCBViewController ()

@property (nonatomic) NSInteger itemCount;

@end

@implementation RCBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Reactive Cocoa setup for resizing the table view
    RAC(self.tableViewHeightConstraint, constant) = [RACObserve(self.tableView, contentSize) map:^id(NSValue *value) {
        return @(value.CGSizeValue.height);
    }];
    RAC(self.tableView, scrollEnabled) = [RACSignal combineLatest:@[RACObserve(self.tableView, bounds), RACObserve(self.tableView, contentSize)] reduce:^(NSValue *tableBounds, NSValue *contentSize) {
        return @(tableBounds.CGRectValue.size.height < contentSize.CGSizeValue.height);
    }];

    // Reactive Cocoa setup to make the buttons work
    self.fewRows.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal return:@2];
    }];
    self.manyRows.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal return:@10];
    }];
    RAC(self, itemCount) = [RACSignal merge:@[self.fewRows.rac_command.executionSignals.flatten, self.manyRows.rac_command.executionSignals.flatten]];

    __weak typeof(self) weakSelf = self;
    [RACObserve(self, itemCount) subscribeNext:^(id x) {
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell: %d", indexPath.row + 1];
    return cell;
}

@end
