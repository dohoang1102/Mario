//
//  CCSpriteCategories.h
//  IceMario
//
//  Created by Maxime Lecomte on 05/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCSprite(Resize)
-(void)resizeTo:(CGSize)newSize;
@end
