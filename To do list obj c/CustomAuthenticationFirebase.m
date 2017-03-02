//
//  CustomAuthenticationFirebase.m
//  To do list obj c
//
//  Created by Haider Ashfaq on 01/03/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//
//In this class we sign in a user annonymously so they each have a unique firebase user uid so that we can store data against that. The firebase db should split data on each users device uid and then there tasks will each be stored under that key as childs. This would help with the future extensibility of this class as it would be easy to retrieve the uid later to upgrade them to a full acount perhaps

#import "CustomAuthenticationFirebase.h"
#import "CustomFirebaseDbClass.h"
@import FirebaseDatabase;
@import Firebase;
@import FirebaseAuth;

@implementation CustomAuthenticationFirebase

static NSString *uid = @"";
 
//Used to create and use temporary anonymous accounts to authenticate with Firebase. Allows users to work with data protected by security rules because firebase db only lets authenticated users read/write
+ (void)signInUserAnonymously: (AuthenticationCompletionCallback) completion {
    [[FIRAuth auth]
     signInAnonymouslyWithCompletion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
         if (error == nil) {
             [self setUid:user.uid];
             NSLog(@"UID FROM AUTH MODEL: %@", [self getUid]);
             [CustomFirebaseDbClass saveToFirebase];
             completion();
         } else {
             NSLog(@"Authentication Error... Failed to sign in anonymously: %@", error);
         }
     }];
}

//uid Setter method
+ (void) setUid:(NSString *)n {
    NSLog(@"Setting Uid to: %@", n);
    uid = n;
}
//uid getter method
+ (NSString*) getUid {
    NSLog(@"Returning Uid: %@", uid);
    return uid;
}

@end
