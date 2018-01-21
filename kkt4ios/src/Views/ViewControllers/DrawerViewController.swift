//
//  DrawerViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import XLPagerTabStrip

class DrawerViewController: PagedViewControllerBase {

    @IBOutlet var logoutButton: UIButton!

    private let disposeBag = DisposeBag()
    private let drawerViewModel = DrawerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        bindInput()
        bindOutput()
    }

    // MARK: - private

    private func moveToLogin() {
        let loginVC = LoginViewController()

        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }

    private func bindInput() {
        drawerViewModel.outputs
            .isLoading
            .asDriver()
            .drive(loadingView)
            .disposed(by: disposeBag)

        drawerViewModel.outputs
            .moveToLogin
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.moveToLogin()
            }).disposed(by: disposeBag)
    }

    private func bindOutput() {
        logoutButton
            .rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.drawerViewModel.logout()
            })
            .disposed(by: disposeBag)
    }
}
