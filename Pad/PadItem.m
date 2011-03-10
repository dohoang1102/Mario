//
//  PadItem.m
//  IceMario
//
//  Created by Maxime Lecomte on 09/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "PadItem.h"


@implementation PadItem


#pragma mark -
#pragma mark Abstract class Methods (Must override it)
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCLOG(@"The method %@ need be to overriden", _cmd);
}
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCLOG(@"The method %@ need be to overriden", _cmd);
}
-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCLOG(@"The method %@ need be to overriden", _cmd);
}
-(void)update:(ccTime)delta
{
	CCLOG(@"The method %@ need to be overiden", _cmd);
}


#pragma mark -
#pragma mark Init Methods

-(id)initWithImage:(NSString *)imageName andSize:(CGSize)theSize
{
	self = [super init];
	if(self != nil)
	{
		self.contentSize = theSize;
		sprite = [CCSprite spriteWithFile:imageName];
		sprite.contentSize = theSize;
		
		[self addChild:sprite z:100];
		
		[self registerWithTouchDispatcher];
		[self scheduleUpdate];
	}
	return self;
}


#pragma mark -
#pragma mark Touch Handler Methods

-(void)registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(touch)
	{
		if([self touchIsInside:touch])
		{
			[self touchBegan:touch withEvent:event];
			return YES;
		}	
	}
	else 
	{
		return NO;
	}
}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(touch)
	{
		if([self touchIsInside:touch])
		{
			[self touchMoved:touch withEvent:event];
		}	
	}
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(touch)
	{
		[self touchEnded:touch withEvent:event];
	}
}


#pragma mark -
#pragma mark Customs Methods

-(BOOL)touchIsInside:(UITouch *)touch
{
	CGPoint touchPositionUIKit = [touch locationInView:[touch view]];
	CGPoint touchPosition = [[CCDirector sharedDirector]convertToGL:touchPositionUIKit];
	
	float leftX = (self.position.x - self.contentSize.width / 2);
	float rightX = self.position.x + self.contentSize.width / 2;
	float bottomY = self.position.y - self.contentSize.height / 2;
	float topY = self.position.y + self.contentSize.height / 2;
	
	if((touchPosition.x > leftX) && (touchPosition.x < rightX)
	   && touchPosition.y < topY && touchPosition.y > bottomY)
	{
		return YES;
	}
	else {
		return NO;
	}
}


@end
