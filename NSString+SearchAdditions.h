//
//  NSString+Additions.h
//
//  Created by Michael Bianco <mabblog.com> on 4/3/06.
//

#import <Cocoa/Cocoa.h>

@interface NSString (SearchingAdditions)

- (BOOL) containsString:(NSString *)aString;
- (BOOL) containsString:(NSString *)aString ignoringCase:(BOOL)flag;

@end