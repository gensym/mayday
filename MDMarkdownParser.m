//
//  MDMarkdownParser.m
//  MayDay
//
//  Created by Joshua Emmons on 9/14/09.
//  Copyright 2009 Journey Corps. All rights reserved.
//

#import "MDMarkdownParser.h"

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


-(NSString *)detabString:(NSString *)aString{	
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
		
	NSMutableString *stringAccumulator = [[[NSMutableString alloc]init]autorelease];

	[aString enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
		NSMutableString *lineAccumulator = [[NSMutableString alloc]init];

		NSScanner *scanner = [[NSScanner alloc] initWithString:line];
		NSCharacterSet *nullset = [[NSCharacterSet alloc]init];
		[scanner setCharactersToBeSkipped:nullset];
		[nullset release];

		detabScannerIntoAccumulator(scanner, lineAccumulator);

		[scanner release];	
		[stringAccumulator appendString:lineAccumulator];
		[lineAccumulator release];			
	}];
	
	return stringAccumulator;
}


@end