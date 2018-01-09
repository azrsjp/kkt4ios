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
    
    func authorize(clientID: String, clientSecret: String) -> Single<String> {
        self.createClient(clientID, clientSecret)

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
    
    private func createClient(_ clientID: String, _ clientSecret: String) {
        guard self.oAuthClient == nil else {
            return
        }

        self.oAuthClient = OAuth2Swift(
            consumerKey: clientID,
            consumerSecret: clientSecret,
            authorizeUrl: Config.Auth.authorizeURL,
            accessTokenUrl: Config.Auth.accessTokenURL,
            responseType: "code"
        )
        self.oAuthClient?.allowMissingStateCheck = true
    }
}
