//
//  ParagraphAttributes.swift
//  example04
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

class ParagraphAttributes: NSObject {
    
    var textColor           = TextColor
    var textFont            = UIFont(name: QingKeBengYue, size: 16)
    var lineSpacing         = NSNumber(float: 5)                                     // 段落样式 - 行间距
    var paragraphSpacing    = NSNumber(float: 10)                                    // 段落样式 - 段间距
    var firstLineHeadIndent = NSNumber(float: 36)                                    // 段落样式 - 段首文字缩进
    var kern                = NSNumber(float: 0)                                     // 字间距
    
    /**
     * 创建富文本属性字典
     */
    func createAttributes() -> [NSObject : AnyObject] {
        
        var attributes = [NSObject : AnyObject]()
        
        attributes[NSForegroundColorAttributeName]  = textColor
        attributes[NSFontAttributeName]             = textFont
        attributes[NSKernAttributeName]             = kern
        
        // 段落样式
        let style                   = NSMutableParagraphStyle()
        
        style.lineSpacing           = CGFloat(lineSpacing.floatValue)
        style.paragraphSpacing      = CGFloat(paragraphSpacing.floatValue)
        style.firstLineHeadIndent   = CGFloat(firstLineHeadIndent.floatValue)
        
        attributes[NSParagraphStyleAttributeName]   = style
        
        return attributes
    }
   
}
