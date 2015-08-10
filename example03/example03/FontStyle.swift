//
//  FontStyle.swift
//  example03
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

// 富文本字体
class FontStyle: AttributedStyle {
    
    class func attributedStyle(#font:UIFont, range:NSRange) -> AttributedStyle {
        
        return super.getInstance(attributeName: NSFontAttributeName, value: font, range: range)
    }
   
}
