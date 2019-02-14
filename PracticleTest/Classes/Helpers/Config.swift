//
//  ViewController.swift
//  StaterPack-iOS-swift-4.0
//
//  Created by Kasun Gayashan on 2/7/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import Foundation
import UIKit
import L10n_swift

enum FontWeight {
    case light
    case regular
    case bold
}

class Config{
    
    static func setFont(size:CGFloat!, weight:FontWeight!) -> UIFont
    {
        switch (weight){
        case .light?:
            return UIFont(name: "Lato-Light", size: size)!
        case .regular?:
            return UIFont(name: "Lato-Regular", size: size)!
        case .bold?:
            return UIFont(name: "Lato-Bold", size: size)!
        default:
            return UIFont(name: "Lato-Regular", size: size)!
        }
    }
    
}
