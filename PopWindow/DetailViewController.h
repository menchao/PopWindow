//
//  DetailViewController.h
//  PopWindow
//
//  Created by menchao on 16/5/28.
//  Copyright © 2016年 menchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

