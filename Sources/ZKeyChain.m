//
//  ZKeyChain.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/31/11.
//  Copyright (c) 2011 Electricwoods LLC. All rights reserved.
//

#import <Security/Security.h>
#import "ZKeyChain.h"
#import "NSData+Z.h"

//
//	NSStringFromStatus
//
static NSString *NSStringFromStatus(OSStatus aStatus)
{
	switch (aStatus) {
	case errSecSuccess: return @"errSecSuccess";
	case errSecUnimplemented: return @"errSecUnimplemented";
	case errSecParam: return @"errSecParam";
	case errSecAllocate: return @"errSecAllocate";
	case errSecNotAvailable: return @"errSecNotAvailable";
	case errSecAuthFailed: return @"errSecAuthFailed";
	case errSecDuplicateItem: return @"errSecDuplicateItem";
	case errSecItemNotFound: return @"errSecItemNotFound";
	case errSecInteractionNotAllowed: return @"errSecInteractionNotAllowed";
	case errSecDecode: return @"errSecDecode";
	default: return [NSString stringWithFormat:@"(%d)", (int)aStatus];
	}
}


//
//	ZKeyChain
//
@implementation ZKeyChain

@synthesize service;

+ (id)keyChainWithService:(NSString *)aService
{
	return [[ZKeyChain alloc] initWithService:aService];
}

- (id)initWithService:(NSString *)aService;
{
	if ((self = [super init])) {
		self.service = aService;
	}
	return self;
}

- (void)dealloc
{
	self.service = nil;
}


- (void)setPasswordData:(NSData *)passwordData forAccount:(NSString *)account;
{
	CFDataRef dataRef = nil;

	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	[query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	[query setObject:(id)service forKey:(__bridge id)kSecAttrService];
	[query setObject:(id)account forKey:(__bridge id)kSecAttrAccount];
	[query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
	OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&dataRef);
	if (status == noErr) {
		if (passwordData) {
			NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
			[attributes setObject:passwordData forKey:(__bridge id)kSecValueData];
			[attributes setObject:[NSDate date] forKey:(__bridge id)kSecAttrModificationDate];
			status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributes);
			if (status != noErr) NSLog(@"SecItemUpdate: %@", NSStringFromStatus(status));
		}
		else {
			status = SecItemDelete((__bridge CFDictionaryRef)query);
			if (status != noErr) NSLog(@"SecItemDelete: %@", NSStringFromStatus(status));
		}
	}
	else if (status == errSecItemNotFound) {
		NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
		[attributes setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
		[attributes setObject:(id)service forKey:(__bridge id)kSecAttrService];
		[attributes setObject:(id)account forKey:(__bridge id)kSecAttrAccount];
		if (passwordData) {
			[attributes setObject:passwordData forKey:(__bridge id)kSecValueData];
		}
		[attributes setObject:[NSDate date] forKey:(__bridge id)kSecAttrCreationDate];
		[attributes setObject:[NSDate date] forKey:(__bridge id)kSecAttrModificationDate];
		status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
		if (status != noErr) NSLog(@"SecItemAdd: %@", NSStringFromStatus(status));
	}

	if (dataRef) {
		CFRelease(dataRef);
	}
}

- (NSData *)passwordDataForAccount:(NSString *)account;
{
	NSData *data = nil;

	CFDataRef dataRef = nil;
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	[query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	[query setObject:(id)service forKey:(__bridge id)kSecAttrService];
	[query setObject:(id)account forKey:(__bridge id)kSecAttrAccount];
	[query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
	OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&dataRef);
	if (status == noErr) {
	}
	else if (status == errSecItemNotFound) {
	}
	else {
		NSLog(@"SecItemCopyMatching: %@", NSStringFromStatus(status));
	}

	if (dataRef) {
		data = [NSData dataWithData:(__bridge NSData *)dataRef];
		CFRelease(dataRef);
	}

	return data;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
	NSError *error = nil;
	NSData *data = [NSPropertyListSerialization dataWithPropertyList:value format:NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
	[self setPasswordData:data forAccount:key];
}

- (id)valueForKey:(NSString *)key
{
	NSPropertyListFormat format;
	NSError *error = nil;
	NSData *data = [self passwordDataForAccount:key];
	id value = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:&error];
	return value;
}

@end




