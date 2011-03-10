//
//  HelloWorldLayer.m
//  IceMario
//
//  Created by Maxime Lecomte on 04/03/11.
//  Copyright NA 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "HellowWorldHud.h"
#import "SimpleAudioEngine.h"
#import "HUDPad.h"

// HelloWorld implementation
@implementation HelloWorld

@synthesize hud;
@synthesize numCollected;
@synthesize foreground;
@synthesize meta;
@synthesize player;
@synthesize background;
@synthesize tileMap;


- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[tileMap release];
	tileMap = nil;
	
	[background release];
	background = nil;
	
	[player release];
	player = nil;
	
	[meta release];
	meta = nil;

	[foreground release];
	foreground = nil;


	[hud release];
	hud = nil;

	[super dealloc];
}

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	HUDPad *hud = [HUDPad node];
	hud.delegate = layer;
	[scene addChild:hud z:1000];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		//self.isTouchEnabled = YES;
		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"pickup.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"hit.caf"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"move.caf"];
		//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"TileMap.caf"];
		
		
		self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"TileMap.tmx"];
		self.background = [tileMap layerNamed:@"Background"];
		self.foreground = [tileMap layerNamed:@"Foreground"];
		self.meta = [tileMap layerNamed:@"Meta"];
		self.meta.visible = NO;
		
		CCTMXObjectGroup *object = [tileMap objectGroupNamed:@"Objects"];
		NSAssert(object != nil, @"Objects -> object group not found");
		NSMutableDictionary *spawnPoint = [object objectNamed:@"SpawnPoint"];
		NSAssert(spawnPoint != nil, @"SpawnPoint object not found");
		int x = [[spawnPoint valueForKey:@"x"]intValue];
		int y = [[spawnPoint valueForKey:@"y"]intValue];
		
		self.player = [CCSprite spriteWithFile:@"Player.png"];
		//[self.player resizeTo:CGSizeMake(32, 32)];
		player.position = ccp(x,y);
		xVel = 2;
		yVel= 5;		
		
		[self scheduleUpdate];
		[self addChild:player];
		[self setViewpointCenter:player.position];
		
		[self addChild:tileMap z:-1];
	}
	return self;
}

#pragma mark -
#pragma mark HUD Delegate Methods
-(void)directionFromPad:(Direction)direction
{
	[self movePlayer:direction];
}
-(void)jumpButtonPushed
{
	[self jumpPlayer];
}


-(void)update:(ccTime)deltaTime
{
	[self setViewpointCenter:player.position];
	//[self movePlayer:moveRight];
}

-(CGPoint)tileCoordinateForPosition:(CGPoint)position
{
	int x = position.x / tileMap.tileSize.width;
	int y = ((tileMap.mapSize.height * tileMap.tileSize.height) - position.y) / tileMap.tileSize.height;
	return ccp(x,y);
}

-(void)checkPlayerCoordinate:(CCSprite *)thePlayer forDirection:(Direction)direction
{
	CGPoint left = CGPointMake(thePlayer.position.x - thePlayer.contentSize.width / 2, thePlayer.position.y);
	CGPoint right = CGPointMake(thePlayer.position.x + thePlayer.contentSize.width / 2, thePlayer.position.y);
	CGPoint bottom = CGPointMake(thePlayer.position.x, thePlayer.position.y - thePlayer.contentSize.height /2);
	CGPoint top= CGPointMake(thePlayer.position.x, thePlayer.position.y + thePlayer.contentSize.height / 2);
	
	int tileIDLeft = [meta tileGIDAt:[self tileCoordinateForPosition:left]];
	int tileIDRight = [meta tileGIDAt:[self tileCoordinateForPosition:right]];
	int tileIDBottom = [meta tileGIDAt:[self tileCoordinateForPosition:bottom]];
	int tileIDTop = [meta tileGIDAt:[self tileCoordinateForPosition:top]];

	
	float x = player.position.x;
	float y = player.position.y;
	
	if(direction == moveRight)
	{		
		if([self nextTileIsCollidable:tileIDRight])
		{
			//[[SimpleAudioEngine sharedEngine] playEffect:@"hit.caf"];
			x = ([self tileCoordinateForPosition:right].x * tileMap.tileSize.width) - player.contentSize.width / 2 ;
			
		}
	}
	if(direction == moveLeft)
	{
		if([self nextTileIsCollidable:tileIDLeft])
		{
			//[[SimpleAudioEngine sharedEngine] playEffect:@"hit.caf"];
			x = (([self tileCoordinateForPosition:left].x + 1) * tileMap.tileSize.width) + player.contentSize.width / 2 ;
			
		}
	}
	
	if([self nextTileIsCollidable:tileIDBottom])
	{
		y = (tileMap.mapSize.height * tileMap.tileSize.height) - ([self tileCoordinateForPosition:bottom].y * tileMap.tileSize.height) + player.contentSize.height / 2;
	}
	
	player.position = CGPointMake(x, y);
	
}

-(CGRect)tileRectForID:(int)tileID
{
	float x;
	float y;
	float width;
	float height;
	
	NSDictionary *properties = [tileMap propertiesForGID:tileID];
	if (properties) {
		x = [[properties valueForKey:@"x"]floatValue];
		y = [[properties valueForKey:@"y"]floatValue];
		width = [[properties valueForKey:@"width"]floatValue];
		height = [[properties valueForKey:@"height"]floatValue];
	}
	return CGRectMake(x, y, width, height);
}
 -(BOOL)nextTileIsCollidable:(int)tileID
{
	NSDictionary *properties = [tileMap propertiesForGID:tileID];
	if (properties) {
		NSString *collision = [properties valueForKey:@"Collidable"];
		if (collision && [collision compare:@"True"] == NSOrderedSame) {
			return true;
		}
	}
	return false;
	
}

-(void)setViewpointCenter:(CGPoint)position
{
	CGSize winSize = [[CCDirector sharedDirector]winSize];
	
	int x = MAX(position.x, winSize.width / 2);
	int y = MAX(position.y, winSize.height / 2);
	
	x = MIN(x, (tileMap.mapSize.width * tileMap.tileSize.width) - winSize.width / 2);
	y = MIN(y, (tileMap.mapSize.height * tileMap.tileSize.height) - winSize.height / 2);
	
	CGPoint actualPosition = ccp(x,y);
	CGPoint centerOfView = ccp(winSize.width / 2, winSize.height / 2);
	CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
	self.position = viewPoint;
}

#pragma mark -
#pragma mark Player Action

-(void)jumpPlayer
{
	yVel = -5;
	[self performSelector:@selector(stopJump) withObject:nil afterDelay:0.4f];
}
-(void)stopJump
{
	yVel = 5;
}

-(void)movePlayer:(Direction)direction
{
	float x = 0;
	float y = 0;
	if(direction == moveRight)
	{
		x = player.position.x + xVel;
		player.flipX = NO;
	}
	else if(direction == moveLeft)
	{
		x = player.position.x - xVel;
		player.flipX = YES;
	}
	else if(direction == noMove)
	{
		x = player.position.x;
	}
	y = player.position.y - yVel;
		
	if (player.position.x <= (tileMap.mapSize.width * tileMap.tileSize.width) &&
        player.position.y <= (tileMap.mapSize.height * tileMap.tileSize.height) &&
        player.position.y >= 0 &&
        player.position.x >= 0 ) 
    {
		player.position = ccp(x, y);
    }
	
	[self checkPlayerCoordinate:self.player forDirection:direction];
}
// on "dealloc" you need to release all your retained objects
@end
