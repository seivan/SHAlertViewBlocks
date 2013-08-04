//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocksSuper.h"
@interface SHActionSheetBlocksCallbacks : SHActionSheetBlocksSuper

@end




@implementation SHActionSheetBlocksCallbacks

-(void)setUp; {
  [super setUp];
  self.block = ^(NSInteger theButtonIndex) {};
  self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"];
  self.vc = UIViewController.new;
  [UIApplication sharedApplication].keyWindow.rootViewController = self.vc;
  
  
}

-(void)tearDown; {
  [super tearDown];
}

-(void)testSeparateBlocksPerButton; {
  __block BOOL didCallCancelButton      = NO;
  __block BOOL didCallButtonOne         = NO;
  __block BOOL didCallButtonTwo         = NO;
  __block BOOL didCallDestructiveButton = NO;

//  [self SH_performAsyncTestsWithinBlock:^(BOOL *didFinish) {
    
    [self.sheet SH_addButtonCancelWithTitle:@"Cancel" withBlock:^(NSInteger theButtonIndex) {
      didCallCancelButton = YES;
      [self.sheet SH_blockForButtonIndex:1](1);
    }];
  
    [self.sheet SH_addButtonWithTitle:@"Button1" withBlock:^(NSInteger theButtonIndex) {
      didCallButtonOne = YES;
      [self.sheet SH_blockForButtonIndex:2](2);
    }];
  
    [self.sheet SH_addButtonWithTitle:@"Button2" withBlock:^(NSInteger theButtonIndex) {
      didCallButtonTwo = YES;
      self.sheet.SH_blockForDestructiveButton(self.sheet.destructiveButtonIndex);
    }];
  
    [self.sheet SH_addButtonDestructiveWithTitle:@"Delete" withBlock:^(NSInteger theButtonIndex) {
      didCallDestructiveButton = YES;
//      *didFinish = YES;
    
    }];
    
    self.sheet.SH_blockForCancelButton(self.sheet.cancelButtonIndex);
    
    
  
//    } withTimeout:5];

  STAssertTrue(didCallCancelButton, nil);
  STAssertTrue(didCallButtonOne, nil);
  STAssertTrue(didCallButtonTwo, nil);
  STAssertTrue(didCallDestructiveButton, nil);



}

-(void)testOneBlockForAllButtons; {
  __block BOOL didCallCancelButton      = NO;
  __block BOOL didCallButtonOne         = NO;
  __block BOOL didCallDestructiveButton = NO;

//  [self SH_performAsyncTestsWithinBlock:^(BOOL *didFinish) {
    self.sheet = [UIActionSheet SH_actionSheetWithTitle:@"Title"
                                           buttonTitles:@[@"Button1"]
                                            cancelTitle:@"Button2"
                                       destructiveTitle:@"Button0"
                                              withBlock:^(NSInteger theButtonIndex) {
                                                switch (theButtonIndex) {
                                                  case 0:
                                                    didCallDestructiveButton = YES;
                                                    break;
                                                  case 1:
                                                    didCallButtonOne = YES;
                                                    break;
                                                  case 2:
                                                    didCallCancelButton = YES;
                                                    break;
                                                  default:
                                                    break;
                                                }
                                                
                                                
                                              }];

//  } withTimeout:5];

  self.sheet.SH_blockForDestructiveButton(self.sheet.destructiveButtonIndex);
  STAssertTrue(didCallDestructiveButton, nil);
  
  [self.sheet SH_blockForButtonIndex:1](1);
  STAssertTrue(didCallButtonOne, nil);
  
  self.sheet.SH_blockForCancelButton(self.sheet.cancelButtonIndex);
  STAssertTrue(didCallCancelButton, nil);
}

-(void)testSheetAppearanceLifeCycleBlocks; {
  
  __block BOOL willShowBlock    = NO;
  __block BOOL didShowBlock     = NO;
  __block BOOL willDismissBlock = NO;
  __block BOOL didDismissBlock  = NO;

  
  [self.sheet SH_setWillShowBlock:^(UIActionSheet *theActionSheet) {
    willShowBlock = YES;
  }];
  
  [self.sheet SH_setDidShowBlock:^(UIActionSheet *theActionSheet) {
    didShowBlock = YES;
  }];
  
  [self.sheet SH_setWillDismissBlock:^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
    willDismissBlock = YES;
    STAssertEqualObjects(self.sheet, theActionSheet, nil);
    STAssertEquals(66, theButtonIndex, nil);
  }];
  
  [self.sheet SH_setDidDismissBlock:^(UIActionSheet *theActionSheet, NSInteger theButtonIndex) {
    didDismissBlock = YES;
    STAssertEqualObjects(self.sheet, theActionSheet, nil);
    STAssertEquals(66, theButtonIndex, nil);
  }];
  
  self.sheet.SH_blockWillShow(self.sheet);
  STAssertTrue(willShowBlock, nil);
  
  self.sheet.SH_blockDidShow(self.sheet);
  STAssertTrue(didShowBlock, nil);

  self.sheet.SH_blockWillDismiss(self.sheet, 66);
  STAssertTrue(willDismissBlock, nil);

  self.sheet.SH_blockDidDismiss(self.sheet, 66);
  STAssertTrue(didDismissBlock, nil);
  
  
}

@end
