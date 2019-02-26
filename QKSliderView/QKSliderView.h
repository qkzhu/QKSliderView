//
//  QKSliderView.h
//  BannerTest
//
//  Created by qkzhu on 21/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


IB_DESIGNABLE
@interface QKSliderView : UICollectionView

/**
 This library occupied `delegate` from `UICollectionView`, please use `forwardingDelegate` instead.
 */
@property (nonatomic, weak, nullable) id<UICollectionViewDelegate> forwardingDelegate;

@property (nonatomic, assign) IBInspectable NSInteger rows;
@property (nonatomic, assign) IBInspectable NSInteger columns;
@property (nonatomic, assign) IBInspectable CGFloat cellGapH;
@property (nonatomic, assign) IBInspectable CGFloat cellGapV;
@property (nonatomic, assign) IBInspectable CGFloat cellRemainWidth;


/** Disabled init with layout since layout is provided. */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;

/**
 Initializer with parameters:
 
 @param rows number of rows display per page
 @param columns number of columns display per page
 @param gapH distance between two horizontally adjacent cells
 @param gapV distance between two vertically adjacent cells
 @param remainWidth the distance for prevous horiztonal adjacent cell and next horizontal adjacent cell remain displays on the screen.
 */
- (instancetype)initWithRowsPerPage:(NSInteger)rows
                     columnsPerPage:(NSInteger)columns
                           cellGapH:(CGFloat)gapH
                           cellGapV:(CGFloat)gapV
                    cellRemainWidth:(CGFloat)remainWidth
NS_SWIFT_NAME(init(rows:columns:cellGapH:cellGapV:cellRemainWidth:));


/**
 Since `QKSliderViewLayout is not accessible to user, providing a helper function to reset layout.
 */
- (void)invalidateLayout NS_SWIFT_NAME(invalidateLayout());

@end

NS_ASSUME_NONNULL_END
