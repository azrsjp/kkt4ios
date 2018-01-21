//
//  AuthModel.swift
//  kkt4ios
//
//  Created by tt on 2018/01/13.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import MastodonKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults
import UIKit
import WebKit

class AuthModel {
    private var oAuthClient: OAuthClient?

    init() {
    }

    func isLoggedIn() -> Bool {
        return Defaults[.accessToken] != nil
    }

    func isResiteredApp() -> Bool {
        return Defaults[.clientId] != nil && Defaults[.clientSecret] != nil
    }

    func logout() {
        // TODO: token自体を無効にしたい
        Defaults[.accessToken] = nil

        // ログイン状態が残ったままOauthのWebViewを出しても即座にtokenが発行されてしまうため，Cookieを消して明示的に再ログインさせる
        let dataTypes = Set([
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeLocalStorage, WKWebsiteDataTypeSessionStorage,
            WKWebsiteDataTypeWebSQLDatabases, WKWebsiteDataTypeIndexedDBDatabases,
        ])
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes, modifiedSince: NSDate.distantPast, completionHandler: {})
    }

    func login(with authWebView: AuthWebViewController) -> Completable {
        // Tokenを取得済み = ログイン済み
        if isLoggedIn(),
            let token = Defaults[.accessToken] {
            MastodonAPIClient.shared.setAccessToken(token)
            return Completable.empty()
        }

        // アプリの登録は済んでいる(ログアウトや途中エラーなどでaccessTokenが無い場合)
        if isResiteredApp(),
            let clientId = Defaults[.clientId],
            let clientSecret = Defaults[.clientSecret] {

            return doOAuth(clientID: clientId,
                           clientSecret: clientSecret,
                           authWebView: authWebView)
                .do(onNext: { token in
                    MastodonAPIClient.shared.setAccessToken(token)
                })
                .asCompletable()
        }

        // 初めてのログイン，または前回ログインシーケンスの序盤で失敗していた場合
        return registerApp()
            .flatMap { [unowned self] in
                self.doOAuth(clientID: $0.clientID,
                             clientSecret: $0.clientSecret,
                             authWebView: authWebView)
            }
            .do(onNext: { token in
                MastodonAPIClient.shared.setAccessToken(token)
            })
            .asCompletable()
    }

    func verifyCredentials() -> Single<Void> {
        return MastodonAPIClient.shared
            .request(Accounts.currentUser())
            .map { _ in }
    }

    // MARK: - private

    private func registerApp() -> Single<ClientApplication> {
        return MastodonAPIClient.shared.registerClient()
            .do(onNext: { [unowned self] app in
                self.storeClientInfo(clientID: app.clientID, clientSecret: app.clientSecret)
            })
    }

    private func doOAuth(clientID: String, clientSecret: String, authWebView: AuthWebViewController) -> Single<String> {
        let client = OAuthClient()
        oAuthClient = client // To work correctly, retain instance

        return client.authorize(clientID: clientID, clientSecret: clientSecret, authWebView: authWebView)
            .do(onNext: { [unowned self] token in
                self.storeAccessToken(accessToken: token)
                MastodonAPIClient.shared.setAccessToken(token)
            })
    }

    private func storeClientInfo(clientID: String, clientSecret: String) {
        Defaults[.clientId] = clientID
        Defaults[.clientSecret] = clientSecret
    }

    private func storeAccessToken(accessToken: String) {
        Defaults[.accessToken] = accessToken
    }
}
