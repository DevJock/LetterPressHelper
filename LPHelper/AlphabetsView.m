//
//  AlphabetsView.m
//  LPHelper
//
//  Created by Chiraag Bangera on 7/26/16.
//  Copyright © 2016 GlitchApocalypse. All rights reserved.
//

#import "AlphabetsView.h"
#import "AppDelegate.h"

@interface AlphabetsView ()
{
    NSMutableArray *chars;
    int count;
    NSMutableArray *chosenOnes;
    NSString *holder;
    AppDelegate *appDelegate;
}

@end
@implementation AlphabetsView



static NSString * const reuseIdentifier = @"theCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    chars = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",
                                                                                @"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",
                                                                                @"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor blackColor];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/3.2 , 100);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [chars count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    if(cell.backgroundColor != [UIColor greenColor])
    {
        label.text = [chars objectAtIndex:indexPath.row];
        label.textColor = [UIColor whiteColor];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    if(cell.backgroundColor == [UIColor greenColor])
    {
        label.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
        NSString *remover = [chars objectAtIndex:indexPath.row];
        for(int i=0;i<[chosenOnes count];i++)
        {
            if([[chosenOnes objectAtIndex:i] isEqualToString:remover])
            {
                [chosenOnes removeObjectAtIndex:i];
                count --;
            }
        }
    }
    else
    {
        label.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor greenColor];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Character Count" message:[NSString stringWithFormat:@"Enter the Number of times %@ Repeats",[chars objectAtIndex:indexPath.row]] delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert textFieldAtIndex:0].delegate = self;
        [alert textFieldAtIndex:0].placeholder = @"Enter Repeatation Count";
        holder = [chars objectAtIndex:indexPath.row];
        [alert show];
    }
    self.title = [NSString stringWithFormat:@"%d / 25 Letters",count];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    int val = [[alertView textFieldAtIndex:0].text intValue];
    if(val >0)
    {
        for(int i=0;i<val;i++)
        {
            [chosenOnes addObject:holder];
        }
        count +=val;
    }
    self.title = [NSString stringWithFormat:@"%d / 25 Letters",count];
}

@end
