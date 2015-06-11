//
//  Course.m
//  Core Data
//
//  Created by KaL on 9/7/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import "Course.h"


@implementation Course

@dynamic title;
@dynamic author;
@dynamic releaseDate;

// if u want add behaviors to deal with intialization

// this method is called when a manage object is instatiated
- (void)awakeFromInsert {
    [super awakeFromInsert];
    
    // sets the current date when a new course is created
    self.releaseDate = [NSDate date];
}


@end
