
#import "MDMarkdownParser.h"
#import "MDMarkdownAssembler.h"
#import <ParseKit/ParseKit.h>

@interface MDMarkdownParser ()
-(NSString *)scanLinesOfString:(NSString *)aString withBlock:(void (^)(NSScanner *aScanner, NSMutableString *anAccumulator))block;
@end
@implementation MDMarkdownParser
-(id)init{
	if(self=[super init]){
		urls = [[NSMutableArray alloc]init];
		titles = [[NSMutableArray alloc]init];
		htmlBlocks = [[NSMutableArray alloc]init];
	}
	return self;
}


-(void)dealloc{
	[urls release]; urls=nil;
	[titles release]; titles = nil;
	[htmlBlocks release]; htmlBlocks = nil;
	[super dealloc];
}


-(NSString *)parseMarkdown:(NSString *)markdownString{
	MDMarkdownAssembler *assembler = [[[MDMarkdownAssembler alloc]init]autorelease];
	NSURL *frameworkURL = [[[NSBundle mainBundle] privateFrameworksURL] URLByAppendingPathComponent:@"MayDay.framework"];
	NSBundle *frameworkBundle = [NSBundle bundleWithURL:frameworkURL];
	NSURL *grammarURL = [frameworkBundle URLForResource:@"Markdown" withExtension:@"grammar"];
	NSString *grammar = [NSString stringWithContentsOfURL:grammarURL encoding:NSUTF8StringEncoding error:NULL];

	PKParser *parser = [[PKParserFactory factory] parserFromGrammar:grammar assembler:assembler];
	[parser parse:markdownString];
	return [assembler assembledString];
}


-(NSString *)detabString:(NSString *)aString{	
	//We could declair this as an argument if it weren't recursive. A recursive block demands to be declaired with a "__block" prefix (which, as far as I know, you can't do in a parameter list).
	__block void (^detabScannerIntoAccumulator)(NSScanner*, NSMutableString*);
	detabScannerIntoAccumulator = ^(NSScanner *aScanner, NSMutableString *anAccumulator){
		NSString *into;
		if([aScanner scanUpToString:@"\t" intoString:&into]){
			[anAccumulator appendString:into];
		}
		while([aScanner scanString:@"\t" intoString:NULL]){
			NSUInteger spaces = TAB_LENGTH - [anAccumulator length] % TAB_LENGTH;
			[anAccumulator appendString:[@"" stringByPaddingToLength:spaces withString:@" " startingAtIndex:0]];
		}		
		if(![aScanner isAtEnd]){
			detabScannerIntoAccumulator(aScanner, anAccumulator);
		}else {
			[anAccumulator appendString:@"\n"];
		}
	};

	return [self scanLinesOfString:aString withBlock:detabScannerIntoAccumulator];
}


-(NSString *)cleanWhitespaceOnlyLinesInString:(NSString *)aString{
	return [self scanLinesOfString:aString withBlock:^(NSScanner *aScanner, NSMutableString *anAccumulator) {
		[aScanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:NULL];
		if(![aScanner isAtEnd]){
			[anAccumulator appendString:[aScanner string]];
		}
		[anAccumulator appendString:@"\n"];
		
	}];
}



#pragma mark -
-(NSString *)scanLinesOfString:(NSString *)aString withBlock:(void (^)(NSScanner*, NSMutableString*))block{
	NSMutableString *stringAccumulator = [[NSMutableString alloc]init];
	
	[aString enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
		NSMutableString *lineAccumulator = [[NSMutableString alloc]init];
		
		NSScanner *scanner = [[NSScanner alloc] initWithString:line];
		NSCharacterSet *nullset = [[NSCharacterSet alloc]init];
		[scanner setCharactersToBeSkipped:nullset];
		[nullset release];
		
		block(scanner, lineAccumulator);
		
		[scanner release];	
		[stringAccumulator appendString:lineAccumulator];
		[lineAccumulator release];			
	}];
	
	return [stringAccumulator autorelease];
}

@end