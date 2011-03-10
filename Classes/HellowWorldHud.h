//
//  HellowWorldHud.h
//  IceMario
//
//  Created by Maxime Lecomte on 04/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HellowWorldHud : CCLayer
{
	CCLabelTTF *label;
}

-(void)numCollectedChanged:(int)numCollected;

@end
