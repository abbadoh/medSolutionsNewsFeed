//
//  NewsPreviewModel.h
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/Overcoat.h>

@interface NewsPreviewModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber * newsId;
@property (copy, nonatomic, readonly) NSString * title;
@property (copy, nonatomic, readonly) NSURL * imageUrl;
@property (copy, nonatomic, readonly) NSString * newsDescription;
@property (copy, nonatomic, readonly) NSString * createdAt;
@property (copy, nonatomic, readonly) NSURL * thumbnailUrl;

- (NSString*)getTimeAndDateOfCreation;

@end
