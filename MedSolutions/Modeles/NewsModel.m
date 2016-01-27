//
//  NewsModel.m
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dataArr" : @"data",
              @"spotlight" : @"spotlight"
             };
}

+ (NSValueTransformer *)dataArrJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:NewsDataModel.class];
}

+ (NSValueTransformer *)spotlightJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:NewsPreviewModel.class];
}

- (NewsDataModel*)getDataModel;
{
    if (self.dataArr && self.dataArr.count > 0) {
        return self.dataArr[0];
    }
    return nil;
}


- (NewsPreviewModel*)getFirstSpotlight {
    if (self.spotlight.count > 0) {
        return self.spotlight[0];
    }
    return nil;
}

- (NewsPreviewModel*)getSecondSpotligt {
    if (self.spotlight.count > 1) {
        return self.spotlight[1];
    }
    return nil;
}

@end
