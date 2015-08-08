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
    * CoreTextData实例
    * @param attributedString 需要渲染的文字
    * @param config  配置信息
    *
    * @return 渲染需要的数据
    */
    class func parseToCoreTextData(#attributedString:NSAttributedString, config:CTFrameParserConfig) -> CoreTextData {
        
        // 创建 CTFramesetterRef 实例
        let framesetter = CTFramesetterCreateWithAttributedString((attributedString as CFAttributedStringRef))
        
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
     * CoreTextData实例
     * @param normalString 需要渲染的文字
     * @param config  配置信息
     *
     * @return 渲染需要的数据
     */
    class func parseToCoreTextData(#normalString:String, config:CTFrameParserConfig) -> CoreTextData {
        
        let attributes      = self.attributes(config)
        let content         = NSAttributedString(string: normalString, attributes: attributes)
        
        return self.parseToCoreTextData(attributedString: content, config: config)
    }
    
    /**
    * CoreTextData实例
    * @param templatePath 模板
    * @param config  配置信息
    *
    * @return 渲染需要的数据
    */
    class func parseToCoreTextData(#templatePath:String, config:CTFrameParserConfig) -> CoreTextData {
        
        
        var imageArray          = [CoreTextImageData]()
        let content             = self.parseToNSAttributedString(templatePath: templatePath, config: config, imageArray:imageArray)
        let coreTextData        = self.parseToCoreTextData(attributedString: content, config: config)
        coreTextData.imageArray = imageArray
        return coreTextData
    }
    
    /**
    * NSAttributedString实例
    * @param templatePath 模板
    * @param config 配置信息
    *
    * @return 富文本
    */
    class func parseToNSAttributedString(#templatePath:String,config:CTFrameParserConfig,var imageArray:[CoreTextImageData]) -> NSAttributedString {
        
        let data = NSData(contentsOfFile: templatePath)
        let result = NSMutableAttributedString()
        
        if let data=data {
            
            // 开始解析
            let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [[String:String]]
            
            if let array=array {
                
                for dic in array {
                    
                    let type = dic["type"]
                    
                    // 文本类型
                    if type == "txt" {
                        
                        let subStr = self.parseToNSAttributedString(textTemplateDic: dic, config: config)
                        result.appendAttributedString(subStr)
                    }
                    
                    if type == "image" {
                        
                        let imageData = CoreTextImageData()
                        imageData.name  = dic["name"]
                        imageData.imagePosition = CGRectMake(0, 0, 0, 0)
                        imageArray.append(imageData)
                        
                        let subStr = self.parseToNSAttributedString(imageTemplateDic: dic, config: config)
                        result.appendAttributedString(subStr)
                    }
                }
            }
        }
        
        return result
    }
    
    /**
     * NSAttributedString实例
     * @param textTemplateDic 文字属性字典
     * @param config 配置信息
     * 
     * @return 富文本
     */
    class func parseToNSAttributedString(#textTemplateDic:[String:String],config:CTFrameParserConfig) -> NSAttributedString {
        
        var attributes      = self.attributes(config)
        
        // 设置颜色
        let colorValue = textTemplateDic["color"]
        if let colorValue = colorValue {
            
            attributes[NSForegroundColorAttributeName] = ColorHelper.hexStringToUIColor(colorValue)
        }
        
        // 设置大小
        let sizeValue = textTemplateDic["size"]
        if let sizeValue = sizeValue {
            
            let cgsize = CGFloat((sizeValue as NSString).floatValue)
            
            if cgsize > 0  {
                
                attributes[NSFontAttributeName] = UIFont(name: "ArialMT", size: cgsize)
            }
        }
        
        // 文字
        let contentStr = textTemplateDic["content"] != nil ? textTemplateDic["content"] : ""
        
        return NSAttributedString(string: contentStr!, attributes: attributes)
    }
    
    /**
    * NSAttributedString实例
    * @param textTemplateDic 图片属性字典
    * @param config 配置信息
    *
    * @return 富文本
    */
    class func parseToNSAttributedString(#imageTemplateDic:[String:String],config:CTFrameParserConfig) -> NSAttributedString {
        
        return NSAttributedString()
    }
    
    // MARK: -
    
    /**
     * 应用文字配置信息
     * @param config 配置信息
     * @return 文字基本属性
     */
    class func attributes(config:CTFrameParserConfig) -> [NSObject : AnyObject] {
        
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
