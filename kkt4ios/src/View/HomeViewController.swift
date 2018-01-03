//
//  ViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/02.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- private
    
    private func setupView() {
        if let image = UIImage(named: "bg_main.png") {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        
        let headerMenu = HeaderMenu()
        headerMenu.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 80)
        self.view.addSubview(headerMenu)
    }
}

