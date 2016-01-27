//
//  NewsModel.h
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/Overcoat.h>
#import "NewsDataModel.h"
#import "NewsPreviewModel.h"

@interface NewsModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSArray * dataArr;
@property (copy, nonatomic, readonly) NSArray<NewsPreviewModel*> * spotlight;

- (NewsDataModel*) getDataModel;
- (NewsPreviewModel*)getFirstSpotlight;
- (NewsPreviewModel*)getSecondSpotligt;

@end
