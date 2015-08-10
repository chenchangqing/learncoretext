//
//  ForeGroundColorStyle.swift
//  example03
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

// 富文本颜色
class ForeGroundColorStyle: AttributedStyle {
   
    class func attributedStyle(#color:UIColor, range:NSRange) -> AttributedStyle {
        
        return super.getInstance(attributeName: NSForegroundColorAttributeName, value: color, range: range)
    }
}
