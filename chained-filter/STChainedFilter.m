//
//  STChainedFilter.m
//  chained-filter
//
//  Created by sodas on 12/23/14.
//  Copyright (c) 2014 sodastsai. All rights reserved.
//

#import "STChainedFilter.h"

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
        [newFilters addObject:[filter copy]];
    }];
    chainFilter.inputFilters = [[NSArray alloc] initWithArray:newFilters];

    return chainFilter;
}

- (CIImage *)outputImage {
    CIImage *__block image = self.inputImage;
    [self.inputFilters enumerateObjectsUsingBlock:^(id filter, NSUInteger idx, BOOL *stop) {
        if ([filter isKindOfClass:[CIFilter class]]) {
            [(CIFilter *)filter setValue:image forKey:kCIInputImageKey];
            image = [(CIFilter *)filter valueForKey:kCIOutputImageKey];
        } else {
            image = ((STChainedFilterBlock)filter)(image);
        }
    }];
    return image;
}

@end
