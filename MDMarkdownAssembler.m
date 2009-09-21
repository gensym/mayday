

#import "MDMarkdownAssembler.h"
#import <ParseKit/ParseKit.h>

@implementation MDMarkdownAssembler
@synthesize assembledString;

-(id)init{
	if(self = [super init]){
		assembledString = [[NSMutableString alloc]init];
		[assembledString appendString:@"Start:\n\n"];
	}
	return self;
}


-(void)dealloc{
	[assembledString release]; assembledString=nil;
	[super dealloc];
}


-(NSString *)assembledString{
	[assembledString appendString:@"End.\n"];
	return assembledString;
}


-(void)didMatchLine:(PKAssembly *)assembly{
	[assembledString appendFormat:@"line: %@\n\n", assembly];
}


-(void)didMatchNonBreakingLine:(PKAssembly *)assembly{
	[assembledString appendFormat:@"non-break: %@\n\n", assembly];
}

-(void)didMatchBreakingLine:(PKAssembly *)assembly{
	[assembledString appendFormat:@"line: %@\n\n", assembly];
}


-(void)didMatchParagraph:(PKAssembly *)assembly{
	[assembledString appendFormat:@"para: %@\n\n", assembly];
}


-(void)didMatchTest:(PKAssembly *)assembly{
	[assembledString appendFormat:@"test: %@\n\n", assembly];
}

@end
