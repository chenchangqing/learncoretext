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
        config.textColor = UIColor.blackColor()
        config.width = textRect.width
        
        // 数据
        let content =
                "对于上面的例子，我们给 CTFrameParser 增加了一个将 NSString 转" +
                "换为 CoreTextData 的方法。" +
                "但这样的实现方式有很多局限性，因为整个内容虽然可以定制字体" +
                "大小，颜色，行高等信息，但是却不能支持定制内容中的某一部分。" +
                "例如，如果我们只想让内容的前三个字显示成红色，而其它文字显" +
                "示成黑色，那么就办不到了。" +
                "\n\n" +
                "解决的办法很简单，我们让`CTFrameParser`支持接受" +
                "NSAttributeString 作为参数，然后在 NSAttributeString 中设置好" +
                "我们想要的信息。"
        let attributes = CTFrameParser.attributes(config)
        let contentAttributeStr = NSMutableAttributedString(string: content, attributes: attributes)
        contentAttributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 7))
        
        // 使用String
//        let data = CTFrameParser.parse(content, config: config)
        
        // 直接使用NSMutableAttributedString
        let data = CTFrameParser.parse(attributeStr: contentAttributeStr, config: config)
        
        textView.data = data
        textView.setHeight(data.height)
        textView.backgroundColor = UIColor.yellowColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

