//
//  CTDisplayView.swift
//  example02
//
//  Created by green on 15/8/5.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit
import CoreText

class CTDisplayView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor    = UIColor.whiteColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        // 当前上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 将坐标系上下翻转
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1, -1);
        
        // 矩形文字区域
        let path = CGPathCreateMutable();
        CGPathAddRect(path, nil, self.bounds)
        
        // 文字内容
        let testStr     = "Hello World!创建绘制的区域，CoreText 本身支持各种文字排版的区域，我们这里简单地将 UIView 的整个界面作为排版的区域。"
        let attString   = NSAttributedString(string: testStr)
        let framesetter = CTFramesetterCreateWithAttributedString((attString as CFAttributedStringRef))
        let frame       = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, count(testStr)), path, nil)
        
        // 绘制
        CTFrameDraw(frame, context);
    }
}
