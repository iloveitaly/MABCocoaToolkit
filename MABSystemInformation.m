//
//  MABSystemInformation.m
//
//  Created by Michael Bianco on 6/15/09.
//

// from: http://www.cocoadev.com/index.pl?HowToGetHardwareAndNetworkInfo

#import "MABSystemInformation.h"

#import <Carbon/Carbon.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation MABSystemInformation

//get everything!
+ (NSDictionary *)miniSystemProfile
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[self machineType],@"MachineType",
			[self humanMachineType],@"HumanMachineType",
			[self powerPCTypeString],@"ProcessorType",
			[NSNumber numberWithLong:
			 [self processorClockSpeed]],
			@"ProcessorClockSpeed",
			[NSNumber numberWithLong:
			 [self processorClockSpeedInMHz]],
			@"ProcessorClockSpeedInMHz",
			[NSNumber numberWithInt:[self countProcessors]],
			@"CountProcessors",
			[self computerName],@"ComputerName",
			[self computerSerialNumber],@"ComputerSerialNumber",
			[self operatingSystemString],@"OperatingSystem",
			[self systemVersionString],@"SystemVersion",		
			nil];
}


#pragma mark *** Getting the Human Name for the Machine Type ***

/* adapted from http://nilzero.com/cgi-bin/mt-comments.cgi?entry_id=1300 */
/*see below 'humanMachineNameFromNilZeroCom()' for the original code */
/*this code used a dictionary insted - see 'translationDictionary()' below */

//non-human readable machine type/model
+ (NSString *)machineType
{
	OSErr err;
	char *machineName=NULL;    // This is really a Pascal-string with a length byte.
	//gestaltUserVisibleMachineName = 'mnam'
	err = Gestalt(gestaltUserVisibleMachineName, (long*) &machineName);
	if( err== noErr )
		return [NSString stringWithCString: machineName +1 length: machineName[0]];
	else
		return @"machineType: machine name cannot be determined";
}

//dictionary used to make the machine type human-readable
static NSDictionary *translationDictionary=nil;
+ (NSDictionary *)translationDictionary
{
	if (translationDictionary==nil)
		translationDictionary=[[NSDictionary alloc] initWithObjectsAndKeys:
							   @"PowerMac 8500/8600",@"AAPL,8500",
							   @"PowerMac 9500/9600",@"AAPL,9500",
							   @"PowerMac 7200",@"AAPL,7200",
							   @"PowerMac 7200/7300",@"AAPL,7300",
							   @"PowerMac 7500",@"AAPL,7500",
							   @"Apple Network Server",@"AAPL,ShinerESB",
							   @"Alchemy(Performa 6400 logic-board design)",@"AAPL,e407",
							   @"Gazelle(5500)",@"AAPL,e411",
							   @"PowerBook 3400",@"AAPL,3400/2400",
							   @"PowerBook 3500",@"AAPL,3500",
							   @"PowerMac G3 (Gossamer)",@"AAPL,Gossamer",
							   @"PowerMac G3 (Silk)",@"AAPL,PowerMac G3",
							   @"PowerBook G3 (Wallstreet)",@"AAPL,PowerBook1998",
							   @"Yikes! Old machine - unknown model",@"AAPL",
							   
							   @"iMac (first generation)",@"iMac,1",
							   @"iMac (first generation) - unknown model",@"iMac",
							   
							   @"PowerBook G3 (Lombard)",@"PowerBook1,1",
							   @"iBook (clamshell)",@"PowerBook2,1",
							   @"iBook FireWire (clamshell)",@"PowerBook2,2",
							   @"PowerBook G3 (Pismo)",@"PowerBook3,1",
							   @"PowerBook G4 (Titanium)",@"PowerBook3,2",
							   @"PowerBook G4 (Titanium w/ Gigabit Ethernet)",
							   @"PowerBook3,3",
							   @"PowerBook G4 (Titanium w/ DVI)",@"PowerBook3,4",
							   @"PowerBook G4 (Titanium 1GHZ)",@"PowerBook3,5",
							   @"iBook (12in May 2001)",@"PowerBook4,1",
							   @"iBook (May 2002)",@"PowerBook4,2",
							   @"iBook 2 rev. 2 (w/ or w/o 14in LCD) (Nov 2002)",
							   @"PowerBook4,3",
							   @"iBook 2 (w/ or w/o 14in LDC)",@"PowerBook4,4",
							   @"PowerBook G4 (Aluminum 17in)",@"PowerBook5,1",
							   @"PowerBook G4 (Aluminum 15in)",@"PowerBook5,2",
							   @"PowerBook G4 (Aluminum 17in rev. 2)",@"PowerBook5,3",
							   @"PowerBook G4 (Aluminum 12in)",@"PowerBook6,1",
							   @"PowerBook G4 (Aluminum 12in)",@"PowerBook6,2",
							   @"iBook G4",@"PowerBook6,3",
							   @"PowerBook or iBook - unknown model",@"PowerBook",
							   
							   @"Blue & White G3",@"PowerMac1,1",
							   @"PowerMac G4 PCI Graphics",@"PowerMac1,2",
							   @"iMac FireWire (CRT)",@"PowerMac2,1",
							   @"iMac FireWire (CRT)",@"PowerMac2,2",
							   @"PowerMac G4 AGP Graphics",@"PowerMac3,1",
							   @"PowerMac G4 AGP Graphics",@"PowerMac3,2",
							   @"PowerMac G4 AGP Graphics",@"PowerMac3,3",
							   @"PowerMac G4 (QuickSilver)",@"PowerMac3,4",
							   @"PowerMac G4 (QuickSilver)",@"PowerMac3,5",
							   @"PowerMac G4 (MDD/Windtunnel)",@"PowerMac3,6",
							   @"iMac (Flower Power)",@"PowerMac4,1",
							   @"iMac (Flat Panel 15in)",@"PowerMac4,2",
							   @"eMac",@"PowerMac4,4",
							   @"iMac (Flat Panel 17in)",@"PowerMac4,5",
							   @"PowerMac G4 Cube",@"PowerMac5,1",
							   @"PowerMac G4 Cube",@"PowerMac5,2",
							   @"iMac (Flat Panel 17in)",@"PowerMac6,1",
							   @"PowerMac G5",@"PowerMac7,2",
							   @"PowerMac G5",@"PowerMac7,3",
							   @"PowerMac - unknown model",@"PowerMac",
							   
							   @"XServe",@"RackMac1,1",
							   @"XServe rev. 2",@"RackMac1,2",
							   @"XServe G5",@"RackMac3,1",
							   @"XServe - unknown model",@"RackMac",
							   
							   @"Mac Mini",@"Macmini1,1",	// Seen on a 1st gen. Core Duo, but may also be on others...?
							   @"Mac Mini - unknown model",@"Macmini",
							   
							   nil];
	return translationDictionary;
}

