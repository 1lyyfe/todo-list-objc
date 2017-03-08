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
@property (strong, nonatomic)NSMutableArray *tasks;

@end

@implementation TaskViewController

@synthesize task, taskNameTextField, taskPriorityTextField;

NSMutableArray *array;
NSManagedObjectModel *task;

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

- (void)fetchTasksFromCoreData {
    //fetch the tasks from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Task"];
    fetchRequest.resultType = NSDictionaryResultType;
    
    NSError *error      = nil;
    //fetch coredata and put managed object context data into an array
    NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                                   error:&error];
    //init array with size of items in coredata stack
    array = [[NSMutableArray alloc]initWithCapacity:results.count];
    
    //iterate over fetched object array and store task name and task priority into dictionary format
    for (id object in results) {
        
        NSDictionary *temp = @{ [NSString stringWithFormat:@"%@",[object valueForKey:@"name"]]: [object valueForKey:@"priority"]};
        NSLog(@"TEMPYYY %@", temp);
        [array addObject:temp]; //append dictionary values into outer array in correct format to send to firebase
    }
    
    NSLog(@"OUTER ARRAY: %@", array);

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
    
    //fetch all coredata and put into json format to be able to write to firebase
    [self fetchTasksFromCoreData];
    
    // upload to firebase in background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //To save to firebase not working but did not have time to fix this - can do at a later date
        [CustomFirebaseDbClass setData:array];
        NSLog(@"DATA ARRAY FROM FB CLASS: %@", [CustomFirebaseDbClass getData]);
        [CustomFirebaseDbClass saveToFirebase];
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
