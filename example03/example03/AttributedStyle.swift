//
//  AttributedStyle.swift
//  example03
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

class AttributedStyle: NSObject {
   
    var attributeName:String!
    var value:AnyObject!
    var range:NSRange!
    
    /**
     *  便利构造器
     *
     *  @param attributeName 属性名字
     *  @param value         设置的值
     *  @param range         取值范围
     *
     *  @return 实例对象
     */
    class func getInstance(#attributeName:String, value:AnyObject, range:NSRange) -> AttributedStyle {
        
        let attributeStyle = AttributedStyle()
        
        attributeStyle.attributeName = attributeName
        attributeStyle.value = value
        attributeStyle.range = range
        
        return attributeStyle
    }
}
