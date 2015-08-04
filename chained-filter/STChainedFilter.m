//
//  STChainedFilter.m
//  chained-filter
//
//  Created by sodas on 12/23/14.
//  Copyright (c) 2014 sodastsai. All rights reserved.
//

#import "STChainedFilter.h"

#pragma mark - Block filter

@implementation STBlockFilter

@synthesize inputBlock, inputImage;

+ (instancetype)blockFilterWithBlock:(CIImage *(^)(CIImage *))block {
    STBlockFilter *filter = [[self alloc] init];
    filter.inputBlock = block;
    return filter;
}

- (CIImage *)outputImage {
    return self.inputBlock(self.inputImage);
}

@end

#pragma mark - Chained filter

@implementation STChainedFilter

@synthesize inputImage, inputFilters;

+ (instancetype)chainedFilterWithFilters:(NSArray *)filters {
    STChainedFilter *filter = [[self alloc] init];
    filter.inputFilters = filters;
    return filter;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    STChainedFilter *chainFilter = [super copyWithZone:zone];

    NSMutableArray *newFilters = [[NSMutableArray alloc] initWithCapacity:[self.inputFilters count]];
    [self.inputFilters enumerateObjectsUsingBlock:^(CIFilter *filter, NSUInteger idx, BOOL *stop) {
        [newFilters addObject:[filter copyWithZone:zone]];
    }];
    chainFilter.inputFilters = [[NSArray alloc] initWithArray:newFilters];

    return chainFilter;
}

- (CIImage *)outputImage {
    CIImage *__block image = self.inputImage;
    [self.inputFilters enumerateObjectsUsingBlock:^(CIFilter * filter, NSUInteger idx, BOOL *stop) {
        [filter setValue:image forKey:kCIInputImageKey];
        image = [filter valueForKey:kCIOutputImageKey];
    }];
    return image;
}

@end
