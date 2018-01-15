//
//  LoginViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/10.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults
import MastodonKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var registerDisposable: Disposable?
    private var oAuthClient: OAuthClient?
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        self.bindData()
        
        self.bindUIEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.loginViewModel.viewWillDisapper()
    }
    
    // MARK: - private
    
    private func setupView() {
        if let image = UIImage(asset: Asset.bgMain) {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    private func bindData() {
        self.loginViewModel.outputs
            .isLoading
            .asDriver()
            .drive(self.loadingView)
            .disposed(by: self.disposeBag)
    }
    
    private func bindUIEvents() {
        self.loginButton
            .rx.tap
            .asDriver()
            .drive(onNext: {[unowned self] in
                self.loginViewModel.login(from: self)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func moveToHomeVC() {
        let homeVC = HomeViewController.withDrawer()

        UIApplication.shared.keyWindow?.rootViewController = homeVC
    }
}
