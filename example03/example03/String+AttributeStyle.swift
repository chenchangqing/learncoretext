//
//  NSString+AttributeStyle.swift
//  example03
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 green. All rights reserved.
//

import Foundation

extension String {
    
    /**
     *  根据styles数组创建出富文本
     *
     *  @param styles AttributedStyle对象构成的数组
     *
     *  @return 富文本
     */
    func createAttributedStringWithStyles(styles:[AttributedStyle]) -> NSAttributedString? {
        
        if styles.count == 0 {
            
            return nil
        }
        
        let attributedString = NSMutableAttributedString(string: self)
        
        for style in styles {
            
            attributedString.addAttribute(style.attributeName, value: style.value, range: style.range)
        }
        return attributedString
    }
}