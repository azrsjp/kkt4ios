//
//  ViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/02.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: BarPagerTabStripViewController {

    override func viewDidLoad() {
        self.configureButtonBarStyle()
        self.setupView()

        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let myTlVC = MyTimeLineViewController()
        let localTlVC = LocalTimelineViewController()
        let notiVC = NotificationViewController()
        let favVC = FavoriteViewController()
        let searchVC = SearchViewController()

        return [myTlVC, localTlVC, notiVC, favVC, searchVC]
    }

    // MARK:- private
    
    private func setupView() {
        if let image = UIImage(named: "bg_main.png") {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    private func configureButtonBarStyle() {
        settings.style.barBackgroundColor = UIColor.yellow
        settings.style.selectedBarBackgroundColor = UIColor.blue
        settings.style.barHeight = 4
    }
}
