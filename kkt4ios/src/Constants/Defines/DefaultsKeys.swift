//
//  DefaultsKeys.swift
//  kkt4ios
//
//  Created by tt on 2018/01/07.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    struct Auth {
        static let clientSecret = DefaultsKey<String?>("clientSecret")
        static let clientId = DefaultsKey<String?>("clientId")
        static let accessToken = DefaultsKey<String?>("accessToken")
    }
}
