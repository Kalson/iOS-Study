//
//  CoursesTVC.m
//  Core Data
//
//  Created by KaL on 9/7/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import "CoursesTVC.h"
#import "Course.h"

@interface CoursesTVC ()

@end

@implementation CoursesTVC

@synthesize fetchedResultsController = _fetchedResultsController;
// use the synthesize statement b/c we want to use the underscore format, for the internal instance variable here and also so we can write our own lazy instantiation method to create this fetch results controller object and create it the right way

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addCourse"]){}
        // create a new pointer to addcourse View controller
    AddCourseVC *acVC = (AddCourseVC *)[segue destinationViewController];
    // we created AddCourseVC and sets its delegate to self (meaning me)
    // ur delegate is me, so look back to me when somebody clicks the cancel or save button
    acVC.delegate = self;
    
    // creating the new course managed object
    Course *newCourse = (Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.manageObjectContext];
    
    acVC.currentCourse = newCourse;
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
    
    // we perform a fetch similar to the way we save in manageobjectcontext by creating a NSError and pass it in to let us know if anything wrong happen
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]){
        NSLog(@"Error! %@",error);
        abort();
    }
}

- (void)addCourseViewControllerDidSave
{
    
}

- (void)addCourseViewControllerDidCancel:(Course *)courseToDelete
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetched results controller section
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
    
    // then return the accessor methods (for anybody that wants to ask for the fetch results controller property)
    return _fetchedResultsController;
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
    // Configure the cell...
    
    // and ask the fetch results controller whats at particular index path right now
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // and this method is being called repeatedly for every row in every section passing in the index path
    
    cell.textLabel.text = course.title;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
