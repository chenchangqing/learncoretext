//
//  ViewController.swift
//  example02
//
//  Created by green on 15/8/5.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 增加文字控件
        let textRect = CGRectInset(self.view.bounds, 10.0, 20.0)
        let textView = CTDisplayView(frame: textRect)
        self.view.addSubview(textView)
        
        // 配置
        let config = CTFrameParserConfig()
        config.textColor = UIColor.redColor()
        config.width = textRect.width
        
        // 数据
        let data = CTFrameParser.parse("按照以上原则，我们将`CTDisplayView`中的部分内容拆开。", config: config)
        textView.data = data
        textView.setHeight(data.height)
        textView.backgroundColor = UIColor.yellowColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

