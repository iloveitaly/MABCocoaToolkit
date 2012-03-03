//
//  NSString+Additions.m
//
//  Created by Michael Bianco <mabblog.com> on 4/3/06.
//

#import "NSString+SearchAdditions.h"

@implementation NSString (SearchingAdditions)

- (BOOL)containsString:(NSString *)aString {
    return [self containsString:aString ignoringCase:NO];
}

- (BOOL)containsString:(NSString *)aString ignoringCase:(BOOL)flag {
    unsigned mask = (flag ? NSCaseInsensitiveSearch : 0);
    return [self rangeOfString:aString options:mask].length > 0;
}

@end