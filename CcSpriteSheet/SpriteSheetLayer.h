//
//  SpriteSheetLayer.h
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface SpriteSheetLayer : CCLayerColor
{
  BOOL isMoving;
  BOOL shouldStopActingWhenMoveEnded;
}

@property (nonatomic,retain) CCSprite *mySprite;
@property (nonatomic,retain) CCAction *actingAction;
@property (nonatomic,retain) CCAction *moveAction;

+(CCScene *) scene;

@end
