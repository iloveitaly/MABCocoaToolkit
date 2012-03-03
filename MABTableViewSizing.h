//
//  MABTableViewSizing.h
//
//  Created by Michael Bianco on 1/2/10.
// 		<mabblog.com>
//

#import <Cocoa/Cocoa.h>

@interface NSTableView (MABTableViewSizing)
- (NSInteger) sizeToFitColumnContents:(NSInteger)columnIndex;
- (void) autoSizeAllColumnContents;
@end
