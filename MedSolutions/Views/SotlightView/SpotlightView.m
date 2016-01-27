//
//  SpotlightView.m
//  MedSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "SpotlightView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SpotlightView()

@property (strong, nonatomic) NewsPreviewModel * model;

@end


@implementation SpotlightView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap)];
        [self addGestureRecognizer:singleFingerTap];
    }
    return self;
}

- (void)initWithNewsPreviewModel:(NewsPreviewModel *)model {
    self.model = model;
    [self.imageView sd_setImageWithURL:model.imageUrl];
    self.titleLabel.text = model.title;
    self.newsId = model.newsId;
}

-(void) handleSingleTap{
    [self.delegate onSpotlighViewWithModelTap:self.model];
}

//after nib-loading
- (void)awakeFromNib
{
}

//custom layerout
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
