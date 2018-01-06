//
//  ImageButton.swift
//  kkt4ios
//
//  Created by tt on 2018/01/06.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIButton {

    @IBInspectable var imageWithAspectFit: UIImage? {
        get { return self.image(for: UIControlState.normal) }
        set {
            self.setImage(newValue, for: UIControlState.normal)
            self.configureImageAspect()
        }
    }
    
    // MARK: - private
    
    private func configureImageAspect() {
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
    }
}
