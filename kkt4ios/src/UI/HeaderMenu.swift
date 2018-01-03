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
    @IBOutlet weak var myTlButton: UIButton!;
    @IBOutlet weak var localTlButton: UIButton!;
    @IBOutlet weak var notiButton: UIButton!;
    @IBOutlet weak var favButton: UIButton!;
    @IBOutlet weak var searchButton: UIButton!;
    @IBOutlet weak var katsuButton: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.loadNib()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.loadNib()
        self.setupView()
    }

    // MARK:- private
    
    private func loadNib(){
        let view = Bundle.main.loadNibNamed("HeaderMenu", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func setupView() {
        if let bgImage = UIImage(named: "bg_header.png") {
            self.backgroundColor = UIColor(patternImage: bgImage)
        }
    }
}

