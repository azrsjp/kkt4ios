//
//  RxSwift+asCompletable.swift
//  kkt4ios
//
//  Created by tt on 2018/01/14.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    func asCompletable() -> Completable {
        return ignoreElements()
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    func asCompletable() -> Completable {
        return asObservable().asCompletable()
    }
}

extension PrimitiveSequence where Trait == MaybeTrait {
    func asCompletable() -> Completable {
        return asObservable().asCompletable()
    }
}
