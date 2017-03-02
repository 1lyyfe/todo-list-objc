//
//  TaskViewController.m
//  To do list obj c
//
//  Created by Haider Ashfaq on 26/02/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//
//This class is to add/view/edit tasks/task details

#import "TaskViewController.h"
#import <CoreData/CoreData.h>
#import "CustomFirebaseDbClass.h"


@interface TaskViewController ()

@end

@implementation TaskViewController

@synthesize task, taskNameTextField, taskPriorityTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.task) {
        [taskNameTextField setText:[self.task valueForKey:@"name"]];
        [taskPriorityTextField setText:[self.task valueForKey:@"priority"]];
    }
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom Initialiser
    }
    return self;
}

- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)addButtonClicked:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.task) {
        //update existing task
        [self.task setValue:self.taskNameTextField.text forKey:@"name"];
        [self.task setValue:self.taskPriorityTextField.text forKey:@"priority"];
    } else {
        //create a new task
        NSManagedObject *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:context];
        [newTask setValue:self.taskNameTextField.text forKey:@"name"];
        [newTask setValue:self.taskPriorityTextField.text forKey:@"priority"];
        
        // upload to firebase in background thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //To save to firebase not working but did not have time to fix this - can do at a later date
            [CustomFirebaseDbClass setTaskName:self.taskNameTextField.text];
            [CustomFirebaseDbClass setTaskPriority:self.taskPriorityTextField.text];
            NSLog(@"TASK NAME FROM FB CLASS: %@", [CustomFirebaseDbClass getTaskName]);
            NSLog(@"TASK PRIORITY FROM FB CLASS: %@", [CustomFirebaseDbClass getTaskPriority]);
            [CustomFirebaseDbClass saveToFirebase];
        });
    }
    
    
    NSError *error = nil;
    //save task object to persistant store
    if (![context save:&error]) {
        NSLog(@"Cannot add task! %@ %@", error, [error localizedDescription]);
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
