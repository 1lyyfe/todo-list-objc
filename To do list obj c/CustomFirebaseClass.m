//
//  CustomFirebaseClass.m
//  To do list obj c
//
//  Created by Haider Ashfaq on 01/03/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//

#import "CustomFirebaseClass.h"

@implementation CustomFirebaseClass

@synthesize taskName = _taskName;
@synthesize taskPriority = _taskPriority;
@synthesize ref = _ref;

//Task Name Setter method
- (void) setTaskName:(NSString *)n {
    NSLog(@"Setting name to: %@", n);
    _taskName = n;
}
//Task Name Getter method
- (NSString*) getTaskName {
    NSLog(@"Returning name: %@", _taskName);
    return _taskName;
}

//Task Priority Setter method
- (void) setTaskPriority:(NSString *)n {
    NSLog(@"Setting Priority to: %@", n);
    _taskPriority = n;
}
//Task Priority Getter method
- (NSString*) getTaskPriority {
    NSLog(@"Returning Priority: %@", _taskPriority);
    return _taskPriority;
}

- (void)saveToFirebase {
    _ref = [[FIRDatabase database] reference];
    [[[_ref child:@"taskName"] child:_taskName]
     setValue:@{@"taskPriority": _taskPriority}];
}



@end

