//
//  UIControl+SHControlEventBlock.h
//  Example
//
//  Created by Seivan Heidari on 5/16/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "UIAlertView+SHAlertViewBlocks.h"


static NSString * const SH_blockWillShow    = @"SH_blockWillShow";
static NSString * const SH_blockDidShow     = @"SH_blockDidShow";
static NSString * const SH_blockWillDismiss = @"SH_blockWillDismiss";
static NSString * const SH_blockDidDismiss  = @"SH_blockDidDismiss";

@interface UIAlertView ()
@property(nonatomic,strong) NSMutableDictionary * mapOfBlocks;
@end


@interface SHAlertViewBlocksManager : NSObject
<UIActionSheetDelegate>

@property(nonatomic,strong)   NSMapTable   * mapBlocks;

+(instancetype)sharedManager;
-(void)SH_memoryDebugger;
@end
@implementation SHAlertViewBlocksManager

#pragma mark -
#pragma mark Init & Dealloc
-(instancetype)init; {
  self = [super init];
  if (self) {
    self.mapBlocks            = [NSMapTable weakToStrongObjectsMapTable];
//    [self SH_memoryDebugger];
  }
  
  return self;
}

+(instancetype)sharedManager; {
  static SHAlertViewBlocksManager * _sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[SHAlertViewBlocksManager alloc] init];
    
  });
  
  return _sharedInstance;
  
}


#pragma mark -
#pragma mark Debugger
-(void)SH_memoryDebugger; {
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"MAP %@",self.mapBlocks);
    [self SH_memoryDebugger];
  });
}

#

#pragma mark -
#pragma mark <UIActionSheetDelegate>

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;{
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHAlertViewBlock block = mapBlocks[@(buttonIndex)];
  if(block)block(buttonIndex);
}


-(void)willPresentActionSheet:(UIActionSheet *)actionSheet;{
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetShowBlock block = mapBlocks[SH_blockWillShow];
  if(block) block(actionSheet);
  
}

-(void)didPresentActionSheet:(UIActionSheet *)actionSheet; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetShowBlock block = mapBlocks[SH_blockDidShow];
  if(block) block(actionSheet);

}


-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetDismissBlock block = mapBlocks[SH_blockWillDismiss];
  if(block) block(actionSheet, buttonIndex);

}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex; {
  NSDictionary * mapBlocks = [self.mapBlocks objectForKey:actionSheet];
  SHActionSheetDismissBlock block = mapBlocks[SH_blockDidDismiss];
  if(block) block(actionSheet, buttonIndex);
//  actionSheet.mapOfBlocks = nil;
}


@end


@interface UIActionSheet ()
@end

@interface UIActionSheet (Private)
-(void)addBlock:(SHAlertViewBlock)theBlock forIndex:(NSUInteger)theIndex;
-(void)addBlock:(id)theBlock forKey:(NSString *)theKey;
-(id)blockForKey:(NSString *)theKey;
@end




@implementation UIActionSheet (SHActionSheetBlocks)


#pragma mark -
#pragma mark Init
+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle; {
  return [[self alloc] initWithTitle:theTitle
                    delegate:[SHAlertViewBlocksManager sharedManager]
           cancelButtonTitle:nil
      destructiveButtonTitle:nil
           otherButtonTitles:nil, nil];

}


#pragma mark -
#pragma mark Add
-(NSUInteger)SH_addButtonWithTitle:(NSString *)theTitle
                         withBlock:(SHAlertViewBlock)theBlock; {
  NSUInteger indexButton = [self addButtonWithTitle:theTitle];
  [self addBlock:[theBlock copy]  forIndex:indexButton];
  return indexButton;
  
}



-(NSUInteger)SH_setDestructiveButtonWithTitle:(NSString *)theTitle
                                    withBlock:(SHAlertViewBlock)theBlock; {
  NSUInteger indexButton = [self SH_addButtonWithTitle:theTitle withBlock:theBlock];
  [self setDestructiveButtonIndex:indexButton];
  return indexButton;
  
}

-(NSUInteger)SH_setCancelButtonWithTitle:(NSString *)theTitle
                               withBlock:(SHAlertViewBlock)theBlock;{
  NSUInteger indexButton = [self SH_addButtonWithTitle:theTitle withBlock:theBlock];
  [self setCancelButtonIndex:indexButton];
  return indexButton;
  
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowBlock:(SHActionSheetShowBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockWillShow];
}

-(void)SH_setDidShowBlock:(SHActionSheetShowBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockDidShow];
}

-(void)SH_setWillDismissBlock:(SHActionSheetDismissBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockWillDismiss];
}

-(void)SH_setDidDismissBlock:(SHActionSheetDismissBlock)theBlock; {
  [self addBlock:theBlock forKey:SH_blockDidDismiss]; 
}


#pragma mark -
#pragma mark Getters
-(SHActionSheetShowBlock)SH_blockWillShow;{
  return self.mapOfBlocks[SH_blockWillShow];    
}

-(SHActionSheetShowBlock)SH_blockDidShow;{
  return self.mapOfBlocks[SH_blockDidShow];
}

-(SHActionSheetDismissBlock)SH_blockWillDismiss;{
  return self.mapOfBlocks[SH_blockWillDismiss];
}

-(SHActionSheetDismissBlock)SH_blockDidDismiss;{
  return self.mapOfBlocks[SH_blockDidDismiss];
}

#pragma mark -
#pragma mark Privates
-(void)addBlock:(SHAlertViewBlock)theBlock forIndex:(NSUInteger)theIndex; {
  if(theBlock) self.mapOfBlocks[@(theIndex)] = theBlock;
  else [self.mapOfBlocks removeObjectForKey:@(theIndex)];
}

-(void)addBlock:(id)theBlock forKey:(NSString *)theKey; {
  self.mapOfBlocks[theKey] = [theBlock copy];
}

-(id)blockForKey:(NSString *)theKey; {
  id block = self.mapOfBlocks[theKey];
  return block;
}

-(NSMutableDictionary *)mapOfBlocks; {
  NSMutableDictionary * mapOfBlocks =  [[SHAlertViewBlocksManager sharedManager].mapBlocks objectForKey:self];
  if(mapOfBlocks == nil) {
    mapOfBlocks = @{}.mutableCopy;
    self.mapOfBlocks = mapOfBlocks;
  }

  return mapOfBlocks;
}

-(void)setMapOfBlocks:(NSMutableDictionary *)mapOfBlocks; {
  if(mapOfBlocks)
    [[SHAlertViewBlocksManager sharedManager].mapBlocks setObject:mapOfBlocks forKey:self];
  else {
    [[SHAlertViewBlocksManager sharedManager].mapBlocks removeObjectForKey:self];
  }

}


@end

