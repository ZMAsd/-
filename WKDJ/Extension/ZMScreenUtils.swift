//
//  ZMScreenUtils.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import Foundation
import UIKit

public enum AppFrame {
    static let screenBounds = UIScreen.main.bounds
    static let screenWidth = screenBounds.size.width
    static let screenHeight = screenBounds.size.height
    
    static let isIPhoneX = screenHeight >= 812 ? true : false
    
    static let kNavigationBarH = isIPhoneX ? (64 + 24) : 64
    static let kTabbarH = isIPhoneX ? (49 + 34) : 49
    static let kCornerRadius = CGFloat(5)
}

public enum AppColor {
    static let testColor = UIColor.purple
    static let ctaColor = UIColor.init(red: 42/255.0, green: 255/255.0, blue: 248/255.0, alpha: 1.0)
    static let whiteColor = UIColor.white
    static let backgroundColor = UIColor.init(red: 12/255.0, green: 15/255.0, blue: 24/255.0, alpha: 1.0)
    static let themeColor = UIColor.init(red: 22/255.0, green: 28/255.0, blue: 42/255.0, alpha: 1.0)
    static let clearColor = UIColor.clear
}

public enum APPFont {
    static let mainFont = UIFont.systemFont(ofSize: 18)
    static let secFont = UIFont.systemFont(ofSize: 15)
    static let thrFont = UIFont.systemFont(ofSize: 13)
}

