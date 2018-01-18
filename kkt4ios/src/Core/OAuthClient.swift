//
//  OAuthClient.swift
//  kkt4ios
//
//  Created by tt on 2018/01/09.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift

final class OAuthClient {

    private var oAuthClient: OAuth2Swift?

    init() {
    }

    func authorize(clientID: String, clientSecret: String, from: UIViewController) -> Single<String> {
        createClient(clientID, clientSecret, from)

        return Single<String>.create { [weak self] observer in
            guard let self_ = self else {
                return Disposables.create()
            }

            _ = self_.oAuthClient?.authorize(
                withCallbackURL: URL(string: Config.Auth.redirectURL)!,
                scope: "read write follow",
                state: "",
                success: { credential, response, parameters in
                    dump(credential)
                    dump(response)
                    dump(parameters)
                    observer(.success(credential.oauthToken))
                }, failure: { error in
                    observer(.error(error))
            })

            return Disposables.create()
        }
    }

    private func createClient(_ clientID: String, _ clientSecret: String, _ from: UIViewController) {
        guard oAuthClient == nil else {
            return
        }

        let client = OAuth2Swift(
            consumerKey: clientID,
            consumerSecret: clientSecret,
            authorizeUrl: Config.Auth.authorizeURL,
            accessTokenUrl: Config.Auth.accessTokenURL,
            responseType: "code"
        )
        oAuthClient?.cancel()

        client.authorizeURLHandler = SafariURLHandler(viewController: from, oauthSwift: client)
        client.allowMissingStateCheck = true
        oAuthClient = client
    }
}
