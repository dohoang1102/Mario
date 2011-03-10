//
//  Pad.h
//  IceMario
//
//  Created by Maxime Lecomte on 06/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GeneralConstant.h"
#import "PadItem.h"


@protocol DPadDelegate <NSObject>
-(void)padTouchedAt:(Direction)direction;
@end


@class PadItem;

@interface DPad : PadItem
{
	id<DPadDelegate> delegate;
	Direction direction;
}

@property(nonatomic, assign) id<DPadDelegate> delegate;

@end
