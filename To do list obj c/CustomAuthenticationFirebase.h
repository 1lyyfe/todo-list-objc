//
//  CustomAuthenticationFirebase.h
//  To do list obj c
//
//  Created by Haider Ashfaq on 01/03/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthenticationCompletionCallback)();

@interface CustomAuthenticationFirebase : NSObject


+ (void)signInUserAnonymously:(AuthenticationCompletionCallback)completion;
+ (void) setUid:(NSString *)n;
+ (NSString*) getUid;

@end
