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
@synthesize destination, source, window;

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification{
	NSFont *monaco = [NSFont fontWithName:@"Monaco" size:12.0];
	[source setFont:monaco];
	[destination setFont:monaco];
}

-(IBAction)translate:(NSNotification *)aNotification {
	MDMarkdownParser *parser = [[[MDMarkdownParser alloc]init] autorelease];
	[destination setString:[parser cleanWhitespaceOnlyLinesInString:[parser detabString:[source string]]]];
}
@end
