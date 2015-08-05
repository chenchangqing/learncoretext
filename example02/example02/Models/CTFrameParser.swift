//
//  CTFrameParser.swift
//  example02
//
//  Created by green on 15/8/5.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

class CTFrameParser: NSObject {
   
    class func parse(content:String, config:CTFrameParserConfig) -> CoreTextData {
        
        let attributes = self.attributes(config)
        let contentString = NSAttributedString(string: content, attributes: attributes)
        
        // 创建 CTFramesetterRef 实例
        let framesetter = CTFramesetterCreateWithAttributedString((contentString as CFAttributedStringRef))
        
        // 获得要绘制的区域的高度
        let restrictSize = CGSizeMake(config.width, CGFloat.max)
        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil)
        let textHeight   = coreTextSize.height
        
        // 生成 CTFrameRef 实例
        let frame = self.createFrame(framesetter, config: config, height: textHeight)
        
        // 将生成好的 CTFrameRef 实例和计算好的绘制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
        let data = CoreTextData()
        data.ctFrame = frame
        data.height = textHeight
        
        return data
    }
    
    class func attributes(config:CTFrameParserConfig) -> [NSObject : AnyObject]? {
        
        let fontSize = config.fontSize
        let fontRef = CTFontCreateWithName("ArialMT", fontSize, nil)
        var lineSpacing = config.lineSpace
        var setting01 = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.LineSpacingAdjustment, valueSize: sizeof(CGFloat), value: &lineSpacing)
        var setting02 = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.MaximumLineSpacing, valueSize: sizeof(CGFloat), value: &lineSpacing)
        var setting03 = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.MinimumLineSpacing, valueSize: sizeof(CGFloat), value: &lineSpacing)
        var settings:[CTParagraphStyleSetting] = [setting01,setting02,setting03]
        let theParagraphRef = CTParagraphStyleCreate(&settings, settings.count)
        
        let textColor = config.textColor
        
        let dict = [(kCTForegroundColorAttributeName as NSObject): textColor.CGColor,(kCTFontAttributeName as NSObject):(fontRef as AnyObject),(kCTParagraphStyleAttributeName as NSObject):(theParagraphRef as AnyObject)]
        return dict
    }
    
    class func createFrame(framesetter:CTFramesetterRef,config:CTFrameParserConfig,height:CGFloat) -> CTFrameRef {
        
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, CGRectMake(0, 0, config.width, height))
        
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        return frame
    }
}
