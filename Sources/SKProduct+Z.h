//
//  SKProduct+Z.h
//
//  Created by Kaz Yoshikawa on 11/03/09.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


//
//	SKProduct (Z)
//

@interface SKProduct (Z)

- (NSString *)priceAsString;

@end


extern NSString *NSStringFromSKPaymentTransactionState(SKPaymentTransactionState state);
