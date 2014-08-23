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
    NSMutableDictionary *itemss;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        itemss = [@{@"itemInfo" : [@[] mutableCopy] } mutableCopy];
        
//        items = [@[]mutableCopy];
        
//        items = ([self loadItemData]) ? [self loadItemData]:[@[] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *newItem = [[UIBarButtonItem alloc]initWithTitle:@"New" style:UIBarButtonItemStyleDone target:self action:@selector(newItemButton)];
    self.navigationItem.rightBarButtonItem = newItem;

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self saveItemData];
    [self.tableView reloadData];
}

- (void)newItemButton
{
    // alloc/init a new view controller here
    ItemInfoVC = [[NAItemInfoVC alloc]init];
    ItemInfoVC.itemInfo = itemss[@"itemInfo"];

    [self.navigationController pushViewController:ItemInfoVC animated:YES];
    ItemInfoVC.view.backgroundColor = [UIColor whiteColor];
    
//    ItemInfoVC.itemInfo = items;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSMutableArray *items = itemss[@"itemInfo"];
    // to access the key:itemInfo of the Dictionary

    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
//    cell.textLabel.text = items[indexPath.row][@"itemInfo"];
    cell.textLabel.text = itemss[@"itemInfo"][indexPath.row][@"text"];
    
    NSLog(@"%@",itemss[@"itemInfo"][indexPath.row]);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      // passing the the array to the subclass
//    ItemInfoVC.itemInfo = items[indexPath.row];
  
    
}

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

- (void)saveItemData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:itemss];
    [data writeToFile:[self itemFilePath] atomically:YES];
}

- (NSArray *)loadItemData
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self itemFilePath]];
}

- (NSString *)itemFilePath
{
    NSArray *documentdirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = documentdirectory[0];
    
    return [path stringByAppendingPathComponent:@"items.data"];
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



@end
