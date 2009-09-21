
#import <Cocoa/Cocoa.h>
@class PKAssembly;

@interface MDMarkdownAssembler : NSObject {
	NSMutableString *assembledString;
}
@property(nonatomic, readonly) NSString *assembledString;


-(void)didMatchLine:(PKAssembly *)assembly;
-(void)didMatchNonBreakingLine:(PKAssembly *)assembly;
-(void)didMatchBreakingLine:(PKAssembly *)assembly;
-(void)didMatchParagraph:(PKAssembly *)assembly;
-(void)didMatchTest:(PKAssembly *)assembly;


@end
