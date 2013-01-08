//
//  SpriteSheetLayer.m
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteSheetLayer.h"
#import "SpriteSheetTool.h"

@implementation SpriteSheetLayer

@synthesize mySprite,actingAction,moveAction;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	SpriteSheetLayer *layer = [SpriteSheetLayer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark -
#pragma mark Touch Event

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint touchLocation = [touch locationInView:[touch view]];
  touchLocation = [[CCDirector sharedDirector]convertToGL:touchLocation];
  
  [self moveSpriteToPosition:touchLocation];
}

#pragma mark -
#pragma mark Move Sprite

-(void)moveSpriteToPosition:(CGPoint)position {
  float velocity = 160;
  
  CGPoint moveDifference = ccpSub(position, mySprite.position);
  float distanceToMove = ccpLength(moveDifference);
  float moveDuration = distanceToMove / velocity;
  
  //make a turn?
  mySprite.flipX = moveDifference.x < 0 ? NO : YES;
  
  if (isMoving == NO) {
    [mySprite stopAllActions];
    [mySprite runAction:actingAction];
  }
  
  [mySprite stopAction:moveAction];
  
  self.moveAction = [CCSequence actions:
                     [CCMoveTo actionWithDuration:moveDuration position:position],
                     [CCCallFunc actionWithTarget:self selector:@selector(moveEnded)],
                     nil];
  [mySprite runAction:moveAction];
  
  isMoving = YES;
}

-(void)moveEnded {
  if (shouldStopActingWhenMoveEnded) [mySprite stopAction:actingAction];
  
  isMoving = NO;
}

#pragma mark -
#pragma mark Set SpriteSheet

-(void)setSpriteSheet {
  CGSize screenSize = [CCDirector sharedDirector].winSize;
  
  // Cache plist first
  [[SpriteSheetTool sharedInstance] addPlistToSpriteFrameCacheWithPlistName:@"eagle"];
  
  // Action
  // use pngName in plist to generate pngName1 ~ pngNameXX
  // use self.xxx to avoid autorelease object become nil
  self.actingAction = [[SpriteSheetTool sharedInstance] actionWithPlistPngName:@"eagle" plistPngsAmount:10 framesDelay:0.1];
  
  // Sprite
  // use pngName in plist to create sprite
  // use defaultPngName to be added on spriteBatchNode
  self.mySprite = [[SpriteSheetTool sharedInstance] spriteWithPlistPngName:@"eagle" defaultPngName:@"eagle" position:ccp(screenSize.width, screenSize.height/2) self:self];
  
  shouldStopActingWhenMoveEnded = NO;
  if (shouldStopActingWhenMoveEnded == NO) [mySprite runAction:actingAction];
  
  [self moveSpriteToPosition:ccp(screenSize.width/2, screenSize.height/2)];
}

/*
 Target: Set SpriteSheet with SpriteSheetTool Conveniently.
 
 1. Use SpriteSheetTool to cache plist
 2. Use SpriteSheetTool to set plistPng for action
 3. Use SpriteSheetTool to set defaultPng for sprite
 4. Run action.
 */

#pragma mark -
#pragma mark Init

-(id) init
{
	if( (self=[super initWithColor:ccc4(211, 211, 211, 255)])) {
    [self setSpriteSheet];
    
    self.isTouchEnabled = YES;
	}
	return self;
}

-(void)onExit {
  //set self.moveAction=nil in -(void)onExit, otherwise -(void)dealloc will not be called after moving
  self.moveAction = nil;
}

-(void)dealloc
{
  self.mySprite = nil;
  self.actingAction = nil;
  self.moveAction = nil;
  
  [[SpriteSheetTool sharedInstance] removePlistFromSpriteFrameCacheWithPlistName:@"eagle"];
  
	[super dealloc];
}

@end
