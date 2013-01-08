//
//  SpriteSheetTool.m
//  BasicCocos2D
//
//  Created by Ian Fan on 20/08/12.
//
//

#import "SpriteSheetTool.h"

@implementation SpriteSheetTool

+(id)sharedInstance{
  static id shared = nil;
  if (shared == nil) shared = [[self alloc]init];
  
  return shared;
}

-(id)init {
  if ((self = [super init])) {
  }
  
  return self;
}

-(CCAction*)actionWithPlistPngName:(NSString*)plistPngName plistPngsAmount:(int)plistPngsAmount framesDelay:(ccTime)framesDelay {
  // Frame Array
  NSMutableArray *framesMutableArray = [NSMutableArray array];
  
  int total;
  if (plistPngsAmount <= 0) total = 999; //foolproof
  else total = plistPngsAmount;
  
  float delay;
  if (framesDelay <= 0) delay = 0.1; //foolproof
  else delay = framesDelay;
  
  for (int i=1; i<=total; i++) {
    NSString *frameNameString = [NSString stringWithFormat:@"%@%d.png",plistPngName,i];
    CCSpriteFrame *spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:frameNameString];
    
    if (spriteFrame != nil) [framesMutableArray addObject:spriteFrame];
    else break; //foolproof
  }
  
  // Animation Object
  CCAnimation *animation = [CCAnimation animationWithSpriteFrames:framesMutableArray delay:delay];
  
  // Animation Action
  CCAction *action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
  
  return action;
}

-(CCSprite*)spriteWithPlistPngName:(NSString*)plistPngName  defaultPngName:(NSString*)defaultPngName position:(CGPoint)position self:(id)selfObject {
  // Spirte
  CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@1.png",plistPngName]];
  sprite.position = position;
  
  // BatchNode
  CCSpriteBatchNode *spriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png",defaultPngName]];
  [selfObject addChild:spriteBatchNode];
  [spriteBatchNode addChild:sprite];
  
  return sprite;
}

-(void)addPlistToSpriteFrameCacheWithPlistName:(NSString*)plistName {
  [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",plistName]];
}

-(void)removePlistFromSpriteFrameCacheWithPlistName:(NSString*)plistName {
  [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:[NSString stringWithFormat:@"%@.plist",plistName]];
}

@end
