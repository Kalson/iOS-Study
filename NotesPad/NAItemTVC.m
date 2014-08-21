//
//  NATableViewController.m
//  NotesPad
//
//  Created by KaL on 8/19/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "NAItemTVC.h"
#import "NAItemInfoVC.h"

@interface NAItemTVC ()

@end

@implementation NAItemTVC
{
    NAItemInfoVC *ItemInfoVC;
//    NSMutableDictionary *items;
    NSMutableArray *items;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        ItemInfoVC = [[NAItemInfoVC alloc]init];
        items = [@[]mutableCopy];
        
        items = ([self loadItemData]) ? [self loadItemData]:[@[] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *newItem = [[UIBarButtonItem alloc]initWithTitle:@"New" style:UIBarButtonItemStyleDone target:self action:@selector(itemButton)];
    self.navigationItem.rightBarButtonItem = newItem;

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self saveItemData];
    [self.tableView reloadData];
}

- (void)itemButton
{
    [self.navigationController pushViewController:ItemInfoVC animated:YES];
    ItemInfoVC.view.backgroundColor = [UIColor whiteColor];
    
    ItemInfoVC.itemInfo = items;;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    // why alloc/init again?
//    NSMutableArray *item = items[@"itemInfo"];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = items[indexPath.row][@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemInfoVC.itemInfo = items[indexPath.row];
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
- (void)saveItemData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items];
    [data writeToFile:[self itemFilePath] atomically:YES];
}

- (void)loadItemData
{
    [NSKeyedUnarchiver unarchiveObjectWithFile:[self itemFilePath]];
}

- (NSString *)itemFilePath
{
    NSArray *documentdirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = documentdirectory[0];
    
    return [path stringByAppendingPathComponent:@"items.data"];
}

@end
