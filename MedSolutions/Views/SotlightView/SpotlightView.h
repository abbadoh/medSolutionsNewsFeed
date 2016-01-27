//
//  SpotlightView.h
//  MedSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsPreviewModel.h"

@protocol SpotlightViewDelegate
-(void)onSpotlighViewWithModelTap:(NewsPreviewModel*)model;
@end


@interface SpotlightView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSNumber * newsId;

@property (nonatomic, weak) id <SpotlightViewDelegate> delegate;

- (void)initWithNewsPreviewModel:(NewsPreviewModel*)model;

@end
