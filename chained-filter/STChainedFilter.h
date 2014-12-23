//
//  STChainedFilter.h
//  chained-filter
//
//  Created by sodas on 12/23/14.
//  Copyright (c) 2014 sodastsai. All rights reserved.
//

#import <UIKit/UIKit.h>

// Filters array should contain "CIFilter" or "STChainedFilterBlock" only.
@interface STChainedFilter : CIFilter

+ (instancetype)chainedFilterWithFilters:(NSArray *)filters;

@property (nonatomic, strong) NSArray *inputFilters;
@property (nonatomic, strong) CIImage *inputImage;

@end

typedef CIImage *(^STChainedFilterBlock)(CIImage *);
