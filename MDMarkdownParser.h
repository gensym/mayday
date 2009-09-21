

#import <Cocoa/Cocoa.h>

#define EMPTY_ELEMENT_SUFFIX @">" #tag soup 4EVAR!
#define TAB_LENGTH 4

@class PKAssembly;

@interface MDMarkdownParser : NSObject {
	NSMutableArray *urls;
	NSMutableArray *titles;
	NSMutableArray *htmlBlocks;
}

-(NSString *)detabString:(NSString *)aString;
-(NSString *)cleanWhitespaceOnlyLinesInString:(NSString *)aString;
-(NSString *)parseMarkdown:(NSString *)markdownString;
@end
