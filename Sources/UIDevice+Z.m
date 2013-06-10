//
//  UIDevice+Z.m
//	ZKit
//
//  Created by Kaz Yoshikawa  on 10/7/11.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "UIDevice+Z.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


//
//	UIDevice (Z)
//
@implementation UIDevice (Z)

+ (BOOL)iPad
{
	return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)iPhone
{
	return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

+ (NSData *)macaddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);

	NSData *data = [NSData dataWithBytes:ptr length:6];

    free(buf);
    
    return data;
}

- (NSString *)modelIdentifier
{
     size_t size;

    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0); 

    // Allocate the space to store name
    char *name = malloc(size);

    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);

    // Place name into a string
	NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];

    // Done with this
    free(name);

    return machine;
}

@end
