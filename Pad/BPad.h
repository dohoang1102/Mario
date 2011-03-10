//
//  PadButton.h
//  IceMario
//
//  Created by Maxime Lecomte on 09/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PadItem.h"

@class BPad;
@protocol BPadDelegate <NSObject>
-(void)buttonPushed:(BPad *)button;
-(void)buttonReleased:(BPad *)button;
@end

@class PadItem;

@interface BPad : PadItem 
{
	id<BPadDelegate> delegate;
}

@property(nonatomic, assign) id<BPadDelegate> delegate;

@end
