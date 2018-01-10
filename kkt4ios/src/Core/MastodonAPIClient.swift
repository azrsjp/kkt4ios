//
//  MastodonAPIClient.swift
//  kkt4ios
//
//  Created by tt on 2018/01/09.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import MastodonKit
import RxSwift

final class MastodonAPIClient {
    static let shared = MastodonAPIClient()
    private let client = Client(baseURL: Config.App.kirakiratterURLBase)

    private init() {
    }
    
    func setAccessToken(_ accessToken: String?) {
        self.client.accessToken = accessToken
    }

    func registerClient() -> Single<ClientApplication> {
        let request = Clients.register(
            clientName: Config.App.clientName,
            redirectURI: Config.Auth.redirectURL,
            scopes: [.read, .write, .follow],
            website: ""
        )

        return self.request(request)
    }

    func request<Model>(_ request: Request<Model>) -> Single<Model> {
        return Single<Model>.create { [weak self] observer in
            guard let self_ = self else {
                return Disposables.create()
            }

            self_.client.run(request) {(response, error) in
                guard let response = response else {
                    observer(.error(error ?? ClientError.dataError))
                    return
                }
                observer(.success(response))
            }

            return Disposables.create()
        }
    }
}
