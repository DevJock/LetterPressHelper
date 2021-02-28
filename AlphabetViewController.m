//
//  AlphabetViewController.m
//  LPHelper
//
//  Created by Chiraag Bangera on 7/27/16.
//  Copyright © 2016 GlitchApocalypse. All rights reserved.
//

#import "AlphabetViewController.h"
#import "AppDelegate.h"

@interface AlphabetViewController ()
{
    NSMutableArray *chars;
    int count;
    NSMutableArray *chosenOnes;
    AppDelegate *appDelegate;
}
@end

@implementation AlphabetViewController

@synthesize horizontalCollection;
@synthesize verticalCollection;

- (void)viewDidLoad
{
    [super viewDidLoad];
    chars = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",
             @"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",
             @"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    chosenOnes = [[NSMutableArray alloc] init];
    
    self.horizontalCollection.delegate = self;
    self.horizontalCollection.dataSource = self;
    self.horizontalCollection.backgroundColor = [UIColor blackColor];
    
    self.verticalCollection.delegate = self;
    self.verticalCollection.dataSource = self;
    self.verticalCollection.backgroundColor = [UIColor blackColor];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    chosenOnes = [[NSMutableArray alloc] init];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    appDelegate.characters = [[NSMutableArray alloc] initWithArray:chosenOnes];
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == verticalCollection)
    {
        return CGSizeMake(collectionView.frame.size.width/3.2 , 100);
    }
    else
    {
        return CGSizeMake(collectionView.frame.size.width /6, collectionView.frame.size.height);
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(collectionView == verticalCollection)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == verticalCollection)
    {
        return [chars count];
    }
    else
    {
        return [chosenOnes count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == verticalCollection)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"upCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:100];
        if(cell.backgroundColor != [UIColor greenColor])
        {
            label.text = [chars objectAtIndex:indexPath.row];
            label.textColor = [UIColor whiteColor];
        }
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sideCell" forIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:100];
        if(cell.backgroundColor != [UIColor grayColor])
        {
            label.text = [chosenOnes objectAtIndex:indexPath.row];
            label.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor grayColor];
        }
        return cell;
    }
    
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == verticalCollection)
    {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        UILabel *label = (UILabel *)[cell viewWithTag:100];
        if(cell.backgroundColor != [UIColor greenColor])
        {
            label.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor greenColor];
            count++;
            [chosenOnes addObject:[chars objectAtIndex:indexPath.row]];
            [horizontalCollection reloadData];
            cell.backgroundColor = [UIColor blackColor];
            label.textColor = [UIColor whiteColor];
        }
        self.title = [NSString stringWithFormat:@"%d / 25 Letters",count];
    }
    else
    {
        count--;
        [chosenOnes removeObjectAtIndex:indexPath.row];
        [horizontalCollection reloadData];
        self.title = [NSString stringWithFormat:@"%d / 25 Letters",count];
    }
}




@end
