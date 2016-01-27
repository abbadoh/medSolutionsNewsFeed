//
//  NewsDataModel.m
//  MedSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "NewsDataModel.h"

@implementation NewsDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"newsId": @"id",
             @"lead": @"lead",
             @"text": @"text",
             @"sourceUrl": @"source"
             };
}

@end
