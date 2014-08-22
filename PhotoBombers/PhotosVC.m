//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by KaL on 7/27/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "PhotosVC.h"
#import "PhotoCell.h"

@interface PhotosVC ()

@end

@implementation PhotosVC

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    
    return (self = [super initWithCollectionViewLayout:layout]);
}



- (void)viewDidLoad
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.title = @"Photo Bombers";


    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}




@end
