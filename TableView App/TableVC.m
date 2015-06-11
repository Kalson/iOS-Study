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
    DetailVC *DetailViewC;
    NSArray *keys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *actorImage = [UIImage imageNamed:@"Shia"];
   
    // tryn to store dictionary is order can be a problems sometimes
    
    
    self.items = [@[
                    
                    @{
                        @"keys":@[@"Category",@"Image",@"Movies"],
                        // this just for fact that we wanted a true value within that dictionary (which is referring to a cell, in this case), even if it was in a different dictionary it would still be true
                        
                        @"Category":@"Movies",
                        @"Image":actorImage,
                        @"Movies":@"Disturbia, Wall Street: Money Never Sleeps, Eagle Eye, Tranformers, Indiana Jones, Lawless",
                        },
                    
                    @{
                      
                      @"keys":@[@"Category",@"Name",@"Info"],
                      
                      @"Category":@"Favorite Actor",
                      @"Name":@"Shia LaBeouf",
                      @"Info":@"Shia Saide LaBeouf is an American actor and director who became known among younger audiences as Louis Stevens in the Disney Channel series Even Stevens.LaBeouf received a Young Artist Award nomination in 2001 and won a Daytime Emmy Award in 2003 for his role. He made his film debut in Holes (2003), based on the novel of the same name by Louis Sachar. In 2004, he made his directorial debut with the short film Let's Love Hate and later directed a short film titled Maniac (2011), starring American rappers Cage and Kid Cudi.In 2007, LaBeouf starred in the lead role of the commercially successful films Disturbia and Surf's Up. The same year he was cast in Michael Bay's science fiction film Transformers as Sam Witwicky, the main protagonist of the series. Despite mixed reviews, Transformers was a box office success and one of the highest grossing films of 2007. LaBeouf later appeared in its sequels Transformers: Revenge of the Fallen (2009) and Transformers: Dark of the Moon (2011), both also box office successes. In 2008, he played Henry Mutt Williams Jones III in Indiana Jones and the Kingdom of the Crystal Skull, the fourth film in the Indiana Jones franchise. His other films include Wall Street: Money Never Sleeps (2010), Lawless (2012), The Company You Keep (2012) and Nymphomaniac (2013). "
                      },
                    
                    @{
                        @"keys":@[@"Category",@"Name",@"MapLocation"],

                        @"Category":@"Location",
                       @"Name":@"San Francisco,CA",
                       @"MapLocation":@"Disturbia"
                       },
                    
                    @{
                        @"keys":@[@"Category",@"Name",@"Info"],
                        
                        @"Category":@"Foods",
                       @"Name":@"Pizza, Hamburgers, chicken",
                       @"Info":@"Shia Saide",
                       },
                    
                    @{
                        @"keys":@[@"Category",@"Name",@"Info"],

                        @"Category":@"Tv Shows",
                       @"Name":@"Family Matters, Full House",
                       @"Info":@"Shia Saide",
                       },
                    
                    @{
                        @"keys":@[@"Category",@"Name",@"Info"],

                        @"Category":@"Anime",
                       @"Name":@"Bleach, Naruto",
                       @"Info":@"Shia Saide",
                       }

                    ]mutableCopy];
    
    self.title = @"TableView Practice";
    
    
    UITableView *theTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    theTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:theTableView];
    
    theTableView.delegate = self;
    theTableView.dataSource = self;
    
    [theTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [theTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"photocell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Kool";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    view.backgroundColor = [UIColor colorWithRed:0.945f green:0.945f blue:0.945f alpha:1.0f];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 305, 30)];
    
    label.text = @"Kool";
    
    [view addSubview:label];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray * keys = [items[section][@"text"] allKeys];

    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    keys = self.items[indexPath.row][@"keys"];

    
    if ([keys containsObject:@"Category"])
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.text = self.items[indexPath.row][@"Category"];
        cell.detailTextLabel.text = keys[0];

        
    } else {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_subtitle"];
        cell.textLabel.text = self.items[indexPath.row][@"Category"];
        cell.detailTextLabel.text = keys[0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewC = [[DetailVC alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:DetailViewC animated:YES];
    
    keys = self.items[indexPath.row][@"keys"];
//    DetailViewC.movieInfo.backgroundColor = [UIColor greenColor];
    
    if ([keys containsObject:@"Image"]) {
        DetailViewC.image = self.items[indexPath.row][@"Image"];
    }
    
 
    NSLog(@"%@", (NSString*)self.items[indexPath.row]);
    DetailViewC.detailName = self.items[indexPath.row][@"Name"];
    DetailViewC.detailInfo = self.items[indexPath.row][@"Info"];
    
    if (keys ) {
        DetailViewC.image = self.items[indexPath.row][@"Image"];

    }
    DetailViewC.detailMovieInfo = self.items[indexPath.row][@"Movies"];
//    DetailViewC.detailName = self.items[indexPath.row][@"Movies"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
