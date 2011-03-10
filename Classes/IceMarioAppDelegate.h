//
//  IceMarioAppDelegate.h
//  IceMario
//
//  Created by Maxime Lecomte on 04/03/11.
//  Copyright NA 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface IceMarioAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
