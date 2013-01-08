//
//  SpriteSheetTool.h
//  BasicCocos2D
//
//  Created by Ian Fan on 20/08/12.
//
//

#import "cocos2d.h"

@interface SpriteSheetTool : NSObject

+(id)sharedInstance;

-(void)addPlistToSpriteFrameCacheWithPlistName:(NSString*)plistName;
-(void)removePlistFromSpriteFrameCacheWithPlistName:(NSString*)plistName;

-(CCAction*)actionWithPlistPngName:(NSString*)plistPngName plistPngsAmount:(int)plistPngsAmount framesDelay:(ccTime)framesDelay;
-(CCSprite*)spriteWithPlistPngName:(NSString*)plistPngName  defaultPngName:(NSString*)defaultPngName position:(CGPoint)position self:(id)selfObject;

@end
