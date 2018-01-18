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
        get { return image(for: UIControlState.normal) }
        set {
            setImage(newValue, for: UIControlState.normal)
            configureImageAspect()
        }
    }

    // MARK: - private

    private func configureImageAspect() {
        imageView?.contentMode = .scaleAspectFit
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
    }
}
