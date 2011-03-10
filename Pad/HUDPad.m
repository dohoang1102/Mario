//
//  HUDLayer.m
//  IceMario
//
//  Created by Maxime Lecomte on 06/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "HUDPad.h"
#import "DPad.h"
#import "BPad.h"

@implementation HUDPad

@synthesize speedButton;
@synthesize jumpButton;
@synthesize delegate;

- (void)dealloc
{
	[jumpButton release];
	jumpButton = nil;


	[speedButton release];
	speedButton = nil;

	[super dealloc];
}

-(id)init
{
	self = [super init];
	if(self)
	{
		CGSize screenSize = [[CCDirector sharedDirector]winSize];
		
		DPad *pad = [[[DPad alloc]initWithImage:@"d-pad.png" andSize:CGSizeMake(kPadSizeWidth, kPadSizeHeight)]autorelease];
		pad.delegate = self;
		pad.position = ccp(50, 50);
		[self addChild:pad z:10];
		
		
		self.jumpButton = [[[BPad alloc]initWithImage:@"jumpButton.png" andSize:CGSizeMake(kButtonSizeWidth, kButtonSizeHeight)]autorelease];
		jumpButton.delegate = self;
		jumpButton.position = ccp((screenSize.width - kButtonSizeWidth), kButtonSizeHeight);
		[self addChild:jumpButton z:100];
		
		self.speedButton = [[[BPad alloc]initWithImage:@"speedButton.png" andSize:CGSizeMake(kButtonSizeWidth, kButtonSizeHeight)]autorelease];
		speedButton.delegate = self;
		speedButton.position = ccp(jumpButton.position.x - kButtonSizeWidth - 10, kButtonSizeHeight);
		[self addChild:speedButton z:100];
		 
		
	}
	return self;
}
#pragma mark -
#pragma mark Pad Delegate
-(void)padTouchedAt:(Direction)direction
{
	[self sendDirectionFromPadToDelegate:direction];	
}


#pragma mark -
#pragma mark BPad Delegate
-(void)buttonPushed:(BPad *)button
{
	if(button == self.speedButton)
	{
		[self sendToDelegateSpeedButtonPushed];
	}
	else if(button == self.jumpButton)
	{
		[self sendToDelegateJumpButtonPushed];
	}
}
-(void)buttonReleased:(BPad *)button
{
	if(button == self.jumpButton)
	{
		[self sendToDelegateSpeedButtonReleased];
	}
}

#pragma mark -
#pragma mark Send To Delegate Methods
-(void)sendDirectionFromPadToDelegate:(Direction)direction
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(directionFromPad:)])
	{
		[self.delegate directionFromPad:direction];
	}
}
-(void)sendToDelegateSpeedButtonPushed
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(speedButtonPushed)])
	{
		[self.delegate speedButtonPushed];
	}
}
-(void)sendToDelegateSpeedButtonReleased
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(speedButtonReleased)])
	{
		[self.delegate speedButtonReleased];
	}
}
-(void)sendToDelegateJumpButtonPushed
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(jumpButtonPushed)])
	{
		[self.delegate jumpButtonPushed];
	}	
}

@end
