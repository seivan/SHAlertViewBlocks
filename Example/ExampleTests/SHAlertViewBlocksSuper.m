//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//



#import "SHAlertViewBlocksSuper.h"



@implementation SHAlertViewBlocksSuper

-(void)setUp; {
  UIViewController * vc = UIViewController.new;
  [UIApplication sharedApplication].keyWindow.rootViewController = vc;

  self.buttonTitle  = @"Some Button Title";
  self.alertView    = [UIAlertView SH_alertViewWithTitle:@"Some title" withMessage:self.buttonTitle];
  self.block        = ^void(NSInteger theButtonIndex) {};
  

}
@end

