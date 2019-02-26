//
//  QKSliderViewLayout.m
//  QKSliderView
//
//  Created by qkzhu on 15/2/19.
//  Copyright © 2019 QianKun. All rights reserved.
//

#import "QKSliderViewLayout.h"

#define QKSLIDER_DEFAULT_ROWS 1
#define QKSLIDER_DEFAULT_COLUMNS 1
#define QKSLIDER_DEFAULT_GAP_H 8.0f
#define QKSLIDER_DEFAULT_GAP_V 4.0f
#define QKSLIDER_DEFAULT_REMAINDER_WIDTH 16.0f


@interface QKSliderViewLayout()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;

@end


@implementation QKSliderViewLayout

#pragma mark - life cycle
- (instancetype)initWithNumOfRowsPerPage:(NSInteger)rows
                  numberOfColumnsPerPage:(NSInteger)columns
                                cellGapH:(CGFloat)gapH
                                cellGapV:(CGFloat)gapV
                         cellRemainWidth:(CGFloat)remainWidth
{
    if (self = [super init])
    {
        self.rows = rows < 1 ? QKSLIDER_DEFAULT_ROWS : rows;
        self.columns = columns < 1 ? QKSLIDER_DEFAULT_COLUMNS : columns;
        self.cellGapH = gapH < 0 ? QKSLIDER_DEFAULT_GAP_H : gapH;
        self.cellGapV = gapV < 0 ? QKSLIDER_DEFAULT_GAP_V : gapV;
        self.cellRemainWidth = remainWidth < 0 ? QKSLIDER_DEFAULT_REMAINDER_WIDTH : remainWidth;
    }
    
    return self;
}

- (instancetype)init
{
    // using default value for all settings
    return [self initWithNumOfRowsPerPage:QKSLIDER_DEFAULT_ROWS
                   numberOfColumnsPerPage:QKSLIDER_DEFAULT_COLUMNS
                                 cellGapH:QKSLIDER_DEFAULT_GAP_H
                                 cellGapV:QKSLIDER_DEFAULT_GAP_V
                          cellRemainWidth:QKSLIDER_DEFAULT_REMAINDER_WIDTH];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.rows = QKSLIDER_DEFAULT_ROWS;
        self.columns = QKSLIDER_DEFAULT_COLUMNS;
        self.cellGapH = QKSLIDER_DEFAULT_GAP_H;
        self.cellGapV = QKSLIDER_DEFAULT_GAP_V;
        self.cellRemainWidth = QKSLIDER_DEFAULT_REMAINDER_WIDTH;
    }
    
    return self;
}


#pragma mark - setter
- (void)setRows:(NSInteger)rows
{
    _rows = rows < 1 ? QKSLIDER_DEFAULT_ROWS : rows;
}

- (void)setColumns:(NSInteger)columns
{
    _columns = columns < 1 ? QKSLIDER_DEFAULT_COLUMNS : columns;
}


#pragma mark - overriding
- (void)prepareLayout
{
    if (!self.collectionView) { return; }
    if (self.cache.count > 0) { [self reset]; }
    
    NSInteger totalData = [self.collectionView numberOfItemsInSection:0];
    NSInteger totalCellCountPerPage = self.rows * self.columns;
    
    CGFloat totalWidthPerPage = CGRectGetWidth(self.collectionView.frame) - 2 * self.cellRemainWidth - 2 * self.cellGapH;
    CGFloat cellWidth = (totalWidthPerPage - self.cellGapH * (self.columns - 1)) / self.columns;
    CGFloat cellHeight = (CGRectGetHeight(self.collectionView.frame) - self.cellGapV * (self.rows + 1)) / self.rows;
    
    for (NSInteger i = 0; i < totalData; i++)
    {
        /* All currentPage index, cellCol value and cellRow value starts from 0. */
        NSInteger currentPage = i / totalCellCountPerPage;
        NSInteger reminder = i % totalCellCountPerPage;
        NSInteger cellCol = currentPage * self.columns + reminder / self.rows;
        NSInteger cellRow = reminder % self.rows;
        
        CGFloat xOffset = self.cellRemainWidth + self.cellGapH + cellCol * (cellWidth + self.cellGapH);
        CGFloat yOffset = self.cellGapV + cellRow * (cellHeight + self.cellGapV);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGRect frame = CGRectMake(xOffset, yOffset, cellWidth, cellHeight);
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = frame;
        [self.cache addObject:attribute];
        
        self.contentWidth = MAX(CGRectGetMaxX(frame), self.contentWidth);
    }
    
    self.contentHeight = CGRectGetHeight(self.collectionView.frame);
    self.contentWidth += (self.cellRemainWidth + self.cellGapH);
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *visibleAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in self.cache)
    {
        if ( !CGRectIsNull(CGRectIntersection(attribute.frame, rect)) )
        {
            [visibleAttributes addObject:attribute];
        }
    }
    
    return visibleAttributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cache objectAtIndex:indexPath.item];
}

- (void)invalidateLayout
{
    [super invalidateLayout];
    [self reset];
}


#pragma mark - lazy
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)cache
{
    if (!_cache)
    {
        _cache = [NSMutableArray array];
    }
    
    return _cache;
}


#pragma mark - public method
- (CGPoint)scrollOffsetForProposedOffset:(CGPoint)offset withVelocity:(CGFloat)velocity;
{
    CGFloat offsetX = offset.x - self.cellRemainWidth;
    CGFloat pageContentWidth = CGRectGetWidth(self.collectionView.frame) - self.cellGapH - 2 * self.cellRemainWidth;
    
    CGFloat overshoot = fmodf(offsetX, pageContentWidth);
    
    /* velocity is zero or overshoot less than a quoter of page width. */
    if (velocity == 0 && overshoot < (pageContentWidth - self.cellGapH) * 0.25)
    {
        offset.x -= overshoot;
        offset.x -= self.cellRemainWidth;
        return offset;
    }
    
    if (velocity > 0)
    {
        if ((overshoot > (pageContentWidth - self.cellGapH) * 0.5) || velocity > 0.2)
        {
            offset.x += (pageContentWidth - overshoot);
        }
        else
        {
            offset.x -= overshoot;
        }
    }
    else
    {
        if ((overshoot > (pageContentWidth - self.cellGapH) * 0.5) || velocity < -0.2)
        {
            offset.x -= overshoot;
        }
        else
        {
            offset.x += (pageContentWidth - overshoot);
        }
    }
    
    offset.x -= self.cellRemainWidth;
    
    return offset;
}


#pragma mark - private methods
- (void)reset
{
    [self.cache removeAllObjects];
    self.contentWidth = 0;
    self.contentHeight = 0;
}

@end
