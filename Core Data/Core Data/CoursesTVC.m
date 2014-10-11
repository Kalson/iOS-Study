//
//  CoursesTVC.m
//  Core Data
//
//  Created by KaL on 9/7/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import "CoursesTVC.h"
#import "Course.h"

// when the app loads and the TVC appears, we want it to fetch all the course entities out of the core data store

// when u execute a fetch request u get an array of manage objects

@interface CoursesTVC ()

@end

@implementation CoursesTVC

@synthesize fetchedResultsController = _fetchedResultsController;
// use the synthesize statement b/c we want to use the underscore format, for the internal instance variable here and also so we can write our own lazy instantiation method to create this fetch results controller object and create it the right way

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addCourse"]){
        // create a new pointer to addcourse View controller
        AddCourseVC *acVC = (AddCourseVC *)[[segue destinationViewController]topViewController];
        // we created AddCourseVC and sets its delegate to self (meaning me)
        // ur delegate is me, so look back to me when somebody clicks the cancel or save button
        acVC.delegate = self;
        
        // creating the new course managed object
        Course *newCourse = (Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:[self manageObjectContext]];
        
        // and with that new course object created, we can reach into the modal window were about to segue to and say hey here ur current course, its this object. if u want to change it, change it (save it). If u don't u can cancel back out of it and get rid of it.
        acVC.currentCourse = newCourse;
    
    }
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // execute the fetch request
    // we perform a fetch similar to the way we save in manageobjectcontext by creating a NSError and pass it in to let us know if anything wrong happen
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]){
        NSLog(@"Error! %@",error);
        abort(); // shows an abort message
    }
}

- (void)addCourseViewControllerDidSave
{
    // now we need to respond to these delegate methods
    
    NSError *error = nil;
    NSManagedObjectContext *context = self.manageObjectContext;
    if (! [context save:&error]) {
        NSLog(@"Error! %@",error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCourseViewControllerDidCancel:(Course *)courseToDelete
{
    NSManagedObjectContext *context = self.manageObjectContext;
    [context deleteObject:courseToDelete];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetched results controller section
// the lazy instantiation method
// need have a method that returns an instance of a fetch result controller
- (NSFetchedResultsController *) fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        // we want to see if something inside the fetch results controller
        return _fetchedResultsController;
    }
    // you need fetch request and a sort decriptor to create a fetch results controller
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.manageObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"author"ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // fetch results controller object created
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.manageObjectContext sectionNameKeyPath:@"author" cacheName:nil];
    
    // look to me for any of the delegate methods in the fetch results controller
    _fetchedResultsController.delegate = self;
    
    // then return the accessor methods (for anybody that wants to ask for the fetch results controller property)
    return _fetchedResultsController;
}


#pragma mark - fetched results refresh
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // tell the table view that we're about to begin some updates
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // tell the table view to finish processing changes
    [self.tableView endUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    // grab hold of the table view that im working with and create a temporary placeholder for tableview instead of calling self.tableview repeatedly
    UITableView *myTableView = self.tableView;
    
    // what kind of change just happen (changetype)
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            // the change is an insert, so we tell the tableview to insert a particular row at the new index path w/ a path
            [myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            // tell the table view did update itself, but delete a particular row at the new index path w/ a path
            [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            // b/c were creating a new objects here, we have to wrap it w/ curly braces
            // if it a change we need to change the content of a particular cell
            
            // first were talking to the fetch results controller saying hey give me the course at ur particular index
            Course *changedCourse = [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            // then grabbing the current cell at the current location in the tableview
            UITableViewCell *cell = [myTableView cellForRowAtIndexPath:indexPath];
            
            // and change its title
            cell.textLabel.text = changedCourse.title;
        }
            break;
            
        case NSFetchedResultsChangeMove:
            // if something could move
            // deleting the original position
            [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            // and insert at the new position
             [myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    // we want to know if we create a new course object (add a new section) or if we delete the last course object in a section (we need to delete a section)
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    // were taking the results and putting in an id called secInfo and that has to comply with NSFetchedResultsSectionInfo protocol
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
    
    // then make sure it responds to how many objects we have
    return [secInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell... (should be Course objects here)
    
    // and ask the fetch results controller whats at particular index path right now
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // and this method is being called repeatedly for every row in every section passing in the index path
    
    cell.textLabel.text = course.title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // we want to jump into the fetch results controller, into the right section, into the right object, and get its name
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        // grab the manage object context
        NSManagedObjectContext *context = self.manageObjectContext;
        
        // ask the fetch results controller for whatever the object that being passed in
        Course *courseWereDeleted = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:courseWereDeleted];
        
        // to save the changes, to persist them
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
    }
    
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
