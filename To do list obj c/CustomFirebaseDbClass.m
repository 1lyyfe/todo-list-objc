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
static NSMutableArray *coreDataContent;
FIRDatabaseReference *ref;
NSDictionary *postDataToFirebase;
NSDictionary *childKeys;


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

//Firebase data Setter method
+ (void) setData:(NSMutableArray *)n {
    NSLog(@"Setting array with coredata content to: %@", n);
    coreDataContent = n;
}
//Firebase data Getter method
+ (NSMutableArray*) getData {
     NSLog(@"Returning array containing coredata: %@", coreDataContent);
    return coreDataContent;
}


//read the data at the users path within the firebase db
+ (void)loadDataFromDb: (DbLoadCompletionCallback) completion {
    ref = [[FIRDatabase database] reference];
    [[[ref child:@"users"] child:[CustomAuthenticationFirebase getUid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *dictionary = snapshot.value;
        NSMutableArray *storeData;
        //read data from firebase in json format and store in CustomFirebaseDB class model
        if (dictionary[@"data"] != nil) {
            storeData = dictionary[@"data"];
            NSLog(@"DATA LOADED FROM DB: %@", storeData);
            [self setData:storeData];
            NSLog(@"DATA LOADED FROM CUSTOM FB MODEL ONCE SET: %@", [self getData]);
        }
        completion();
    }]; //Need to implement some code here to check for errors or failure in retreiving data
}

//format data in correct format to write to firebase db so that is stored in correct key-value order as I want it
+ (NSDictionary*) toJson {
    postDataToFirebase =  @{ @"data":[self getData]};
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

