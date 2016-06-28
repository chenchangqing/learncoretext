//
//  ConfigAttributedString.swift
//  example04
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

class ConfigAttributedString: NSObject {
   
    var attribute   : String!       // 富文本属性
    var value       : AnyObject!    // 富文本值
    var range       : NSRange!      // 富文本范围值
    
    // 通用型配置
    class func getInstance(attribute:String, value:AnyObject, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute     = attribute
        config.value         = value
        config.range         = range
        
        return config
    }
    
    // 配置字体
    class func getFontInstance(font:UIFont, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSFontAttributeName
        config.value     = font
        config.range     = range
        
        return config
    }
    
    // 配置字体颜色
    class func getForegroundColorInstance(foregroundColor:UIColor, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSForegroundColorAttributeName
        config.value     = foregroundColor
        config.range     = range
        
        return config
    }
    
    // 配置字体背景颜色
    class func getBackgroundColorInstance(backgroundColor:UIColor, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSBackgroundColorAttributeName
        config.value     = backgroundColor
        config.range     = range
        
        return config
    }
    
    // 配置文字的中划线
    class func getStrikethroughStyleInstance(strikethroughStyle:NSInteger, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSStrikethroughStyleAttributeName
        config.value     = strikethroughStyle
        config.range     = range
        
        return config
    }
    
    // 段落样式(需要将UILabel中的numberOfLines设置成0才有用)
    class func getParagraphStyleInstance(paragraphStyle:NSMutableParagraphStyle, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSParagraphStyleAttributeName
        config.value     = paragraphStyle
        config.range     = range
        
        return config
    }
    
    // 字间距
    class func getKernInstance(kern:Float, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSKernAttributeName
        config.value     = NSNumber(float: kern)
        config.range     = range
        
        return config
    }
    
    // 配置文字的下划线
    class func getUnderlineStyleInstance(underlineStyle:Int, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSUnderlineStyleAttributeName
        config.value     = NSNumber(integer: underlineStyle)
        config.range     = range
        
        return config
    }
    
    // MARK: - 字体描边颜色 \ 描边宽度 \ 阴影 (以下两个方法可以一起使用)
    
    class func getStrokeColorInstance(strokeColor:UIColor, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSStrokeColorAttributeName
        config.value     = strokeColor
        config.range     = range
        
        return config
    }
    
    class func getStrokeWidthInstance(strokeWidth:Float, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSStrokeWidthAttributeName
        config.value     = NSNumber(float: strokeWidth)
        config.range     = range
        
        return config
    }
    
    class func getShadowInstance(shadow:NSShadow, range:NSRange) -> ConfigAttributedString {
        
        let config = ConfigAttributedString()
        
        config.attribute = NSShadowAttributeName
        config.value     = shadow
        config.range     = range
        
        return config
    }
    
    
    
}
