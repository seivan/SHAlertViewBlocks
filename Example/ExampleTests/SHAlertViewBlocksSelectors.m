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
  STAssertNotNil(self.alertView.delegate, nil);
}

-(void)testSetDelegateOnAddingButtons; {
  self.alertView.delegate = nil;
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  STAssertNotNil(self.alertView.delegate, nil);
  
  self.alertView.delegate = nil;
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:self.block];
  STAssertNotNil(self.alertView.delegate, nil);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setButtonBlockForIndex:0 withBlock:self.block];
  STAssertNotNil(self.alertView.delegate, nil);

  self.alertView.delegate = nil;
  [self.alertView SH_setButtonCancelBlock:self.block];
  STAssertNotNil(self.alertView.delegate, nil);
  
}

-(void)testSetDelegateOnLifeCycleCallbacks; {
  self.alertView.delegate = nil;
  [self.alertView SH_setWillShowBlock:^(UIAlertView *theAlertView) {
  }];
  STAssertNotNil(self.alertView.delegate, nil);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setWillDismissBlock:^(UIAlertView *theAlertView, NSInteger theButtonIndex) {}];
  STAssertNotNil(self.alertView.delegate, nil);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setDidShowBlock:^(UIAlertView *theAlertView) {}];
  STAssertNotNil(self.alertView.delegate, nil);
  
  self.alertView.delegate = nil;
  [self.alertView SH_setDidDismissBlock:^(UIAlertView *theAlertView, NSInteger theButtonIndex) {}];
  STAssertNotNil(self.alertView.delegate, nil);

  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Some title" andMessage:@"Some MEssage" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];
  self.alertView.delegate = nil;
  [self.alertView SH_setDidDismissBlock:^(UIAlertView *theAlertView, NSInteger theButtonIndex) {}];
  STAssertNotNil(self.alertView.delegate, nil);

  
}

-(void)testHasSetTitle; {
  STAssertNotNil(self.alertView.title, nil);
}

-(void)testHasSetMessage; {
  STAssertNotNil(self.alertView.message, nil);
}

-(void)testHasNoBlockFirstButtonEnabled; {
  STAssertNil(self.alertView.SH_blockForFirstButtonEnabled, nil);
  STAssertEquals(self.alertView.firstOtherButtonIndex, -1,nil);
}


-(void)testHasNoBlocks; {
  STAssertNil([self.alertView SH_blockForButtonIndex:0], nil);
}

-(void)testHasNoCancelButton; {
  STAssertNil(self.alertView.SH_blockForCancelButton, nil);
  STAssertEquals(self.alertView.cancelButtonIndex, -1, nil);
}

-(void)testSH_alertViewWithTitle_andMessage_buttonTitles_cancelTitle_withBlock; {
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];

  STAssertNotNil(self.alertView.delegate, nil);
  STAssertNotNil(self.alertView.title, nil);
  STAssertNotNil(self.alertView.message, nil);

  STAssertNotNil(self.alertView.SH_blockForCancelButton, nil);
  STAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:0], nil);
  STAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:1], nil);

  STAssertEqualObjects(self.block, self.alertView.SH_blockForCancelButton, nil);
  
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:nil];

  STAssertNil(self.alertView.SH_blockForCancelButton, nil);
  STAssertNil(self.alertView.SH_blockForCancelButton, nil);
  
  STAssertEquals(self.alertView.firstOtherButtonIndex, 1, nil);
  STAssertEquals(self.alertView.cancelButtonIndex, 0, nil);

  
}

-(void)testSH_alertViewWithTitle_andMessage_buttonTitles_cancelTitle_withOutBlock; {
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Title" andMessage:@"message" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:nil];
  STAssertNil(self.alertView.SH_blockForCancelButton, nil);
  STAssertEquals(self.alertView.cancelButtonIndex, 0, nil);

  
}

