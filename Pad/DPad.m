//
//  Pad.m
//  IceMario
//
//  Created by Maxime Lecomte on 06/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "DPad.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"


//Private things
@interface DPad (Private)
-(Direction)getDirection:(UITouch *)touch;
-(BOOL)touchIsInside:(UITouch *)touch;
@end


@implementation DPad
@synthesize delegate;

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if([self touchIsInside:touch])
	{
		direction = (Direction)[self getDirection:touch];
	}
	else
	{
		direction = noMove;
	}
}
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	direction = (Direction)[self getDirection:touch];
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	direction = noMove;
}

-(Direction)getDirection:(UITouch *)touch
{
	CGPoint touchPositionUIKit = [touch locationInView:[touch view]];
	CGPoint position = [[CCDirector sharedDirector]convertToGL:touchPositionUIKit];
	
	float middleX = (self.contentSize.width / 2) + (self.position.x - self.contentSize.width / 2);
	
	if(position.x > middleX + self.contentSize.width / 6)
	{
		direction = moveRight;
	}
	else if(position.x < middleX - self.contentSize.width / 6)
	{
		direction = moveLeft;
	}
	else {
		direction = noMove;
	}

	return direction;
}


-(void)update:(ccTime)delta
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(padTouchedAt:)])
	{
		[self.delegate padTouchedAt:direction];
	}
}

@end
