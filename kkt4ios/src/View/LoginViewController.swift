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
import KRProgressHUD
import SwiftyUserDefaults

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var registerDisposable: Disposable?
    private var oAuthClient: OAuthClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()

        self.loginButton
            .rx.tap
            .subscribe (onNext: {[unowned self] in self.login() })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - private

    private func login() {
        KRProgressHUD.show()

        self.registerDisposable?.dispose()

        self.registerDisposable
            = MastodonAPIClient.shared.registerClient()
            .do (onNext: {[unowned self] app in
                self.recordClientInfo(clientID: app.clientID, clientSecret: app.clientSecret)
            })
            .flatMap { [unowned self] app in
                KRProgressHUD.dismiss()
                return self.authorize(clientID: app.clientID, clientSecret: app.clientSecret)
            }
            .do (onNext: {[unowned self] token in
                self.recordAccessToken(accessToken: token)
            })
            .subscribe(onSuccess: {[unowned self] token in
                KRProgressHUD.dismiss()
                MastodonAPIClient.shared.setAccessToken(token)

                self.moveToHomeVC()
            }, onError: { _  in
                KRProgressHUD.dismiss()
            })

        self.registerDisposable?.disposed(by: self.disposeBag)
    }
    
    private func authorize(clientID: String, clientSecret: String) -> Single<String> {
        let client = OAuthClient()
        self.oAuthClient = client // To work correctly, retain instance

        return client.authorize(clientID: clientID, clientSecret: clientSecret, from: self)
    }
    
    private func recordClientInfo(clientID: String, clientSecret: String) {
        Defaults[.clientId] = clientID
        Defaults[.clientSecret] = clientSecret
    }
    
    private func recordAccessToken(accessToken: String) {
        Defaults[.accessToken] = accessToken
    }
    
    private func setupView() {
        if let image = UIImage(asset: Asset.bgMain) {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    private func moveToHomeVC() {
        let homeVC = HomeViewController.withDrawer()

        UIApplication.shared.keyWindow?.rootViewController = homeVC
    }
}
