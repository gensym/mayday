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
	NSTextView *source;
	NSTextView *destination;
}
@property(nonatomic, retain) IBOutlet NSTextView *source;
@property(nonatomic, retain) IBOutlet NSTextView *destination;
@property(nonatomic, retain) IBOutlet NSWindow *window;

-(IBAction)translate:(id)sender;

@end
