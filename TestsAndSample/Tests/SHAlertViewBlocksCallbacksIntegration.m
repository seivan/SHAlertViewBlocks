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
  XCTAssertTrue(didCallCancel);

  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:@"cancel" withBlock:^(NSInteger theButtonIndex) {
    if (self.alertView.cancelButtonIndex == theButtonIndex)
      didCallCancel = YES;
    else
      didCallButton = YES;
    
  }];

  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallButton);
  
  
  
}

-(void)testSH_addButtonWithTitle_withBlock; {
  __block BOOL didCallButton = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallButton = YES;
  }];
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallButton);
}

-(void)testSH_addButtonCancelWithTitle_withBlock; {
  __block BOOL didCallButton = NO;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallButton = YES;
  }];
  [self.alertView show];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallButton);
  
}

-(void)testSH_addButtonCancelWithTitle_withBlockSecond; {
  __block BOOL didCallFirstCancel   = NO;
  __block BOOL didCallSecondCancel = NO;
  [self.alertView SH_addButtonCancelWithTitle:@"FirstCancel" withBlock:^(NSInteger theButtonIndex) {
    didCallFirstCancel = YES;
  }];
  
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallSecondCancel = YES;
  }];
  [self.alertView show];
  //[self.alertView SH_blockForCancelButton](self.alertView.cancelButtonIndex);
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallSecondCancel);
  XCTAssertFalse(didCallFirstCancel);
  
}

-(void)testSH_setButtonBlockForIndex_withBlock; {
  __block BOOL didCallFirstBlock   = NO;
  __block BOOL didCallSecondBlock  = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallFirstBlock = YES;
  }];
  
  [self.alertView SH_setButtonBlockForIndex:0 withBlock:^(NSInteger theButtonIndex) {
    XCTAssertEqual(theButtonIndex, 0);
    didCallSecondBlock = YES;
  }];
  
  [self.alertView show];
  [tester waitForTimeInterval:1];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallSecondBlock);
  XCTAssertFalse(didCallFirstBlock);
}

-(void)testSH_setButtonCancelBlock; {
  __block BOOL didCallFirstBlock   = NO;
  __block BOOL didCallSecondBlock  = NO;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:^(NSInteger theButtonIndex) {
    didCallFirstBlock = YES;
  }];
  
  
  [self.alertView SH_setButtonCancelBlock:^(NSInteger theButtonIndex) {
    XCTAssertEqual(theButtonIndex, 0);
    didCallSecondBlock = YES;
  }];

  [self.alertView show];
  
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallSecondBlock);
  XCTAssertFalse(didCallFirstBlock);
}


-(void)testSH_setWillShowBlock; {
  __block BOOL didCallBlock   = NO;

  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
    XCTAssertEqualObjects(self.alertView, theAlertView);
    didCallBlock = YES;
  
  };
  [self.alertView SH_setWillShowBlock:block];
  [self.alertView show];
  [tester waitForTimeInterval:1];
  [tester waitForViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallBlock);
  
}

-(void)testSH_setDidShowBlock; {
  __block BOOL didCallBlock   = NO;
  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
    XCTAssertEqualObjects(self.alertView, theAlertView);
    didCallBlock = YES;
  };
  [self.alertView SH_setDidShowBlock:block];
  [self.alertView show];
  

  [tester waitForViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallBlock);
}

-(void)testSH_setWillDismissBlock; {
  __block BOOL didCallBlock   = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    XCTAssertEqualObjects(self.alertView, theAlertView);
    didCallBlock = YES;
  };
  [self.alertView SH_setWillDismissBlock:block];
  [self.alertView show];
  [tester waitForTimeInterval:1];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallBlock);
  
  
}
-(void)testSH_setDidDismissBlock; {
  __block BOOL didCallBlock   = NO;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    XCTAssertEqualObjects(self.alertView, theAlertView);
    didCallBlock = YES;
  };
  [self.alertView SH_setDidDismissBlock:block];
  [self.alertView show];
  [tester waitForTimeInterval:1];
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallBlock);
}

-(void)testSH_setFirstButtonEnabledBlock; {
  __block BOOL didCallBlock   = NO;
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Some title" andMessage:@"Some MEssage" buttonTitles:@[self.buttonTitle] cancelTitle:nil withBlock:^(NSInteger theButtonIndex) {
    didCallBlock = YES;
  }];
  
  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
    XCTAssertEqual(self.alertView, theAlertView);
    return [[[theAlertView textFieldAtIndex:0] text] isEqualToString:@"seivan"];
  };
  [self.alertView SH_setFirstButtonEnabledBlock:block];
  self.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
  [self.alertView show];
  [tester waitForTimeInterval:1];
  [tester enterTextIntoCurrentFirstResponder:@"seivan"];
  
  [tester tapViewWithAccessibilityLabel:self.buttonTitle];
  XCTAssertTrue(didCallBlock);
}
@end
