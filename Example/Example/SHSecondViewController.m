////
////  SHSecondViewController.m
////  Example
////
////  Created by Seivan Heidari on 5/28/13.
////  Copyright (c) 2013 Seivan Heidari. All rights reserved.
////
//
//#import "SHSecondViewController.h"
//#import "SHAlertViewBlocks.h"
//
//
//@interface SHSecondViewController ()
//-(void)popUpActionSheet;
//@end
//
//@implementation SHSecondViewController
//
//-(void)viewDidAppear:(BOOL)animated; {
//  self.view.backgroundColor = [UIColor blackColor];
//  [self popUpActionSheet];
//}
//
//
//
//-(void)popUpActionSheet; {
//  NSString * title = @"Sample";
//  
//  UIAlertView * alert = [UIAlertView SH_alertViewWithTitle:title withMessage:nil];
//  SHBlockAssert(alert, @"Instance of a sheet");
//  SHBlockAssert([alert.title isEqualToString:title], @"Title should be set");
//  
//  
//  for (NSUInteger i = 0; i != 3; i++) {
//    NSString * title = [NSString stringWithFormat:@"Button %d", i];
//    [sheet SH_addButtonWithTitle:title withBlock:^(NSUInteger theButtonIndex) {
//      NSString * buttonTitle = [sheet buttonTitleAtIndex:theButtonIndex];
//      SHBlockAssert([title isEqualToString:buttonTitle], @"Button title is set");
//    }];
//  }
//  
//  NSUInteger cancelIndex      = 3;
//  NSUInteger destructiveIndex = 4;
//  
//  [sheet SH_setCancelButtonWithTitle:@"Cancel" withBlock:^(NSUInteger theButtonIndex) {
//    NSLog(@"Cancel");
//    SHBlockAssert(theButtonIndex == cancelIndex ,
//                  @"Cancel button index is 3");
//  }];
//  
//  SHBlockAssert(sheet.cancelButtonIndex == cancelIndex ,
//                @"Cancel button index is 3");
//  
//  [sheet SH_setDestructiveButtonWithTitle:@"Destroy" withBlock:^(NSUInteger theButtonIndex) {
//    NSLog(@"Destroy");
//    SHBlockAssert(theButtonIndex == destructiveIndex ,
//                  @"Destructive button index is 4");
//  }];
//  
//  SHBlockAssert(sheet.destructiveButtonIndex == destructiveIndex ,
//                @"Destructive button index 4");
//  
//  [sheet addButtonWithTitle:@"Weird button"];
//  
//  [sheet showInView:self.view];
//  
//}
//
//-(IBAction)unwinder:(UIStoryboardSegue *)theSegue; {
//  
//}
//
//@end
