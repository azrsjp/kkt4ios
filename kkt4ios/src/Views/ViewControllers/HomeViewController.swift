//
//  ViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/02.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import KYDrawerController
import RxCocoa
import RxSwift
import UIKit
import XLPagerTabStrip

class HomeViewController: BarPagerTabStripViewController {

    @IBOutlet var headerMenu: HeaderMenu!

    private let disposeBag = DisposeBag()
    private let myTlVC = MyTimeLineViewController()
    private let localTlVC = LocalTimelineViewController()
    private let notiVC = NotificationViewController()
    private let favVC = FavoriteViewController()
    private let searchVC = SearchViewController()

    // MARK: - Static

    static func withDrawer() -> UIViewController {
        let withDraerVC = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        let mainViewController = HomeViewController()
        let drawerViewController = DrawerViewController()

        withDraerVC.mainViewController = mainViewController
        withDraerVC.drawerViewController = drawerViewController

        return withDraerVC
    }

    override func viewDidLoad() {
        configureButtonBarStyle()
        setupView()
        registerHeaderMenuHandling()

        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PagerTabStripDataSource

    override func viewControllers(for _: PagerTabStripViewController) -> [UIViewController] {
        return [self.myTlVC, self.localTlVC, self.notiVC, self.favVC, self.searchVC]
    }

    // MARK: - private

    private func onTapKatsu() {
        let katsuFormVC: UIViewController = KatsuFormViewController()

        present(katsuFormVC, animated: true, completion: nil)
    }

    private func setupView() {
        if let image = UIImage(named: "bg_main.png") {
            view.backgroundColor = UIColor(patternImage: image)
        }
    }

    private func configureButtonBarStyle() {
        settings.style.barBackgroundColor = UIColor.yellow
        settings.style.selectedBarBackgroundColor = UIColor.blue
        settings.style.barHeight = 4
    }

    private func registerHeaderMenuHandling() {
        headerMenu.myTlButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.myTlVC, animated: true)
            }).disposed(by: disposeBag)

        headerMenu.localTlButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.localTlVC, animated: true)
            }).disposed(by: disposeBag)

        headerMenu.notiButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.notiVC, animated: true)
            }).disposed(by: disposeBag)

        headerMenu.favButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.favVC, animated: true)
            }).disposed(by: disposeBag)

        headerMenu.searchButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.moveTo(viewController: self!.searchVC, animated: true)
            }).disposed(by: disposeBag)

        headerMenu.katsuButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onTapKatsu()
            }).disposed(by: disposeBag)
    }
}
