//
//  MABSystemInformation.h
//
//  Created by Michael Bianco on 6/15/09.
//

#import <Cocoa/Cocoa.h>

@interface MABSystemInformation : NSObject {}

+ (NSDictionary *)miniSystemProfile;

+ (NSString *)machineType;
+ (NSString *)humanMachineType;

+ (long)processorClockSpeedInMHz;
+ (unsigned int)countProcessors;

+ (NSString *)computerName;
+ (NSString *)computerSerialNumber;

+ (NSString *)operatingSystemString;
+ (NSString *)systemVersionString;

@end
