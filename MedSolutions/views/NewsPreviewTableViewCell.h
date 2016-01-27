//
//  NewsPreviewCellTableViewCell.h
//  MedSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsPreviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *NewsPreviewImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;

@end
