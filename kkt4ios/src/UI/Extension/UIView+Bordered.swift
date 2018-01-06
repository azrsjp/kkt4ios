//
//  Bordered.swift
//  kkt4ios
//
//  Created by tt on 2018/01/06.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor.init(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor) }
        set { self.layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
