//
//  STChainedFilter.h
//  chained-filter
//
//  Created by sodas on 12/23/14.
//  Copyright (c) 2014 sodastsai. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_feature(objc_generics)
#define STGenerics(...) <__VA_ARGS__>
#else
#define STGenerics(...)
#endif

NS_ASSUME_NONNULL_BEGIN

@interface STBlockFilter : CIFilter

+ (instancetype)blockFilterWithBlock:(CIImage *(^)(CIImage *))block;

@property (nonatomic, strong) CIImage *inputImage;
@property (nonatomic, copy) CIImage *(^inputBlock)(CIImage *);

@end

@interface STChainedFilter : CIFilter

+ (instancetype)chainedFilterWithFilters:(NSArray STGenerics(CIFilter *) *)filters;

@property (nonatomic, strong) NSArray STGenerics(CIFilter *) *inputFilters;
@property (nonatomic, strong) CIImage *inputImage;

@end

NS_ASSUME_NONNULL_END
