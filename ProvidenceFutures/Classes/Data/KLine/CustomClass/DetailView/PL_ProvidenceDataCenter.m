//
//  PL_ProvidenceDataCenter.m
//  GLKLineKit
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//  Copyright © 2018年 walker. All rights reserved.
//

#import "PL_ProvidenceDataCenter.h"

@interface PL_ProvidenceDataCenter ()

/**
 居左Text attributes
 */
@property (strong, nonatomic) NSDictionary *leftAttributes;


/**
 居右 Text attributes
 */
@property (strong, nonatomic) NSDictionary *rightAttributes;



/**
 contentArray
 */
@property (strong, nonatomic) NSArray *contentArray;

@end

@implementation PL_ProvidenceDataCenter


/**
 更新内容
 
 @param models 内容数组
 */
- (void)updateContentWithDetailModels:(NSArray <DetailDataModel *>*)models {
    
    if (models && models.count > 0) {
        if (models.count != self.contentArray.count) {
            self.contentArray = [models copy];
            // 更新Frame
            [self PL_ProvidenceupdateFrame];
            
        }else {
            self.contentArray = [models copy];
        }
        
    }else {
        self.contentArray = @[];
    }
    

    
    [self setNeedsDisplay];
}



- (void)PL_Providenceinitialize {
    
    ;
    
    self.rowHeight = 20.0f;
    self.textFont = [UIFont systemFontOfSize:13.0f];
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.insets = UIEdgeInsetsMake(0, 2.0f, 0, 2.0f);
}

- (void)PL_ProvidenceupdateFrame {
    
    if (self.contentArray.count > 0) {
        CGRect newRect = self.frame;
        newRect.size.height = self.contentArray.count * self.rowHeight;
        self.frame = newRect;
    }
}

- (void)PL_ProvidencedrawContentWithDataModel:(DetailDataModel *)model context:(CGContextRef)context textRect:(CGRect)textRect {
    
    if (!model) {
        return;
    }
    
//    [NSObject PL_ProvidencedrawTextInRect:textRect text:model.name attributes:self.leftAttributes];
    [NSObject PL_ProvidencedrawVerticalCenterTextInRect:textRect text:model.name attributes:self.leftAttributes];
    [NSObject PL_ProvidencedrawVerticalCenterTextInRect:textRect text:model.desc attributes:self.rightAttributes];

//    [NSObject PL_ProvidencedrawTextInRect:textRect text:model.desc attributes:self.rightAttributes];
    
}

#pragma mark - 懒加载 ---

- (NSArray *)contentArray {
    if (!_contentArray) {
        _contentArray = @[].mutableCopy;
    }
    return _contentArray;
}

- (NSDictionary *)leftAttributes {
    if (!_leftAttributes) {
        // 居中
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentLeft;
        // 属性：字体，颜色
        _leftAttributes = @{
                        NSFontAttributeName:self.textFont,       // 字体
                        NSForegroundColorAttributeName:self.textColor,   // 字体颜色
                        NSParagraphStyleAttributeName:style,   // 段落样式
                        };
    }
    return _leftAttributes;
}

- (NSDictionary *)rightAttributes {
    if (!_rightAttributes) {
        // 居右
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentRight;
        // 属性：字体，颜色
        _rightAttributes = @{
                            NSFontAttributeName:self.textFont,       // 字体
                            NSForegroundColorAttributeName:self.textColor,   // 字体颜色
                            NSParagraphStyleAttributeName:style,   // 段落样式
                            };
    }
    return _rightAttributes;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self PL_Providenceinitialize];;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (!(self.contentArray && self.contentArray.count > 0)) {
        
        return;
    }
    
    [NSObject PL_ProvidencedrawTextBackGroundInRect:rect content:ctx boderColor:[UIColor colorWithHexString:@"0xeeeeee"] boderWidth:1.0f fillColor:[[UIColor colorWithHexString:@"0x666666"] colorWithAlphaComponent:0.6]];
    
    for (NSInteger a = 0; a < self.contentArray.count; a ++) {
        DetailDataModel *tempModel = self.contentArray[a];
        CGRect textRect = CGRectMake(rect.origin.x + self.insets.left, a * self.rowHeight, rect.size.width - (self.insets.left + self.insets.right), self.rowHeight);
        
        [self PL_ProvidencedrawContentWithDataModel:tempModel context:ctx textRect:textRect];
    }
}


@end

@implementation DetailDataModel

- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc {
    if (self = [super init]) {
        self.name = name;
        self.desc = desc;
    }
    return self;
}

@end
