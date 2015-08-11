//
//  ParagraphAttributes+Constructor.swift
//  example04
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

//let QingKeBengYue:String = "FZQKBYSJW--GB1-0"
let QingKeBengYue:String = "ArialMT"
let TextColor = UIColor(red: 0.600, green: 0.490, blue: 0.376, alpha: 1)

extension ParagraphAttributes {
    
    // 便利构造器
    class func qingKeBengYue() -> [NSObject:AnyObject] {
        
        let config = ParagraphAttributes()
        
        config.textColor = TextColor
        config.textFont = UIFont(name: QingKeBengYue, size: 16)
        config.lineSpacing = NSNumber(float: 10)
        config.paragraphSpacing = NSNumber(float: 40)
        config.firstLineHeadIndent = NSNumber(float: 0)
        config.kern                = NSNumber(float: 0)
        
        return config.createAttributes()
    }
}