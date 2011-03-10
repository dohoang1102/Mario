//
//  HelloWorldLayer.h
//  IceMario
//
//  Created by Maxime Lecomte on 04/03/11.
//  Copyright NA 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "HellowWorldHud.h"
#import "GeneralConstant.h"
#import "HUDPad.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
						<HUDDelegate>
{
	
	CCTMXTiledMap *tileMap;
	CCTMXLayer *background;
	CCTMXLayer *meta;
	CCTMXLayer *foreground;
	CCSprite *player;
	
	float xVel;
	float yVel;
	
	int numCollected;
	HellowWorldHud *hud;
}

@property (nonatomic, retain) HellowWorldHud *hud;
@property (nonatomic, assign) int numCollected;
@property (nonatomic, retain) CCTMXLayer *foreground;
@property (nonatomic, retain) CCTMXLayer *meta;
@property (nonatomic, retain) CCSprite *player;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic, retain) CCTMXTiledMap *tileMap;


// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
