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
//{
//    NSMutableArray *items;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.items = [@[
                    
                    @{@"Category":@"Movies",
                      @"Name":@"TMNT, Transformers"
                      },
                    @{ @"Category":@"Foods",
                       @"Name":@"Pizza, Hamburgers, chicken",
                       },
                    @{ @"Category":@"Tv Shows",
                       @"Name":@"Family Matters, Full House",
                       },
                    @{ @"Category":@"Anime",
                       @"Name":@"Bleach, Naruto",
                       }
                    ]mutableCopy];
    
    
    UITableView *theTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    theTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:theTableView];
    
    theTableView.delegate = self;
    theTableView.dataSource = self;
    
    [theTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray * keys = [items[section][@"text"] allKeys];

    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    NSArray * keys = [self.items[indexPath.row]allKeys];
//    cell.textLabel.text = keys[indexPath.row];
    
//    NSString * value = items[indexPath.row][@"text"]z
    
    cell.textLabel.text = self.items[indexPath.row][@"Category"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailVC *DetailViewC = [[DetailVC alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:DetailViewC animated:YES];
    NSLog(@"%@", (NSString*)self.items[indexPath.row]);
    DetailViewC.detailInfo = self.items[indexPath.row][@"Name"];
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
