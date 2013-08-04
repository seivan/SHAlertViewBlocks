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
  
}

-(void)testSH_setDidShowBlock; {
    
}

-(void)testSH_setWillDismissBlock; {
  
}
-(void)testSH_setDidDismissBlock; {
  
}

-(void)testSH_setFirstButtonEnabledBlock; {
  
}





@end
