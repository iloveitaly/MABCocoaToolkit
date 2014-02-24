//
//  MABSystemInformation.m
//
//  Created by Michael Bianco on 6/15/09.
// 		<mabblog.com>
//

// from: http://www.cocoadev.com/index.pl?HowToGetHardwareAndNetworkInfo

#import "MABSystemInformation.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <IOKit/IOKitLib.h>

@implementation MABSystemInformation

+ (NSDictionary *)miniSystemProfile {
	return [NSDictionary dictionaryWithObjectsAndKeys:
		[self machineType], @"MachineType",
		[self humanMachineType], @"HumanMachineType",
		[NSNumber numberWithDouble:[self processorClockSpeedInGHz]], @"ProcessorClockSpeedInGHz",
		[NSNumber numberWithInt:[self countProcessors]], @"CountProcessors",
		[self computerName], @"ComputerName",
		[self computerSerialNumber], @"ComputerSerialNumber",
		[self operatingSystemString], @"OperatingSystem",
		[self systemVersionString], @"SystemVersion",
		[NSNumber numberWithInt:[self ramAmount]], @"RamAmount",	
		nil];
}


#pragma mark *** Getting the Human Name for the Machine Type ***

// adapted from http://nilzero.com/cgi-bin/mt-comments.cgi?entry_id=1300
// see below 'humanMachineNameFromNilZeroCom()' for the original code
// this code used a dictionary insted - see 'translationDictionary()' below 

// non-human readable machine type/model
+ (NSString *)machineType {
	int error = 0;
	int value = 0;
	size_t length = sizeof(value);
	
	error = sysctlbyname("hw.model", NULL, &length, NULL, 0);
	if (error == 0) {
		char *cpuModel = (char *)malloc(sizeof(char) * length);
		if (cpuModel != NULL) {
			error = sysctlbyname("hw.model", cpuModel, &length, NULL, 0);
			
			if (error == 0) {
				free(cpuModel);
				return [NSString stringWithUTF8String:cpuModel];
			}
			
			NSLog(@"Error determining machine type");
			free(cpuModel);
			return @"";
		}
	}
}