+ (NSString *)humanMachineType
{
	NSString *human=nil;
	NSString *machineType;
	
	machineType=[self machineType];
	
	//return the corresponding entry in the NSDictionary
	NSDictionary *translation=[self translationDictionary];
	NSString *aKey;
	//keys should be sorted to distinguish 'generic' from 'specific' names
	NSEnumerator *e=[[[translation allKeys]
					  sortedArrayUsingSelector:@selector(compare:)]
					 objectEnumerator];
	NSRange r;
	while (aKey=[e nextObject]) {
		r=[machineType rangeOfString:aKey];
		if (r.location!=NSNotFound)
			//continue searching : the first hit will be the generic name
			human=[translation objectForKey:aKey];
	}
	if (human)
		return human;
	else
		return machineType;
}

//for some reason, this does not work
//probably old stuff still around
/*
+ (NSString *)humanMachineTypeAlternate
{
	OSErr err;
	long result;
	Str255 name;
	err=Gestalt('mach',&result); //gestaltMachineType = 'mach'
	if (err==nil) {
		GetIndString(name,kMachineNameStrID,(short)result);
		return [NSString stringWithCString:name];
	} else
		return @"humanMachineTypeAlternate: machine name cannot be determined";
}
*/

#pragma mark *** Getting Processor info ***

+ (long)processorClockSpeed
{
	OSErr err;
	long result;
	err=Gestalt(gestaltProcClkSpeed,&result);
	if (err!=nil)
		return 0;
	else
		return result;
}

+ (long)processorClockSpeedInMHz
{
	return [self processorClockSpeed]/1000000;
}

#include <mach/mach_host.h>
#include <mach/host_info.h>
+ (unsigned int)countProcessors
{
	host_basic_info_data_t hostInfo;
	mach_msg_type_number_t infoCount;
	
	infoCount = HOST_BASIC_INFO_COUNT;
	host_info(mach_host_self(), HOST_BASIC_INFO, 
			  (host_info_t)&hostInfo, &infoCount);
	
	return (unsigned int)(hostInfo.max_cpus);
	
}

#include <mach/mach.h>
#include <mach/machine.h>


// the following methods were more or less copied from
//	http://developer.apple.com/technotes/tn/tn2086.html
//	http://www.cocoadev.com/index.pl?GettingTheProcessor
//	and can be better understood with a look at
//	file:///usr/include/mach/machine.h

+ (BOOL) isPowerPC
{
	host_basic_info_data_t hostInfo;
	mach_msg_type_number_t infoCount;
	
	infoCount = HOST_BASIC_INFO_COUNT;
	kern_return_t ret = host_info(mach_host_self(), HOST_BASIC_INFO,
								  (host_info_t)&hostInfo, &infoCount);
	
	return ( (KERN_SUCCESS == ret) &&
			(hostInfo.cpu_type == CPU_TYPE_POWERPC) );
}

