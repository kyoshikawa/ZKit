//
//  ZKeyChain.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/31/11.
//  Copyright (c) 2011 Electricwoods LLC. All rights reserved.
//
//	License:	MIT License



#import <Foundation/Foundation.h>
#import <Security/Security.h>

//
//	ZKeyChain
//
@interface ZKeyChain : NSObject
{
	NSString *service;
}
@property (copy) NSString *service;

+ (id)keyChainWithService:(NSString *)aService;
- (id)initWithService:(NSString *)aService;

- (void)setPasswordData:(NSData *)passwordData forAccount:(NSString *)account;
- (NSData *)passwordDataForAccount:(NSString *)account;


// access value through following methods, the value must be serializable
- (void)setValue:(id)value forKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;

@end
