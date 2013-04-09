//
//  ControlsViewController.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ControlsViewController.h"

@interface ControlsViewController ()

@end

@implementation ControlsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Controls";
    
    __typeof (&*self) __weak weakSelf = self;
    
    // Create manager
    //
    _manager = [[RETableViewManager alloc] init];
    _manager.style.textFieldPositionOffset = CGSizeMake(0, 0);
    
    // Set delegate and datasource
    //
    self.tableView.dataSource = _manager;
    self.tableView.delegate = _manager;

    // Create section
    //
    RETableViewSection *section = [[RETableViewSection alloc] initWithHeaderTitle:@"Basic controls"];
    [_manager addSection:section];
    
    // Add items to this section
    //
    [section addItem:@"Simple NSString"];
    
    RETextItem *fullLengthField = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];
    [section addItem:fullLengthField];
    
    [section addItem:[RETextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"]];
    [section addItem:[RENumberItem itemWithTitle:@"Phone" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"]];
    
    RETextItem *passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password item"];
    passwordItem.secureTextEntry = YES;
    [section addItem:passwordItem];
    
    [section addItem:[REBoolItem itemWithTitle:@"Bool item" value:YES]];
    
    [section addItem:[REFloatItem itemWithTitle:@"Float item" value:0.3 actionBlock:^(REFloatItem *item) {
        NSLog(@"Value: %f", item.value);
    }]];
    
    [section addItem:[REDateTimeItem itemWithTitle:@"Date / Time" value:[NSDate date] format:@"MM/dd/yyyy hh:mm a" datePickerMode:UIDatePickerModeDateAndTime]];
    
    RERadioItem *optionItem = [RERadioItem itemWithTitle:@"Radio" value:@"Option 4" actionBlock:^(RERadioItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %i", i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options completionHandler:^(RETableViewItem *selectedItem) {
            item.value = selectedItem.title;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    [section addItem:optionItem];
    
    section = [[RETableViewSection alloc] initWithHeaderTitle:@"Credit card"];
    [_manager addSection:section];
    [section addItem:[RECreditCardItem item]];
    
    // ------
    
    // Create another section
    //
    RETableViewSection *section2 = [[RETableViewSection alloc] initWithHeaderTitle:@"Accessories"];
    [_manager addSection:section2];
    
    // Add items to this section
    //
    [section2 addItem:[RETableViewItem itemWithTitle:@"Accessory 1" accessoryType:UITableViewCellAccessoryDisclosureIndicator actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
    }]];
    
    [section2 addItem:[RETableViewItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryDetailDisclosureButton actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
    } accessoryButtonActionBlock:^(RETableViewItem *item) {
        NSLog(@"Accessory button in accessoryItem2 was tapped");
    }]];
    
    [section2 addItem:[RETableViewItem itemWithTitle:@"Accessory 2" accessoryType:UITableViewCellAccessoryCheckmark actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
    }]];
    
    RETableViewSection *section3 = [[RETableViewSection alloc] init];
    [_manager addSection:section3];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"Test button" accessoryType:UITableViewCellAccessoryNone actionBlock:^(RETableViewItem *item) {
        [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        NSLog(@"Button pressed");
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section3 addItem:buttonItem];
}

@end