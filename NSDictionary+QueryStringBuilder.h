#import <Foundation/Foundation.h>

// pulled from https://gist.github.com/972328

@interface NSDictionary (QueryStringBuilder)

- (NSString *)queryString;

@end