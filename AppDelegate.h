//
//  AppDelegate.h
//  MayDay
//
//  Created by Joshua Emmons on 9/14/09.
//  Copyright 2009 Journey Corps. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppDelegate : NSObject {
	NSWindow *window;
	NSTextField *label;
}
@property(nonatomic, retain) IBOutlet NSTextField *label;
@property(nonatomic, retain) IBOutlet NSWindow *window;

@end
