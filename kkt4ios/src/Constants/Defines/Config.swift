//
//  Define.swift
//  kkt4ios
//
//  Created by tt on 2018/01/07.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation

struct Config {
    
    struct App {
        static let clientName = "Kirakiratter for iOS"
        static let kirakiratterURLBase = "https://kirakiratter.com/"
    }
    
    struct Scheme {
        static let base = "kkt4ios://"
        static let login = base + "login"
    }

    struct Auth {
        static let authorizeURL = App.kirakiratterURLBase + "oauth/authorize"
        static let accessTokenURL = App.kirakiratterURLBase + "oauth/token"
        static let redirectURL = Scheme.login
    }
}
