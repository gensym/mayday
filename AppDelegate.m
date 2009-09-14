//
//  AppDelegate.m
//  MayDay
//
//  Created by Joshua Emmons on 9/14/09.
//  Copyright 2009 Journey Corps. All rights reserved.
//

#import "AppDelegate.h"
#import "MDMarkdownParser.h"


@implementation AppDelegate
@synthesize label, window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSLog(@"here");
	MDMarkdownParser *parser = [[MDMarkdownParser alloc] init];
	[label setStringValue:[parser sayHello]];
}
@end
