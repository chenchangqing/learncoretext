//
//  String+GONMarkupDemo.swift
//  example03
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 green. All rights reserved.
//

import Foundation
import GONMarkupParser

extension String {
    
    /**
     * 获得标签代码
     *
     * @param mark 标签
     * 
     * @return 标签代码
     */
    func addColorMark(mark:String) -> String {
        
        if (mark as NSString).length == 0 {
            return ""
        }
        return "<color value=\"\(mark)\">\(self)</>"
    }
    
    /**
     * 使用GONMarkupParser创建富文本
     *
     * @return 富文本
     */
    func createAttributedStringWithGONMarkupParser() -> NSAttributedString {
        
        return GONMarkupParserManager.sharedParser().attributedStringFromString(self)
    }
}
