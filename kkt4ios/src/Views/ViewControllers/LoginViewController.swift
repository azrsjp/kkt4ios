//
//  LoginViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/10.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import MastodonKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!

    private let disposeBag = DisposeBag()
    private var registerDisposable: Disposable?
    private var oAuthClient: OAuthClient?
    private let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        bindData()

        bindUIEvents()
    }

    override func viewWillDisappear(_: Bool) {
        loginViewModel.viewWillDisapper()
    }

    // MARK: - private

    private func setupView() {
        if let image = UIImage(asset: Asset.bgMain) {
            view.backgroundColor = UIColor(patternImage: image)
        }
    }

    private func bindData() {
        loginViewModel.outputs
            .isLoading
            .asDriver()
            .drive(loadingView)
            .disposed(by: disposeBag)
    }

    private func bindUIEvents() {
        loginButton
            .rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.loginViewModel.login(from: self)
            })
            .disposed(by: disposeBag)
    }

    private func moveToHomeVC() {
        let homeVC = HomeViewController.withDrawer()

        UIApplication.shared.keyWindow?.rootViewController = homeVC
    }
}
