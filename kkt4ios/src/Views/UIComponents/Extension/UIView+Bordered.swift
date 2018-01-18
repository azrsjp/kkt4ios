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
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
