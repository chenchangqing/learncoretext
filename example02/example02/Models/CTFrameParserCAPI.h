//
//  CTFrameParser.h
//  example02
//
//  Created by green on 15/8/8.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFrameParserCAPI : NSObject

+ (NSAttributedString *)parseToNSAttributedString:(NSDictionary *)imageTemplateDic attributes:(NSDictionary *) attributes;

+ (CGRect)findImagePosition:(CTFrameRef) ctFrame ctRunIndex:(NSInteger) ctRunIndex ;

@end
