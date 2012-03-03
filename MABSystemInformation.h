//
//  MABSystemInformation.h
//
//  Created by Michael Bianco on 6/15/09.
//

#import <Cocoa/Cocoa.h>

@interface MABSystemInformation : NSObject {}

//all the info at once!
+ (NSDictionary *)miniSystemProfile;

+ (NSString *)machineType;
+ (NSString *)humanMachineType;
+ (NSString *)humanMachineTypeAlternate;

+ (long)processorClockSpeed;
+ (long)processorClockSpeedInMHz;
+ (unsigned int)countProcessors;
+ (BOOL) isPowerPC;
+ (BOOL) isG3;
+ (BOOL) isG4;
+ (BOOL) isG5;
+ (NSString *)powerPCTypeString;

+ (NSString *)computerName;
+ (NSString *)computerSerialNumber;

+ (NSString *)operatingSystemString;
+ (NSString *)systemVersionString;

@end
