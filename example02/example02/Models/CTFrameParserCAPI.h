//
//  CTFrameParser.h
//  example02
//
//  Created by green on 15/8/8.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFrameParserCAPI : NSObject

/**
 * 返回图片占位字符串
 * @param imageTemplateDic 图片信息字典
 * @param attributes 配置属性
 *
 * @return 图片占位符
 */
+ (NSAttributedString *)parseToNSAttributedString:(NSDictionary *)imageTemplateDic attributes:(NSDictionary *) attributes;

/**
 * 返回指定图片的坐标系
 * @param ctFrame 文字区域
 * @param ctRunIndex 图片坐在CTRunRef数组的位置
 * 
 * @return 图片坐标
 */
+ (CGRect)findImagePosition:(CTFrameRef) ctFrame ctRunIndex:(NSInteger) ctRunIndex ;

/**
 * 返回字符串的偏移量
 * @param view 视图
 * @param point 触摸点
 * @param textFrame 富文本区域
 * 
 * @return 触摸点偏移量
 */
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(CTFrameRef)textFrame;

@end