+ (BOOL) isG3
{
	host_basic_info_data_t hostInfo;
	mach_msg_type_number_t infoCount;
	
	infoCount = HOST_BASIC_INFO_COUNT;
	kern_return_t ret = host_info(mach_host_self(), HOST_BASIC_INFO,
								  (host_info_t)&hostInfo, &infoCount);
	
	return ( (KERN_SUCCESS == ret) &&
			(hostInfo.cpu_type == CPU_TYPE_POWERPC) &&
			(hostInfo.cpu_subtype == CPU_SUBTYPE_POWERPC_750) );
}

+ (BOOL) isG4
{
	host_basic_info_data_t hostInfo;
	mach_msg_type_number_t infoCount;
	
	infoCount = HOST_BASIC_INFO_COUNT;
	kern_return_t ret = host_info(mach_host_self(), HOST_BASIC_INFO,
								  (host_info_t)&hostInfo, &infoCount);
	
	return ( (KERN_SUCCESS == ret) &&
			(hostInfo.cpu_type == CPU_TYPE_POWERPC) &&
			(hostInfo.cpu_subtype == CPU_SUBTYPE_POWERPC_7400 ||
			 hostInfo.cpu_subtype == CPU_SUBTYPE_POWERPC_7450));
}

#ifndef CPU_SUBTYPE_POWERPC_970
#define CPU_SUBTYPE_POWERPC_970 ((cpu_subtype_t) 100)
#endif
+ (BOOL) isG5
{
	host_basic_info_data_t hostInfo;
	mach_msg_type_number_t infoCount;
	
	infoCount = HOST_BASIC_INFO_COUNT;
	kern_return_t ret = host_info(mach_host_self(), HOST_BASIC_INFO,
								  (host_info_t)&hostInfo, &infoCount);
	
	return ( (KERN_SUCCESS == ret) &&
			(hostInfo.cpu_type == CPU_TYPE_POWERPC) &&
			(hostInfo.cpu_subtype == CPU_SUBTYPE_POWERPC_970));
}	

+ (NSString *)powerPCTypeString
{
	if ([self isG3])
		return @"G3";
	else if ([self isG4])
		return @"G4";
	else if ([self isG5])
		return @"G5";
	else if ([self isPowerPC])
		return @"PowerPC pre-G3";
	else
		return @"Non-PowerPC";
	
}

#pragma mark *** Machine information ***

//this used to be called 'Rendezvous name' (X.2), now just 'Computer name' (X.3)
//see here for why: http://developer.apple.com/qa/qa2001/qa1228.html
//this is the name set in the Sharing pref pane
+ (NSString *)computerName
{
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
+ (NSString *)computerSerialNumber
{
	NSString         *result = @"";
	mach_port_t       masterPort;
	kern_return_t      kr = noErr;
	io_registry_entry_t  entry;    
	CFDataRef         propData;
	CFTypeRef         prop;
	CFTypeID         propID=NULL;
	UInt8           *data;
	unsigned int        i, bufSize;
	char            *s, *t;
	char            firstPart[64], secondPart[64];
	
	kr = IOMasterPort(MACH_PORT_NULL, &masterPort);        
	if (kr == noErr) {
		entry = IORegistryGetRootEntry(masterPort);
		if (entry != MACH_PORT_NULL) {
			prop = IORegistryEntrySearchCFProperty(entry,
												   kIODeviceTreePlane,
												   CFSTR("serial-number"),
												   nil, kIORegistryIterateRecursively);
			if (prop == nil) {
				result = @"null";
			} else {
				propID = CFGetTypeID(prop);
			}
			if (propID == CFDataGetTypeID()) {
				propData = (CFDataRef)prop;
				bufSize = CFDataGetLength(propData);
				if (bufSize > 0) {
					data = CFDataGetBytePtr(propData);
					if (data) {
						i = 0;
						s = data;
						t = firstPart;
						while (i < bufSize) {
							i++;
							if (*s != '\0') {
								*t++ = *s++;
							} else {
								break;
							}
						}
						*t = '\0';
						
						while ((i < bufSize) && (*s == '\0')) {
							i++;
							s++;
						}
						
						t = secondPart;
						while (i < bufSize) {
							i++;
							if (*s != '\0') {
								*t++ = *s++;
							} else {
								break;
							}
						}
						*t = '\0';
						result =
						[NSString stringWithFormat:
						 @"%s%s",secondPart,firstPart];
					}
				}
			}
		}
		mach_port_deallocate(mach_task_self(), masterPort);
	}
	return(result);
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