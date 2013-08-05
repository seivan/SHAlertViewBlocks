//
//  SHActionSheetBlocksCallbacksScenarion.m
//  Example
//
//  Created by Seivan Heidari on 7/31/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHAlertViewBlocksSuper.h"


@interface SHAlertViewBlocksCallbacksIntegration : SHAlertViewBlocksSuper

@end

@implementation SHAlertViewBlocksCallbacksIntegration

-(void)testSH_alertViewWithTitle_andMessage_buttonTitles_cancelTitle_withBlock; {
  __block BOOL didCallCancel = NO;
  __block BOOL didCallButton = NO;
  
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[@"button"] cancelTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    if (self.alertView.cancelButtonIndex == theButtonIndex)
      didCallCancel = YES;
    else
      didCallButton = YES;
    
  }];
  
  
  
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallCancel, nil);

  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:@"cancel" withBlock:^(NSInteger theButtonIndex) {
    if (self.alertView.cancelButtonIndex == theButtonIndex)
      didCallCancel = YES;
    else
      didCallButton = YES;
    
  }];

  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallButton, nil);
  
  
  
}

-(void)testSH_addButtonWithTitle_withBlock; {
  __block BOOL didCallButton = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallButton = YES;
  }];
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallButton, nil);
}

-(void)testSH_addButtonCancelWithTitle_withBlock; {
  __block BOOL didCallButton = NO;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallButton = YES;
  }];
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallButton, nil);
  
}

-(void)testSH_addButtonCancelWithTitle_withBlockSecond; {
  __block BOOL didCallFirstCancel   = NO;
  __block BOOL didCallSecondCancel = NO;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallFirstCancel = YES;
  }];
  
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallSecondCancel = YES;
  }];
  [self.alertView show];
  //[self.alertView SH_blockForCancelButton](self.alertView.cancelButtonIndex);
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallSecondCancel, nil);
  STAssertFalse(didCallFirstCancel, nil);
  
}

-(void)testSH_setButtonBlockForIndex_withBlock; {
  __block BOOL didCallFirstBlock   = NO;
  __block BOOL didCallSecondBlock  = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallFirstBlock = YES;
  }];
  
  [self.alertView SH_setButtonBlockForIndex:0 withBlock:^(NSInteger theButtonIndex) {
    STAssertEquals(theButtonIndex, 0, nil);
    didCallSecondBlock = YES;
  }];
  
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallSecondBlock, nil);
  STAssertFalse(didCallFirstBlock, nil);
}

-(void)testSH_setButtonCancelBlock; {
  __block BOOL didCallFirstBlock   = NO;
  __block BOOL didCallSecondBlock  = NO;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallFirstBlock = YES;
  }];
  
  
  [self.alertView SH_setButtonCancelBlock:^(NSInteger theButtonIndex) {
    STAssertEquals(theButtonIndex, 0, nil);
    didCallSecondBlock = YES;
  }];

  [self.alertView show];
  
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallSecondBlock, nil);
  STAssertFalse(didCallFirstBlock, nil);
}


-(void)testSH_setWillShowBlock; {
  __block BOOL didCallBlock   = NO;

  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
    STAssertEqualObjects(self.alertView, theAlertView, nil);
    didCallBlock = YES;
  
  };
  [self.alertView SH_setWillShowBlock:block];
  [self.alertView show];
  [tester waitForViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallBlock, nil);
  
}

-(void)testSH_setDidShowBlock; {
  __block BOOL didCallBlock   = NO;
  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
    STAssertEqualObjects(self.alertView, theAlertView, nil);
    didCallBlock = YES;
  };
  [self.alertView SH_setDidShowBlock:block];
  [self.alertView show];
  

  [tester waitForViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallBlock, nil);
}

-(void)testSH_setWillDismissBlock; {
  __block BOOL didCallBlock   = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    STAssertEqualObjects(self.alertView, theAlertView, nil);
    didCallBlock = YES;
  };
  [self.alertView SH_setWillDismissBlock:block];
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallBlock, nil);
  
  
}
-(void)testSH_setDidDismissBlock; {
  __block BOOL didCallBlock   = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    STAssertEqualObjects(self.alertView, theAlertView, nil);
    didCallBlock = YES;
  };
  [self.alertView SH_setDidDismissBlock:block];
  [self.alertView show];

  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  STAssertTrue(didCallBlock, nil);
}

-(void)testSH_setFirstButtonEnabledBlock; {
  __block BOOL didCallBlock   = NO;
  __block NSInteger counter   = 0;
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Some title" andMessage:@"Some MEssage" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];
  
  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
    STAssertEquals(self.alertView, theAlertView, nil);
    didCallBlock = YES;
    return YES;
  };
  [self.alertView SH_setFirstButtonEnabledBlock:block];
  STAssertTrue(self.alertView.SH_blockForFirstButtonEnabled(self.alertView), nil);
  STAssertTrue(didCallBlock, nil);
  
}
//
//-(void)testSH_setFirstButtonEnabledBlockWithoutButton; {
//  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
//    return YES;
//  };
//  STAssertThrows([self.alertView SH_setFirstButtonEnabledBlock:block], nil);
//  STAssertNil(self.alertView.SH_blockForFirstButtonEnabled, nil);
//}
@end
