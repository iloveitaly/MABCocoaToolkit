//
//  MABTableViewSizing.m
//
//  Created by Michael Bianco on 1/2/10.
// 		<mabblog.com>
//

#import "MABTableViewSizing.h"

// Original source:
// http://www.cocoabuilder.com/archive/cocoa/206352-yann-disser-resizing-nstableview-columns.html?q=Yann+Disser+Resizing+NSTableView+columns#206352

@implementation NSTableView (MABTableViewSizing)
- (NSInteger) sizeToFitColumnContents:(NSInteger)columnIndex {
	NSInteger sizeToFitWidth = 0;
	NSInteger i;
	
	for (i = 0; i < [self numberOfRows]; i++) {
		NSCell *cell = [self preparedCellAtColumn:columnIndex row:i];
		NSInteger cellWidth = [cell cellSize].width + 1;
		sizeToFitWidth = MAX(sizeToFitWidth, cellWidth);
	}
	
	return sizeToFitWidth;
}

- (void) autoSizeAllColumnContents {
	NSArray *columns = [self tableColumns];
	NSTableColumn *column;
	NSInteger i, fitSize;
	
	for(i = 0; i < [columns count]; i++) {
		fitSize = [self sizeToFitColumnContents:i];
		column = [columns objectAtIndex:i];
		
		if(fitSize > column.width) {
			column.width = fitSize;
		}
	}
}
@end
