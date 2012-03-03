//
//  PHSplitView.m
//
//  Created by Michael Bianco on 4/11/07.
// 		<mabblog.com>
//

#import "MABSplitView.h"

@implementation MABSplitView
- (id) initWithCoder:(NSCoder *)decoder {
	if(self = [super initWithCoder:decoder]) {
		_splitImage = [[NSImage imageNamed:@"SplitBar"] retain];
	}
	
	return self;
}

- (void) setSplitImage:(NSImage *)img {
	[_splitImage release];
	_splitImage = img;
	[_splitImage retain];
}

- (CGFloat) dividerThickness {
	return 8.0;
}

- (void)drawDividerInRect:(NSRect)aRect {
	NSDrawThreePartImage(aRect, _splitImage, _splitImage, _splitImage, YES, NSCompositeSourceOver, 1.0, NO);
}
@end
