//
//  PadButton.m
//  IceMario
//
//  Created by Maxime Lecomte on 09/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "BPad.h"


@implementation BPad
@synthesize delegate;


#pragma mark -
#pragma mark Overrided Methods From Parent Class

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self sendToDelegateButtonPushed];
}
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	if(![self touchIsInside:touch])
	{
		[self touchEnded:touch withEvent:event];
	}
}
-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self sendToDelegateButtonReleased];
}

-(void)update:(ccTime)delta
{
	
}


#pragma mark -
#pragma mark Delegate Invocation Methods

-(void)sendToDelegateButtonPushed
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(buttonPushed:)])
	{
		[self.delegate buttonPushed:self];
	}
}
-(void)sendToDelegateButtonReleased
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(buttonReleased:)])
	{
		[self.delegate buttonReleased:self];
	}
}


@end
