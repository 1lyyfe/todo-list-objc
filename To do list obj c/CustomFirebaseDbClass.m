//
//  CustomFirebaseDbClass.m
//  To do list obj c
//
//  Created by Haider Ashfaq on 01/03/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//

#import "CustomFirebaseDbClass.h"
#import "CustomAuthenticationFirebase.h"

@implementation CustomFirebaseDbClass

static NSString *_taskName = @"";
static NSString *_taskPriority = @"";
FIRDatabaseReference *ref;
NSDictionary *postDataToFirebase;
NSDictionary *childKeys;

//@synthesize taskName = _taskName;
//@synthesize taskPriority = _taskPriority;
//@synthesize ref = _ref;

//Task Name Setter method
+ (void) setTaskName:(NSString *)n {
    NSLog(@"Setting name to: %@", n);
    _taskName = n;
}
//Task Name Getter method
+ (NSString*) getTaskName {
    NSLog(@"Returning name: %@", _taskName);
    return _taskName;
}

//Task Priority Setter method
+ (void) setTaskPriority:(NSString *)n {
    NSLog(@"Setting Priority to: %@", n);
    _taskPriority = n;
}
//Task Priority Getter method
+ (NSString*) getTaskPriority {
    NSLog(@"Returning Priority: %@", _taskPriority);
    return _taskPriority;
}

//read the data at the users path within the firebase db
+ (void)loadDataFromDb: (DbLoadCompletionCallback) completion {
    ref = [[FIRDatabase database] reference];
    [[[ref child:@"users"] child:[CustomAuthenticationFirebase getUid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *dictionary = snapshot.value;
        NSString *storeTaskName = @"";
        NSString *storeTaskPriority = @"";
        
        if (dictionary[@"taskName"] != nil) {
            storeTaskName = dictionary[@"taskName"];
            NSLog(@"TASK NAME LOADED FROM DB: %@", storeTaskName);
            [self setTaskName:storeTaskName];
        }
        
        if (dictionary[@"taskPriority"] != nil) {
            storeTaskPriority = dictionary[@"taskPriority"];
            NSLog(@"TASK PRIORITY LOADED FROM DB: %@", storeTaskPriority);
            [self setTaskPriority:storeTaskPriority];
        }
        completion();
    }]; //Need to implement some code here to check for errors or failure in retreiving data
}

//format data in correct format to write to firebase db so that is stored in correct key-value order as I want it
+ (NSDictionary*) toJson {
    postDataToFirebase =  @{ @"taskName":[self getTaskName], @"taskPriority":[self getTaskPriority]};
    return postDataToFirebase;
}

//write above json method to firebase db using unique user uid as the record key and the above json as childs
+ (void)saveToFirebase {
    ref = [[FIRDatabase database] reference];
    NSString *key = [[ref child:@"users"] child: [CustomAuthenticationFirebase getUid]].key;
    childKeys = @{ [NSString stringWithFormat:@"/users/%@", key]: [self toJson]};
    [ref updateChildValues:childKeys];
}



@end

