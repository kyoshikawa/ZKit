//
//  SKProduct+Z.m
//
//  Created by Kaz Yoshikawa on 11/03/09.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "SKProduct+Z.h"

//
//	SKProduct (Z)
//

@implementation SKProduct (Z)

- (NSString *)priceAsString
{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[formatter setLocale:[self priceLocale]];

	NSString *string = [formatter stringFromNumber:[self price]];
	return string;
}

@end


NSString *NSStringFromSKPaymentTransactionState(SKPaymentTransactionState state)
{
	switch (state) {
	case SKPaymentTransactionStatePurchasing: return @"SKPaymentTransactionStatePurchasing";
	case SKPaymentTransactionStatePurchased: return @"SKPaymentTransactionStatePurchased";
	case SKPaymentTransactionStateFailed: return @"SKPaymentTransactionStateFailed";
	case SKPaymentTransactionStateRestored: return @"SKPaymentTransactionStateRestored";
	default: return @"?";
	}
}
