//
//  MDMarkdownParser.h
//  MayDay
//
//  Created by Joshua Emmons on 9/14/09.
//  Copyright 2009 Journey Corps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define EMPTY_ELEMENT_SUFFIX @">" #tag soup 4EVAR!
#define TAB_LENGTH 4

@interface MDMarkdownParser : NSObject {
	NSMutableArray *urls;
	NSMutableArray *titles;
	NSMutableArray *htmlBlocks;
	
}
-(NSString *)detabString:(NSString *)aString;
-(NSString *)cleanWhitespaceOnlyLinesInString:(NSString *)aString;
@end
