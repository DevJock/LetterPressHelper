//
//  ViewController.h
//  LPHelper
//
//  Created by Chiraag Bangera on 7/25/16.
//  Copyright © 2016 GlitchApocalypse. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *smallCollectionView;
@property (strong, nonatomic) IBOutlet UITableView *smallTableView;

- (IBAction)optionButtonPressed:(id)sender;

- (IBAction)processButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *wordLable;
@end

