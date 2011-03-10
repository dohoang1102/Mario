//
//  CCSpriteCategories.m
//  IceMario
//
//  Created by Maxime Lecomte on 05/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CCSpriteCategories.h"


@implementation CCSprite(Resize)

-(void)resizeTo:(CGSize)newSize
{
	CGFloat newWidth = newSize.width;
    CGFloat newHeight = newSize.height;
	
	
    float startWidth = self.contentSize.width;
    float startHeight = self.contentSize.height;
	
    float newScaleX = newWidth/startWidth;
    float newScaleY = newHeight/startHeight;
	
    self.scaleX = newScaleX;
    self.scaleY = newScaleY;
}

@end