// dictionary used to make the machine type human-readable
static NSDictionary *translationDictionary = nil;
+ (NSDictionary *)translationDictionary {
	if(translationDictionary == nil)
		translationDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
	@"eMac (USB 2.0, 2005)", @"PowerMac6,4",
	@"Xserve G4", @"RackMac1,1",
	@"PowerBook G4 (Double layer SD, 17 inch)", @"PowerBook5,9",
	@"Power Macintosh G5 (Late 2005)", @"PowerMac9,1",
	@"Power Macintosh G4 (Gigabit Ethernet)", @"PowerMac3,3",
	@"PowerBook G3", @"PowerBook1,1",
	@"iBook G3 (Dual USB, Late 2001)", @"PowerBook4,1",
	@"PowerBook G4 (DVI)", @"PowerBook3,4",
	@"PowerBook G4 (12 inch 1.33GHz)", @"PowerBook6,4",
	@"PowerBook G4 (17-inch 1.67GHz)", @"PowerBook5,7",
	@"Mac Mini (Late 2005)", @"PowerMac10,2",
	@"Xserve (Intel Xeon)", @"Xserve1,1",
	@"Mac Pro (March 2009)", @"MacPro4,1",
	@"Power Macintosh G4 (PCI Graphics)", @"PowerMac1,2",
	@"PowerBook G4", @"PowerBook3,2",
	@"MacBook Air (October 2010)", @"MacBookAir3,1",
	@"PowerBook G4 (12 inch, DVI)", @"PowerBook6,2",
	@"PowerBook G4 (17-inch 1.5GHz)", @"PowerBook5,5",
	@"Power Macintosh G4 (Mirrored Drive Door)", @"PowerMac3,6",
	@"iMac G3 (Summer 2000)", @"PowerMac2,2",
	@"MacBook Pro (Core 2 Duo Feb 2008)", @"MacBookPro4,1",
	@"iMac G4 (20-inch Flat Panel)", @"PowerMac6,3",
	@"MacBook Pro Core 2 Duo (17-inch HD, Core 2 Duo)", @"MacBookPro3,2",
	@"Mac Pro (four-core)", @"MacPro1,1",
	@"iBook G3", @"PowerBook2,3",
	@"MacBook Air (June 2009)", @"MacBookAir2,1",
	@"Power Macintosh G4 (AGP Graphics)", @"PowerMac3,2",
	@"PowerBook G4 (17-inch 1.33GHz)", @"PowerBook5,3",
	@"MacBook (Core Duo)", @"MacBook1,1",
	@"Power Macintosh G5", @"PowerMac7,3",
	@"iMac G5 (iSight)", @"PowerMac12,1",
	@"Xserve G4 (slot-loading, cluster node)", @"RackMac1,2",
	@"MacBook Pro Core 2 Duo (15-inch LED, Core 2 Duo)", @"MacBookPro3,1",
	@"iMac for Education (17-inch, Core Duo)", @"iMac4,2",
	@"iBook G3", @"PowerBook2,1",
	@"MacBook Pro Core 2 Duo (15-inch)", @"MacBookPro2,2",
	@"iMac G4 (Flat Panel)", @"PowerMac4,2",
	@"iMac (Core 2 Duo, 17 inch, Combo Drive)", @"iMac5,2",
	@"PowerBook G4 (17 inch)", @"PowerBook5,1",
	@"MacBook Air (January 2008)", @"MacBookAir1,1",
	@"Power Macintosh G3 (Blue & White)", @"PowerMac1,1",
	@"iBook G4 (Mid 2005)", @"PowerBook6,7",
	@"Power Macintosh G5 (Late 2005)", @"PowerMac11,2",
	@"Power Macintosh G4 (Quick Silver)", @"PowerMac3,5",
	@"MacBook Pro Core 2 Duo (17-inch)", @"MacBookPro2,1",
	@"iMac G3 (Slot-loading CD-ROM)", @"PowerMac2,1",
	@"iBook G3 (16MB VRAM)", @"PowerBook4,2",
	@"MacBook Pro Core Duo (17-inch)", @"MacBookPro1,2",
	@"PowerBook G4 (1GHz / 867MHz)", @"PowerBook3,5",
	@"Mac Pro (January 2008 4- or 8- core Harpertown)", @"MacPro3,1",
	@"iBook G4 (Early-Late 2004)", @"PowerBook6,5",
	@"PowerBook G4 (Double layer SD, 15 inch)", @"PowerBook5,8",
	@"iMac G4 (17-inch Flat Panel)", @"PowerMac4,5",
	@"Power Macintosh G4 (AGP Graphics)", @"PowerMac3,1",
	@"Mac Mini (Core Solo/Duo)", @"Macmini1,1",
	@"Power Macintosh G5", @"PowerMac7,2",
	@"MacBook Pro Core Duo (15-inch)", @"MacBookPro1,1",
	@"PowerBook G4 (Gigabit Ethernet)", @"PowerBook3,3",
	@"MacBook (Core 2 Duo Feb 2008)", @"MacBook4,1",
	@"Developer Transition Kit", @"ADP2,1",
	@"iBook G4", @"PowerBook6,3",
	@"iMac G3 (Early/Summer 2001)", @"PowerMac4,1",
	@"PowerBook G4 (15 inch 1.67GHz/1.5GHz)", @"PowerBook5,6",
	@"Mac Mini G4", @"PowerMac10,1",
	@"iMac G3 (Rev A-D)", @"iMac1,1",
	@"iMac G5 (Ambient Light Sensor)", @"PowerMac8,2",
	@"iMac (Core Duo)", @"iMac4,1",
	@"iMac (Core 2 Duo, 17 or 20 inch, SuperDrive)", @"iMac5,1",
	@"PowerBook G3 (FireWire)", @"PowerBook3,1",
	@"Power Macintosh G4 Cube", @"PowerMac5,1",
	@"iMac (Core 2 Duo, 24 inch, SuperDrive)", @"iMac6,1",
	@"iBook G3", @"PowerBook2,4",
	@"iMac (April 2008)", @"iMac8,1",
	@"PowerBook G4 (12 inch)", @"PowerBook6,1",
	@"PowerBook G4 (15 inch 1.5/1.33GHz)", @"PowerBook5,4",
	@"MacBook (Core 2 Duo)", @"MacBook2,1",
	@"Power Macintosh G4 (Digital Audio)", @"PowerMac3,4",
	@"Mac Pro (August 2010)", @"MacPro5,1",
	@"Xserve (January 2008 quad-core)", @"Xserve2,1",
	@"iMac G4 (USB 2.0)", @"PowerMac6,1",
	@"iBook G3 (FireWire)", @"PowerBook2,2",
	@"eMac", @"PowerMac4,4",
	@"PowerBook G4 (15 inch FW 800)", @"PowerBook5,2",
	@"Xserve G5", @"RackMac3,1",
	@"PowerBook G4 (12 inch 1.5GHz)", @"PowerBook6,8",
	@"Mac Pro (eight-core)", @"MacPro2,1",
	@"iMac G5", @"PowerMac8,1",
	@"iBook G3 Opaque 16MB VRAM, 32MB VRAM, Early 2003)", @"PowerBook4,3",							   
							   nil];
	return translationDictionary;
}

