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
  self.buttonTitle  = @"Some Button Title";
  self.alertView    = [UIAlertView SH_alertViewWithTitle:@"Some title" withMessage:self.buttonTitle];
  self.block        = ^void(NSInteger theButtonIndex) {};  
}
@end

