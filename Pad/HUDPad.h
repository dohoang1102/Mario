//
//  HUDLayer.h
//  IceMario
//
//  Created by Maxime Lecomte on 06/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GeneralConstant.h"
#import "DPad.h"
#import "BPad.h"

#define kButtonSizeWidth 50
#define kButtonSizeHeight 50
#define kPadSizeWidth 90
#define kPadSizeHeight 90

@protocol HUDDelegate
-(void)directionFromPad:(Direction)direction;
-(void)speedButtonPushed;
-(void)speedButtonReleased;
-(void)jumpButtonPushed;
@end


@interface HUDPad : CCLayer 
				<DPadDelegate, BPadDelegate>
{
	id<HUDDelegate> delegate;
	BPad *speedButton;
	BPad *jumpButton;
}

@property (nonatomic, retain) BPad *speedButton;
@property (nonatomic, retain) BPad *jumpButton;
@property(nonatomic, assign) id<HUDDelegate> delegate;

@end
