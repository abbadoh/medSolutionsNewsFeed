//
//  NewsDataModel.h
//  MedSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/Overcoat.h>

@interface NewsDataModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber * newsId;
@property (copy, nonatomic, readonly) NSString * lead;
@property (copy, nonatomic, readonly) NSString * text;
@property (copy, nonatomic, readonly) NSURL * sourceUrl;

@end
