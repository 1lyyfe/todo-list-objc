//
//  CustomFirebaseDbClass.h
//  To do list obj c
//
//  Created by Haider Ashfaq on 01/03/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabase;

@interface CustomFirebaseDbClass : NSObject

//@property (nonatomic) NSString* taskName;
//@property (nonatomic) NSString* taskPriority;
//@property (strong, nonatomic) FIRDatabaseReference *ref;
+ (void)saveToFirebase;
+ (void) setTaskPriority:(NSString *)n;
+ (NSString*) getTaskPriority;
+ (void) setTaskName:(NSString *)n;
+ (NSString*) getTaskName;


@end
