//
//  CTFrameParser.swift
//  example02
//
//  Created by green on 15/8/5.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

// 用于生成最后绘制界面需要的CTFrameRef实例
class CTFrameParser: NSObject {
    
    /**
    * 根据配置及需要渲染的文字生成渲染需要的数据
    * @param content 需要渲染的文字 NSAttributedString
    * @param config  配置信息
    * @return 渲染需要的数据
    */
    class func parse(attributeStr content:NSAttributedString, config:CTFrameParserConfig) -> CoreTextData {
        
        // 创建 CTFramesetterRef 实例
        let framesetter = CTFramesetterCreateWithAttributedString((content as CFAttributedStringRef))
        
        // 获得要绘制的区域的高度
        let restrictSize = CGSizeMake(config.width, CGFloat.max)
        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil)
        let textHeight   = coreTextSize.height
        
        // 生成 CTFrameRef 实例
        let frame = self.createFrame(framesetter, config: config, height: textHeight)
        
        // 将生成好的 CTFrameRef 实例和计算好的绘制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
        let data = CoreTextData(ctFrame: frame, height: textHeight)
        
        return data
    }
   
    /**
     * 根据配置及需要渲染的文字生成渲染需要的数据
     * @param content 需要渲染的文字 String
     * @param config  配置信息
     * @return 渲染需要的数据
     */
    class func parse(content:String, config:CTFrameParserConfig) -> CoreTextData {
        
        let attributes      = self.attributes(config)
        let contentString   = NSAttributedString(string: content, attributes: attributes)
        
        return self.parse(attributeStr: contentString, config: config)
    }
    
    /**
     * 应用文字配置信息
     * @param config 配置信息
     * @return 文字基本属性
     */
    class func attributes(config:CTFrameParserConfig) -> [NSObject : AnyObject]? {
        
        // 字体大小
        let fontSize    = config.fontSize
        let fontRef     = CTFontCreateWithName("ArialMT", fontSize, nil)
        
        // 行间距
        var lineSpacing = config.lineSpace
        
        var setting01   = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.LineSpacingAdjustment, valueSize: sizeof(CGFloat), value: &lineSpacing)
        var setting02   = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.MaximumLineSpacing, valueSize: sizeof(CGFloat), value: &lineSpacing)
        var setting03   = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.MinimumLineSpacing, valueSize: sizeof(CGFloat), value: &lineSpacing)
        
        var settings:[CTParagraphStyleSetting]  = [setting01,setting02,setting03]
        let theParagraphRef                     = CTParagraphStyleCreate(&settings, settings.count)
        
        // 字体颜色
        let textColor = config.textColor
        
        // 封装
        let dict = [
            NSForegroundColorAttributeName: textColor,
            (kCTFontAttributeName as NSObject):(fontRef as AnyObject),
            (kCTParagraphStyleAttributeName as NSObject):(theParagraphRef as AnyObject)
        ]
        return dict
    }
    
    /**
     * 创建矩形文字区域
     * @param framesetter 文字内容
     * @param 配置信息 
     * @param 高度
     * @retrun 矩形文字区域
     */
    class func createFrame(framesetter:CTFramesetterRef,config:CTFrameParserConfig,height:CGFloat) -> CTFrameRef {
        
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, CGRectMake(0, 0, config.width, height))
        
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        return frame
    }
}
