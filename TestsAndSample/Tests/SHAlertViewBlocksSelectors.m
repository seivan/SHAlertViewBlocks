//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHAlertViewBlocksSuper.h"
@interface SHAlertViewBlocksSelectors : SHAlertViewBlocksSuper
@end



@implementation SHAlertViewBlocksSelectors

-(void)testHasSetDelegate; {
  XCTAssertNotNil(self.alertView.delegate);
}

-(void)testSetDelegateOnAddingButtons; {
  self.alertView.delegate = nil;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  XCTAssertNotNil(self.alertView.delegate);
  
  self.alertView.delegate = nil;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:self.block];
  XCTAssertNotNil(self.alertView.delegate);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setButtonBlockForIndex:0 withBlock:self.block];
  XCTAssertNotNil(self.alertView.delegate);

  self.alertView.delegate = nil;
  [self.alertView SH_setButtonCancelBlock:self.block];
  XCTAssertNotNil(self.alertView.delegate);
  
}

-(void)testSetDelegateOnLifeCycleCallbacks; {
  self.alertView.delegate = nil;
  [self.alertView SH_setWillShowBlock:^(UIAlertView *theAlertView) {
  }];
  XCTAssertNotNil(self.alertView.delegate);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setWillDismissBlock:^(UIAlertView *theAlertView, NSInteger theButtonIndex) {}];
  XCTAssertNotNil(self.alertView.delegate);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setDidShowBlock:^(UIAlertView *theAlertView) {}];
  XCTAssertNotNil(self.alertView.delegate);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setDidDismissBlock:^(UIAlertView *theAlertView, NSInteger theButtonIndex) {}];
  XCTAssertNotNil(self.alertView.delegate);

  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Some title" andMessage:@"Some MEssage" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];
  self.alertView.delegate = nil;
  [self.alertView SH_setDidDismissBlock:^(UIAlertView *theAlertView, NSInteger theButtonIndex) {}];
  XCTAssertNotNil(self.alertView.delegate);

  
}

-(void)testHasSetTitle; {
  XCTAssertNotNil(self.alertView.title);
}

-(void)testHasSetMessage; {
  XCTAssertNotNil(self.alertView.message);
}

-(void)testHasNoBlockFirstButtonEnabled; {
  XCTAssertNil(self.alertView.SH_blockForFirstButtonEnabled);
  XCTAssertEqual(self.alertView.firstOtherButtonIndex, -1);
}


-(void)testHasNoBlocks; {
  XCTAssertNil([self.alertView SH_blockForButtonIndex:0]);
}

-(void)testHasNoCancelButton; {
  XCTAssertNil(self.alertView.SH_blockForCancelButton);
  XCTAssertEqual(self.alertView.cancelButtonIndex, -1);
}

-(void)testSH_alertViewWithTitle_andMessage_buttonTitles_cancelTitle_withBlock; {
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];

  XCTAssertNotNil(self.alertView.delegate);
  XCTAssertNotNil(self.alertView.title);
  XCTAssertNotNil(self.alertView.message);

  XCTAssertNotNil(self.alertView.SH_blockForCancelButton);
  XCTAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:0]);
  XCTAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:1]);

  XCTAssertEqualObjects(self.block, self.alertView.SH_blockForCancelButton);
  
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:nil];

  XCTAssertNil(self.alertView.SH_blockForCancelButton);
  XCTAssertNil(self.alertView.SH_blockForCancelButton);
  
  XCTAssertEqual(self.alertView.firstOtherButtonIndex, 1);
  XCTAssertEqual(self.alertView.cancelButtonIndex, 0);

  
}

-(void)testSH_alertViewWithTitle_andMessage_buttonTitles_cancelTitle_withOutBlock; {
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:nil];
  XCTAssertNil(self.alertView.SH_blockForCancelButton);
  XCTAssertEqual(self.alertView.cancelButtonIndex, 0);

  
}

-(void)testSH_addButtonWithTitle_withBlock; {
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  XCTAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:0]);
}

-(void)testSH_addButtonCancelWithTitle_withBlock; {
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:self.block];
  XCTAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:0]);
  XCTAssertEqualObjects(self.block, self.alertView.SH_blockForCancelButton);
  XCTAssertEqual(self.alertView.cancelButtonIndex, 0);
  
}

-(void)testSH_addButtonCancelWithTitle_withBlockSecond; {
  [self testSH_addButtonCancelWithTitle_withBlock];
  SHAlertViewBlock block = ^void(NSInteger theButtonIndex) {};
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:block];
  XCTAssertEqualObjects(block, [self.alertView SH_blockForButtonIndex:1]);
  XCTAssertEqualObjects(block, self.alertView.SH_blockForCancelButton);
  XCTAssertEqual(self.alertView.cancelButtonIndex, 1);
}

-(void)testSH_setButtonBlockForIndex_withBlock; {
  [self testSH_addButtonWithTitle_withBlock];
  SHAlertViewBlock block = ^void(NSInteger theButtonIndex) {};
  [self.alertView SH_setButtonBlockForIndex:0 withBlock:block];
  XCTAssertEqualObjects([self.alertView SH_blockForButtonIndex:0], block);
}

-(void)testSH_setButtonCancelBlock; {
  [self testSH_addButtonCancelWithTitle_withBlock];
  SHAlertViewBlock block = ^void(NSInteger theButtonIndex) {};
  [self.alertView SH_setButtonCancelBlock:block];
  XCTAssertEqualObjects(self.alertView.SH_blockForCancelButton, block);
  XCTAssertEqual(self.alertView.cancelButtonIndex, 0);
}


-(void)testSH_setWillShowBlock; {
  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
  };
  [self.alertView SH_setWillShowBlock:block];
  XCTAssertEqualObjects(block, self.alertView.SH_blockWillShow);
  
}

-(void)testSH_setDidShowBlock; {
  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
  };
  [self.alertView SH_setDidShowBlock:block];
  XCTAssertEqualObjects(block, self.alertView.SH_blockDidShow);
  
}

-(void)testSH_setWillDismissBlock; {
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    
  };
  [self.alertView SH_setWillDismissBlock:block];
  XCTAssertEqualObjects(block, self.alertView.SH_blockWillDismiss);


}
-(void)testSH_setDidDismissBlock; {
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    
  };
  [self.alertView SH_setDidDismissBlock:block];
  XCTAssertEqualObjects(block, self.alertView.SH_blockDidDismiss);
  
}

-(void)testSH_setFirstButtonEnabledBlock; {
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Some title" andMessage:@"Some MEssage" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];
  
  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
    return YES;
  };
  [self.alertView SH_setFirstButtonEnabledBlock:block];
  XCTAssertEqualObjects(block, self.alertView.SH_blockForFirstButtonEnabled);
  
}
-(void)testSH_setFirstButtonEnabledBlockWithoutButton; {
  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
    return YES;
  };
  XCTAssertThrows([self.alertView SH_setFirstButtonEnabledBlock:block]);
  XCTAssertNil(self.alertView.SH_blockForFirstButtonEnabled);
}





@end
