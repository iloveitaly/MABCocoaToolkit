/*
 Copyright (c) 2006 Michael Bianco, <mabblog.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 There should only be once instance of this support controller, I usually created a instace in my MainMenu.nib file then
 use -[MABSupportFolder sharedController] to access the instance in my code.
 
 You can easily extend this class and add methods to manipulate/manage the support folder in any way you please.
 One glitch you may come across when extending subclassing is the +sharedController method. 
 GCC will give you warnings that MABSupportController will not respond to a method you added onto your subclass.
 You can silence GCC by adding this method to your subclass:
 +(AppSupportController *) sharedController { return (AppSupportController *) [super sharedController]; }
 where AppSupportController is you new subclass.
 */

#import "MABSupportFolder.h"
#import "MABMacros.h"

static MABSupportFolder *_sharedController = nil;

@implementation MABSupportFolder

+(MABSupportFolder *) sharedController {
	extern MABSupportFolder *_sharedController;
	if(!_sharedController) [self new];
	return _sharedController;
}

- (id) init {
	if (self = [super init]) {
		//set the shared controller
		extern MABSupportFolder *_sharedController;
		_sharedController = self;
		
		//create the application support folder path
		_supportFolder = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		_supportFolder = [[_supportFolder stringByAppendingPathComponent:[[NSBundle mainBundle]  objectForInfoDictionaryKey:@"CFBundleName"]] retain];
		_fileManager = [[NSFileManager defaultManager] retain];
	}
	
	return self;
}

-(void) dealloc {
	[_supportFolder release];
	[_fileManager release];
	[super dealloc];
}

- (void) createSupportFolder {
	if(![_fileManager fileExistsAtPath:_supportFolder]) {
		if(![_fileManager createDirectoryAtPath:_supportFolder
									 attributes:nil]) {
			NSLog(@"Error creating app-support folder");	
		}		
	}
}

- (NSString *) supportFolder {
	[self createSupportFolder];
	return _supportFolder;	
}

- (NSString *) supportSubFolder:(NSString *)sub {
	[self createSupportFolder];
	
	if(!isEmpty(sub)) {
		NSString *subFolder = [_supportFolder stringByAppendingPathComponent:sub];
		
		if(![_fileManager fileExistsAtPath:subFolder]) {
			if(![_fileManager createDirectoryAtPath:subFolder
										 attributes:nil]) {
				NSLog(@"Error creating app support sub folder");	
			}		
		}
		
		return subFolder;
	}
	
	return nil;
}

@end
