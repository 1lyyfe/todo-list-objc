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

typedef void(^DbLoadCompletionCallback)();

@interface CustomFirebaseDbClass : NSObject

//@property (nonatomic) NSString* taskName;
//@property (nonatomic) NSString* taskPriority;
//@property (strong, nonatomic) FIRDatabaseReference *ref;
+ (void)saveToFirebase;
+ (NSDictionary*) toJson;
+ (void) setTaskPriority:(NSString *)n;
+ (NSString*) getTaskPriority;
+ (void) setTaskName:(NSString *)n;
+ (NSString*) getTaskName;
+ (void)loadDataFromDb:(DbLoadCompletionCallback)completion;


@end
