//
//  QKSliderView.m
//  BannerTest
//
//  Created by qkzhu on 21/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

#import <objc/runtime.h>
#import "QKSlider.h"
#import "QKSliderViewLayout.h"

@interface QKSliderView () <UICollectionViewDelegate>

@end


@implementation QKSliderView

#pragma mark - life cycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithRowsPerPage:(NSInteger)rows
                     columnsPerPage:(NSInteger)columns
                           cellGapH:(CGFloat)gapH
                           cellGapV:(CGFloat)gapV
                    cellRemainWidth:(CGFloat)remainWidth {
    if (self = [super init]) {
        self.rows = rows;
        self.columns = columns;
        self.cellGapH = gapH;
        self.cellGapV = gapV;
        self.cellRemainWidth = remainWidth;
        
        [self commonInit];
    }
    return self;
}


#pragma mark - getter setter
// rows
- (NSInteger)rows { return [self getQKLayout].rows; }
- (void)setRows:(NSInteger)rows { [self getQKLayout].rows = rows; }

// columns
- (NSInteger)columns { return [self getQKLayout].columns; }
- (void)setColumns:(NSInteger)columns { [self getQKLayout].columns = columns; }

// cell gap Horizontal
- (CGFloat)cellGapH { return [self getQKLayout].cellGapH; }
- (void)setCellGapH:(CGFloat)cellGapH { [self getQKLayout].cellGapH = cellGapH; }

// cell gap Vertial
- (CGFloat)cellGapV { return [self getQKLayout].cellGapV; }
- (void)setCellGapV:(CGFloat)cellGapV { [self getQKLayout].cellGapV = cellGapV; }

// cell remaind width
- (CGFloat)cellRemainWidth { return [self getQKLayout].cellRemainWidth; }
- (void)setCellRemainWidth:(CGFloat)cellRemainWidth { [self getQKLayout].cellRemainWidth = cellRemainWidth; }


#pragma mark - private helper
- (void)commonInit {
    self.collectionViewLayout = [[QKSliderViewLayout alloc] initWithNumOfRowsPerPage:self.rows
                                                              numberOfColumnsPerPage:self.columns
                                                                            cellGapH:self.cellGapH
                                                                            cellGapV:self.cellGapV 
                                                                     cellRemainWidth:self.cellRemainWidth];
    self.delegate = self;
    
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (nullable QKSliderViewLayout *)getQKLayout {
    return [self.collectionViewLayout isKindOfClass:[QKSliderViewLayout class]] ? (QKSliderViewLayout *)self.collectionViewLayout : nil;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    QKSliderViewLayout *layout = [self getQKLayout];
    if (layout){
        *targetContentOffset = [layout scrollOffsetForProposedOffset:(*targetContentOffset) withVelocity:velocity.x];
    }
    
    if (self.forwardingDelegate
        && [self.forwardingDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
    {
        [self.forwardingDelegate scrollViewWillEndDragging:scrollView
                                              withVelocity:velocity
                                       targetContentOffset:targetContentOffset];
    }
}


/*
 This method is forwarded NOT from `forwardingTargetForSelector`,
 because `scrollView` is the superview of collectionview,
 and `scrollView` did response for `scrollViewDidScroll`.
 
 Thus `respondsToSelector` will consider `scrollViewDidScroll has a responder before check forwardingDelegate`.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.forwardingDelegate && [self.forwardingDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.forwardingDelegate scrollViewDidScroll:scrollView];
    }
}


#pragma mark - delegate forwarding
- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    if (!result && self.forwardingDelegate) {
        // only forwarding `UICollectionViewDelegate` related selector
        struct objc_method_description md = protocol_getMethodDescription(@protocol(UICollectionViewDelegate), aSelector, NO, YES);
        if (md.name != NULL) {
            result = [self.forwardingDelegate respondsToSelector:aSelector];
        }
    }
    
    return result;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (self.forwardingDelegate) {
        // only forwarding `UICollectionViewDelegate` related selector
        struct objc_method_description md = protocol_getMethodDescription(@protocol(UICollectionViewDelegate), aSelector, NO, YES);
        if (md.name != NULL) {
            return self.forwardingDelegate;
        }
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - public methods
- (void)invalidateLayout {
    [[self getQKLayout] invalidateLayout];
}

@end
