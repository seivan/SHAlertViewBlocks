//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#pragma mark -
#pragma mark Block Defs
typedef void (^SHAlertViewBlock)(NSUInteger theButtonIndex);
typedef void (^SHActionSheetShowBlock)(UIActionSheet * theActionSheet);
typedef void (^SHActionSheetDismissBlock)(UIActionSheet * theActionSheet, NSUInteger theButtonIndex);

@interface UIAlertView (SHAlertViewBlocks)

#pragma mark -
#pragma mark Init
+(instancetype)SH_alertViewWithTitle:(NSString *)theTitle withMessage:(NSString *)theMessage;


#pragma mark -
#pragma mark Add
-(NSUInteger)SH_addButtonWithTitle:(NSString *)theTitle
                      withBlock:(SHAlertViewBlock)theBlock;

-(NSUInteger)SH_setDestructiveButtonWithTitle:(NSString *)theTitle
                                 withBlock:(SHAlertViewBlock)theBlock;

-(NSUInteger)SH_setCancelButtonWithTitle:(NSString *)theTitle
                            withBlock:(SHAlertViewBlock)theBlock;

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowBlock:(SHActionSheetShowBlock)theBlock;
-(void)SH_setDidShowBlock:(SHActionSheetShowBlock)theBlock;

-(void)SH_setWillDismissBlock:(SHActionSheetDismissBlock)theBlock;
-(void)SH_setDidDismissBlock:(SHActionSheetDismissBlock)theBlock;

#pragma mark -
#pragma mark Getters



@property(nonatomic,readonly) SHActionSheetShowBlock    SH_blockWillShow;
@property(nonatomic,readonly) SHActionSheetShowBlock    SH_blockDidShow;

@property(nonatomic,readonly) SHActionSheetDismissBlock SH_blockWillDismiss;
@property(nonatomic,readonly) SHActionSheetDismissBlock SH_blockDidDismiss;

@end
