//
//  AlphabetViewController.h
//  LPHelper
//
//  Created by Chiraag Bangera on 7/27/16.
//  Copyright © 2016 GlitchApocalypse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphabetViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *horizontalCollection;

@property (strong, nonatomic) IBOutlet UICollectionView *verticalCollection;


@end
