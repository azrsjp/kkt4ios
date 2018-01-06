//
//  Reusable.swift
//  kkt4ios
//
//  Created by tt on 2018/01/04.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
