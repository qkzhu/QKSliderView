//
//  QKSliderViewLayout.h
//  QKSliderView
//
//  Created by qkzhu on 15/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QKSliderViewLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, assign) CGFloat cellGapH;
@property (nonatomic, assign) CGFloat cellGapV;
@property (nonatomic, assign) CGFloat cellRemainWidth;


- (instancetype)initWithNumOfRowsPerPage:(NSInteger)rows
                  numberOfColumnsPerPage:(NSInteger)columns
                                cellGapH:(CGFloat)gapH
                                cellGapV:(CGFloat)gapV
                         cellRemainWidth:(CGFloat)remainWidth;


- (CGPoint)scrollOffsetForProposedOffset:(CGPoint)offset withVelocity:(CGFloat)velocity;

@end

NS_ASSUME_NONNULL_END
