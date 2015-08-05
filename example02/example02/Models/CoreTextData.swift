//
//  CoreTextData.swift
//  example02
//
//  Created by green on 15/8/5.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

// 用于保存由CTFrameParser类生成的CTFrameRef实例以及CTFrameRef实际绘制需要的高度
class CoreTextData: NSObject {
    
    var ctFrame     : CTFrameRef!   // 文字渲染区域的信息
    var height      : CGFloat!      // 实际绘制需要的高度
    
    init(ctFrame:CTFrameRef,height:CGFloat) {
        
        self.ctFrame    = ctFrame
        self.height     = height
    }

}
