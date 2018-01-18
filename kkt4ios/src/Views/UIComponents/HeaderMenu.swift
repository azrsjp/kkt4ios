//
//  HeaderMenu.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit

class HeaderMenu: UIView {
    @IBOutlet var myTlButton: UIButton!
    @IBOutlet var localTlButton: UIButton!
    @IBOutlet var notiButton: UIButton!
    @IBOutlet var favButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var katsuButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setupView()
    }

    // MARK: - private

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("HeaderMenu", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }

    private func setupView() {
        if let bgImage = UIImage(named: "bg_header.png") {
            backgroundColor = UIColor(patternImage: bgImage)
        }
    }
}
