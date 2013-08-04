//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "KIF.h"
#import "SHTestCaseAdditions.h"
#import "SHAlertViewBlocks.h"




@interface SHAlertViewBlocksSuper : KIFTestCase

@property(nonatomic,strong) UIViewController    * vc;
@property(nonatomic,strong) UIAlertView         * alertView;
@property(nonatomic,strong) NSString            * buttonTitle;
@property(nonatomic,copy) SHAlertViewBlock        block;
@end

