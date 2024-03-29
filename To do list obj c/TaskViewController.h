//
//  TaskViewController.h
//  To do list obj c
//
//  Created by Haider Ashfaq on 26/02/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomFirebaseDbClass.h"
#import <CoreData/CoreData.h>


@interface TaskViewController : UIViewController {
    
}

//MARK:- Outlets
@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *taskPriorityTextField;

//MARK:- Actions
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;
- (void)fetchTasksFromCoreData;


//MARK:- Properties
@property (strong) NSManagedObject *task;

@end

