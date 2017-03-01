//
//  To_do_list_obj_cTests.m
//  To do list obj cTests
//
//  Created by Haider Ashfaq on 26/02/2017.
//  Copyright © 2017 Haider Ashfaq. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>

@interface To_do_list_obj_cTests : XCTestCase

@property (nonatomic,retain) NSManagedObjectContext *moc;

@end

@implementation To_do_list_obj_cTests

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