+ (NSString *)humanMachineType {
	NSString *human;
	NSString *machineType = [self machineType];
	NSDictionary *translation = [self translationDictionary];
	
	human = [translation objectForKey:machineType];
	
	if(human == nil) {
		// TODO: could use string distance / matching here to do a 'best fit' match
		human = machineType;
	}
	
	return human;
}

#pragma mark *** Getting Processor info ***

+ (double) processorClockSpeedInGHz {
	return (double)[self processorClockSpeedInMHz] / 1000.0;
}

+ (int) processorClockSpeedInMHz {
	SInt32 gestaltInfo;
	OSErr err = Gestalt(gestaltProcClkSpeedMHz, &gestaltInfo);
	
	if (err == noErr) {
		return gestaltInfo;
	}
	
	return 0;
}

+ (int) ramAmount {
	SInt32 gestaltInfo;
	OSErr err = Gestalt(gestaltPhysicalRAMSizeInMegabytes, &gestaltInfo);
	if (err == noErr) {
		return gestaltInfo;
	}
	
	return 0;
}

#include <mach/mach_host.h>
#include <mach/host_info.h>

+ (unsigned int)countProcessors {
	int error = 0;
	int value = 0;
	size_t length = sizeof(value);
	
	error = sysctlbyname("hw.ncpu", &value, &length, NULL, 0);
	
	if (error == 0) {
		return value;
	}
	
	return 0;
}

// #include <mach/mach.h>
// #include <mach/machine.h>

#pragma mark *** Machine information ***

//this used to be called 'Rendezvous name' (X.2), now just 'Computer name' (X.3)
//see here for why: http://developer.apple.com/qa/qa2001/qa1228.html
//this is the name set in the Sharing pref pane
+ (NSString *)computerName {
	CFStringRef name;
	NSString *computerName;
	name=SCDynamicStoreCopyComputerName(NULL,NULL);
	computerName=[NSString stringWithString:(NSString *)name];
	CFRelease(name);
	return computerName;
}

/* copied from http://cocoa.mamasam.com/COCOADEV/2003/07/1/68334.php */
/* and modified by http://nilzero.com/cgi-bin/mt-comments.cgi?entry_id=1300 */
/* and by http://cocoa.mamasam.com/COCOADEV/2003/07/1/68337.php/ */

// found cleaner way to get this information:
// http://stackoverflow.com/questions/11613987/how-to-get-serial-number-processor-tray-with-cocoa

+ (NSString *)computerSerialNumber {
	return IORegistryEntryCreateCFProperty(IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/"), CFSTR(kIOPlatformSerialNumberKey), kCFAllocatorDefault, 0);
}

#pragma mark *** System version ***

+ (NSString *)operatingSystemString
{
	NSProcessInfo *procInfo = [NSProcessInfo processInfo];
	return [procInfo operatingSystemName];
}

+ (NSString *)systemVersionString
{
	NSProcessInfo *procInfo = [NSProcessInfo processInfo];
	return [procInfo operatingSystemVersionString];
}

@end