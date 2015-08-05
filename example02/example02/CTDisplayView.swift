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
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        // 步骤 1
        let context = UIGraphicsGetCurrentContext()
        
        // 步骤 2
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        // 步骤 3
        let path = CGPathCreateMutable();
        CGPathAddRect(path, nil, self.bounds)
        
        // 步骤 4
        let testStr = "Hello World!创建绘制的区域，CoreText 本身支持各种文字排版的区域，我们这里简单地将 UIView 的整个界面作为排版的区域。"
        let attString = NSAttributedString(string: testStr)
        let framesetter = CTFramesetterCreateWithAttributedString((attString as CFAttributedStringRef))
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, count(testStr)), path, nil)
        
        // 步骤 5
        CTFrameDraw(frame, context);
    }
}
