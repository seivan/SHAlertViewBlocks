//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/28/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"
#import "SHAlertViewBlocks.h"


@interface SHSecondViewController ()
-(void)popUpAlert;
-(void)popUpAlertAgain;
@end

@implementation SHSecondViewController

-(void)viewDidAppear:(BOOL)animated; {
  self.view.backgroundColor = [UIColor blackColor];
  [self popUpActionSheet];
}

-(void)popUpAlertAgain; {
  UIAlertView * alert = [UIAlertView SH_alertViewWithTitle:@"New Title" andMessage:@"Message" buttonTitles:@[@"First", @"Second"] cancelTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
    SHBlockAssert(theButtonIndex >= 0, @"Button Index is more or equal to 0");
  }];
  
  SHBlockAssert(alert.numberOfButtons == 3 , @"Must have 3 buttons");
  SHBlockAssert(alert.SH_blockForCancelButton != nil , @"Cancel has a block");
  SHBlockAssert(alert.cancelButtonIndex == 2 , @"Cancel index is 2");
  [alert show];
}

-(void)popUpAlert; {
  NSString * title = @"Sample";
  
  __weak typeof(self) weakSelf = self;
  
  UIAlertView * alert = [UIAlertView SH_alertViewWithTitle:title withMessage:nil];
  SHBlockAssert(alert, @"Instance of a sheet");
  SHBlockAssert([alert.title isEqualToString:title], @"Title should be set");
  SHBlockAssert(alert.message == nil, @"Title should be set");
  
  SHAlertViewBlock block = ^(NSUInteger theButtonIndex) {
    SHBlockAssert(theButtonIndex >= 0, @"Must have a buttonIndex");
    [weakSelf popUpAlertAgain];
  };
  
  [alert addButtonWithTitle:@"Button 0"];
  [alert addButtonWithTitle:@"Button 1"];
  [alert addButtonWithTitle:@"Button 2"];
  SHBlockAssert([alert SH_blockForButtonIndex:0] == nil, @"Button Index 0 has no block");
  SHBlockAssert([alert SH_blockForButtonIndex:1] == nil, @"Button Index 1 has no block");
  SHBlockAssert([alert SH_blockForButtonIndex:2] == nil, @"Button Index 1 has no block");
  
  [alert SH_setButtonBlockForIndex:0 withBlock:block];
  [alert SH_setButtonBlockForIndex:1 withBlock:block];
  [alert SH_setButtonBlockForIndex:2 withBlock:block];
  
  [alert SH_addButtonWithTitle:@"Block button" withBlock:block];
  
  SHBlockAssert([alert SH_blockForButtonIndex:2] == block, @"Button Index 4 has a block");
  
  [alert addButtonWithTitle:@"Cancel"];
  
  alert.cancelButtonIndex = 4;
  [sheet SH_setButtonCancelBlock:block];
  [sheet SH_setButtonDestructiveBlock:block];
  SHBlockAssert([sheet SH_blockForButtonIndex:4] == [sheet SH_blockForCancelButton],
                @"Button Index 5 should be equal to SH_blockForCancel");
  SHBlockAssert([sheet SH_blockForButtonIndex:5] == [sheet SH_blockForCancelButton],
                @"Button Index 6 should be equal to SH_blockForDestructive");
  
  SHBlockAssert(block == [sheet SH_blockForCancelButton],
                @"Button Index 5 should be equal to SH_blockForCancel");
  SHBlockAssert(block == [sheet SH_blockForCancelButton],
                @"Button Index 6 should be equal to SH_blockForDestructive");
  
  [sheet addButtonWithTitle:@"Weird button"];
  
  
  [sheet showInView:self.view];
  
}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
  
}

@end
