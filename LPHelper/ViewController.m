//
//  ViewController.m
//  LPHelper
//
//  Created by Chiraag Bangera on 7/25/16.
//  Copyright © 2016 GlitchApocalypse. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
//smallCell

@interface ViewController ()
{
    NSMutableArray  *possibleWords;
    NSMutableArray *letters;
    int letterCount;
    AppDelegate *appDelegate;
}
@end

@implementation ViewController
@synthesize smallCollectionView;
@synthesize smallTableView;
@synthesize wordLable;

static NSString * const reuseIdentifier = @"smallCell";

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if(appDelegate.characters != NULL)
    {
        letters = [[NSMutableArray alloc] initWithArray:appDelegate.characters];
        [smallCollectionView reloadData];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     letters = [[NSMutableArray alloc] initWithObjects:@"J",@"O",@"R",@"C",@"A",
                                                                                        @"N",@"D",@"J",@"F",@"N",
                                                                                                               @"V",@"I",@"O",@"T",@"T",
                                                                                                                @"H",@"B",@"T",@"S",@"O",
                                                                                                                @"Y",@"N",@"U",@"J",@"R",nil];
     /**/
    possibleWords = [[NSMutableArray alloc] init];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.smallCollectionView.delegate = self;
    self.smallCollectionView.dataSource = self;
    self.smallTableView.delegate = self;
    self.smallTableView.dataSource = self;

    self.smallCollectionView.backgroundColor = [UIColor whiteColor];
    letterCount = 5;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)processWord:(NSMutableArray *)letterList 
{
    NSString* file = [[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"txt"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:file];
    int offset = 0;
    int chunkSize = 1024;     //Read 1KB chunks.
    NSData *data = [handle readDataOfLength:chunkSize];
    int wordsFound = 0;
    while ([data length] > 0)
    {
        //Make sure for the next line you choose the appropriate string encoding.
        NSString *dataChunk = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray *words = [dataChunk componentsSeparatedByString:@"\n"];
        for(int i=0;i<(int)[words count];i++)
        {
            NSString *word = [[words objectAtIndex:i] uppercaseString];
            NSString *wordCopy = word;
            //NSLog(@"WORD: %@",word);
            int count = 0;
            int wordCount = (int)[word length];
            NSMutableArray *localLetters = [[NSMutableArray alloc] initWithArray:letterList];
            if(wordCount < letterCount)
            {
                continue;
            }
            for(int j=0;j<(int)[localLetters count];j++)
            {
               // NSLog(@"STR: %@",word);
                for(int k=0;k<wordCount;k++)
                {
                    NSString *wordChar = [word substringWithRange:NSMakeRange(k, 1)];
                    if([wordChar isEqualToString:[localLetters objectAtIndex:j]])
                    {
                       // NSLog(@"MATCHED: %@",wordChar);
                        count++;
                        word = [word stringByReplacingCharactersInRange:NSMakeRange(k, 1) withString:@"_"];
                        [localLetters setObject:@"#" atIndexedSubscript:j];
                    }
                }
            }
            if(count == wordCount)
            {
                wordsFound++;
                [possibleWords addObject:wordCopy];
            }
        }
        offset += [data length];
        [handle seekToFileOffset:offset];
        data = [handle readDataOfLength:chunkSize];
    }
    [handle closeFile];
    NSLog(@"TOTAL: %d",wordsFound);
    wordLable.text = [NSString stringWithFormat:@"Words Found: %d",wordsFound];
    [smallTableView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [letters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    label.text = [letters objectAtIndex:indexPath.row];
    label.textColor = [UIColor blackColor];
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [possibleWords count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [smallTableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    UILabel *label1 = (UILabel *)[cell viewWithTag:100];
    label1.text = [NSString stringWithFormat:@"%d.",((int)indexPath.row+1)];
    UILabel *label2 = (UILabel *)[cell viewWithTag:200];
    label2.text = [possibleWords objectAtIndex:indexPath.row];
    return cell;
}


- (IBAction)optionButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Word Size" message:@"Enter Minimum Word Size" delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].delegate = self;
    [alert textFieldAtIndex:0].placeholder = [NSString stringWithFormat:@"%d",letterCount];
    [alert textFieldAtIndex:0].textAlignment = NSTextAlignmentCenter;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    letterCount = [[alertView textFieldAtIndex:0].text intValue];
}

- (IBAction)processButtonPressed:(id)sender
{
    if(letters != NULL)
    {
        [possibleWords removeAllObjects];
        [smallTableView reloadData];
        wordLable.text = @"";
        NSLog(@"Started");
        [self performSelectorInBackground:@selector(processWord:) withObject:letters];
        NSLog(@"DONE");
    }
}
@end