-(void)testSH_addButtonWithTitle_withBlock; {
  [self.alertView SH_addButtonWithTitle:self.buttonTitle withBlock:self.block];
  STAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:0], nil);
}

-(void)testSH_addButtonCancelWithTitle_withBlock; {
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:self.block];
  STAssertEqualObjects(self.block, [self.alertView SH_blockForButtonIndex:0], nil);
  STAssertEqualObjects(self.block, self.alertView.SH_blockForCancelButton, nil);
  STAssertEquals(self.alertView.cancelButtonIndex, 0, nil);
  
}

-(void)testSH_addButtonCancelWithTitle_withBlockSecond; {
  [self testSH_addButtonCancelWithTitle_withBlock];
  SHAlertViewBlock block = ^void(NSInteger theButtonIndex) {};
  [self.alertView SH_addButtonCancelWithTitle:self.buttonTitle withBlock:block];
  STAssertEqualObjects(block, [self.alertView SH_blockForButtonIndex:1], nil);
  STAssertEqualObjects(block, self.alertView.SH_blockForCancelButton, nil);
  STAssertEquals(self.alertView.cancelButtonIndex, 1, nil);
}

-(void)testSH_setButtonBlockForIndex_withBlock; {
  [self testSH_addButtonWithTitle_withBlock];
  SHAlertViewBlock block = ^void(NSInteger theButtonIndex) {};
  [self.alertView SH_setButtonBlockForIndex:0 withBlock:block];
  STAssertEqualObjects([self.alertView SH_blockForButtonIndex:0], block, nil);
}

-(void)testSH_setButtonCancelBlock; {
  [self testSH_addButtonCancelWithTitle_withBlock];
  SHAlertViewBlock block = ^void(NSInteger theButtonIndex) {};
  [self.alertView SH_setButtonCancelBlock:block];
  STAssertEqualObjects(self.alertView.SH_blockForCancelButton, block, nil);
  STAssertEquals(self.alertView.cancelButtonIndex, 0, nil);
}


-(void)testSH_setWillShowBlock; {
  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
  };
  [self.alertView SH_setWillShowBlock:block];
  STAssertEqualObjects(block, self.alertView.SH_blockWillShow, nil);
  
}

-(void)testSH_setDidShowBlock; {
  SHAlertViewShowBlock block = ^void(UIAlertView *theAlertView) {
  };
  [self.alertView SH_setDidShowBlock:block];
  STAssertEqualObjects(block, self.alertView.SH_blockDidShow, nil);
  
}

-(void)testSH_setWillDismissBlock; {
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    
  };
  [self.alertView SH_setWillDismissBlock:block];
  STAssertEqualObjects(block, self.alertView.SH_blockWillDismiss, nil);


}
-(void)testSH_setDidDismissBlock; {
  SHAlertViewDismissBlock block = ^void(UIAlertView *theAlertView, NSInteger theButtonIndex){
    
  };
  [self.alertView SH_setDidDismissBlock:block];
  STAssertEqualObjects(block, self.alertView.SH_blockDidDismiss, nil);
  
}

-(void)testSH_setFirstButtonEnabledBlock; {
  self.alertView = [UIAlertView SH_alertViewWithTitle:@"Some title" andMessage:@"Some MEssage" buttonTitles:@[self.buttonTitle] cancelTitle:self.buttonTitle withBlock:self.block];
  
  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
    return YES;
  };
  [self.alertView SH_setFirstButtonEnabledBlock:block];
  STAssertEqualObjects(block, self.alertView.SH_blockForFirstButtonEnabled, nil);
  
}
-(void)testSH_setFirstButtonEnabledBlockWithoutButton; {
  SHAlertViewFirstButtonEnabledBlock block = ^BOOL(UIAlertView * theAlertView) {
    return YES;
  };
  STAssertThrows([self.alertView SH_setFirstButtonEnabledBlock:block], nil);
  STAssertNil(self.alertView.SH_blockForFirstButtonEnabled, nil);
}





@end
