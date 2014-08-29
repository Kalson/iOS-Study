//
//  TableViewVC.m
//  TableView App
//
//  Created by KaL on 8/28/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "TableVC.h"
#import "DetailVC.h"

@interface TableVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TableVC
{
    NSMutableArray *items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    items = [@[
               
               @{
                 @"category": @"Foods",
                 @"name": @"Pizza"
                 },
                @{
                   @"category": @"Movies",
                   @"name":@"Transformers"
                   }
//
//                 @"Foods":@"Pizza",
//                 @"Tv Shows":@"Family Matters, Full House",
//                 @"Anime":@"Bleach, Naruto"
//               @{@"Foods":@"Pizza"},
//               @{@"Tv Shows":@"Family Matters, Full House"},
//               @{@"Anime":@"Bleach, Naruto"}

                 
        
               
               ]mutableCopy];
    
    
    
    
//    items = [@[
//               @"Movies",
//               @"Foods",
//               @"Tv Shows",
//               @"Anime"
//               
//               ]mutableCopy];
    
    UITableView *theTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    theTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:theTableView];
    
    theTableView.delegate = self;
    theTableView.dataSource = self;
    
    [theTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary * info = items[indexPath.row];
    
    cell.detailTextLabel.text = info[@"name"];
    cell.textLabel.text = info[@"category"];
    
//    NSString * value = items[indexPath.row][@"text"][keys[indexPath.row]];
    
//    cell.textLabel.text = items[indexPath.row][@"Foods"];
//    cell.textLabel.text = items[indexPath.row][@"Tv Shows"];
//    cell.textLabel.text = items[indexPath.row][@"Anime"];

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailVC *DetailViewC = [[DetailVC alloc]init];
    [self.navigationController pushViewController:DetailViewC animated:YES];
    DetailViewC.detailDict = items[indexPath.row];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
