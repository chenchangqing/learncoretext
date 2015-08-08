//
//  CTFrameParser.m
//  example02
//
//  Created by green on 15/8/8.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

#import "CTFrameParserCAPI.h"

@implementation CTFrameParserCAPI

static CGFloat ascentCallback(void *ref){
    
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void* ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

+ (NSAttributedString *)parseToNSAttributedString:(NSDictionary *)imageTemplateDic attributes:(NSDictionary *) attributes {
    
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    
    // 避免野指针 可能是因为swift调用引起
    NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                          [imageTemplateDic objectForKey:@"width"],@"width",
                          [imageTemplateDic objectForKey:@"name"],@"name",
                          [imageTemplateDic objectForKey:@"height"],@"height",
                          nil];
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(temp));
    
    // 使用0xFFFC作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString * content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString * space = [[NSMutableAttributedString alloc] initWithString:content
                                                                               attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1),
                                   kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}

+ (CGRect)findImagePosition:(CTFrameRef) ctFrame ctRunIndex:(NSInteger) ctRunIndex {
    
    NSArray *lines = (NSArray *)CTFrameGetLines(ctFrame);
    NSUInteger lineCount = [lines count];
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    NSInteger imgIndex = 0;
    
    for (int i = 0; i < lineCount; ++i) {
        
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray * runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        for (id runObj in runObjArray) {
            
            if (ctRunIndex == imgIndex) {
                
                CTRunRef run = (__bridge CTRunRef)runObj;
                NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
                CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
                if (delegate == nil) {
                    continue;
                }
                
                NSDictionary * metaDic = CTRunDelegateGetRefCon(delegate);
                if (![metaDic isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
                
                CGRect runBounds;
                CGFloat ascent;
                CGFloat descent;
                runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                runBounds.size.height = ascent + descent;
                
                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                runBounds.origin.x = lineOrigins[i].x + xOffset;
                runBounds.origin.y = lineOrigins[i].y;
                runBounds.origin.y -= descent;
                
                CGPathRef pathRef = CTFrameGetPath(ctFrame);
                CGRect colRect = CGPathGetBoundingBox(pathRef);
                
                CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
                return  delegateBounds;
            }
            
            imgIndex ++;
        }
    }
    return  CGRectMake(0, 0, 0, 0);
}
@end
