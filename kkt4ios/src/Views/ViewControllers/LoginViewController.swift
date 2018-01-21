//
//  LoginViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/10.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import MastodonKit
import OAuthSwift
import RxCocoa
import RxSwift
import SwiftyUserDefaults
import UIKit

class LoginViewController: UIViewController, AuthWebViewControllerDelegate {

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

    // MARK: - AuthWebViewControllerDelegate

    func authViewControllerWillDisappear(_: AuthWebViewController, isCanceled: Bool) {
        if !isCanceled {
            showLoadingView()
        }
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

        loginViewModel.outputs
            .moveToHome
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.moveToHomeVC()
            }).disposed(by: disposeBag)
    }

    private func bindUIEvents() {
        loginButton
            .rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.launchAuthWebView()
            })
            .disposed(by: disposeBag)
    }

    private func moveToHomeVC() {
        let homeVC = HomeViewController.withDrawer()

        UIApplication.shared.keyWindow?.rootViewController = homeVC
    }
    
    private func launchAuthWebView() {
        let authWebViewVC = AuthWebViewController()
        authWebViewVC.authWebVCDelegate = self
        
        self.loginViewModel.login(with: authWebViewVC)
    }
}
