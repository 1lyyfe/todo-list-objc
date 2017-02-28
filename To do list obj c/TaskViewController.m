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
