//
//  HellowWorldHud.m
//  IceMario
//
//  Created by Maxime Lecomte on 04/03/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "HellowWorldHud.h"


@implementation HellowWorldHud


-(id) init
{
    if ((self = [super init])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        label = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(50, 20)
							   alignment:UITextAlignmentRight fontName:@"Verdana-Bold" 
								fontSize:18.0];
        label.color = ccc3(0,0,0);
        int margin = 10;
        label.position = ccp(winSize.width - (label.contentSize.width/2) 
							 - margin, label.contentSize.height/2 + margin);
        [self addChild:label];
    }
    return self;
}

- (void)numCollectedChanged:(int)numCollected {
    [label setString:[NSString stringWithFormat:@"%d", numCollected]];
}



@end
