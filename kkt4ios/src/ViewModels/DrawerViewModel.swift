//
//  DrawerViewModel.swift
//  kkt4ios
//
//  Created by tt on 2018/01/19.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol DrawerViewModelInputs {
    func logout()
    func viewWillDisapper()
}

protocol DrawerViewModelOutputs {
    var isLoading: BehaviorRelay<Bool> { get }
    var moveToLogin: PublishSubject<Void> { get }
}

protocol DrawerViewModelType {
    var inputs: DrawerViewModelInputs { get }
    var outputs: DrawerViewModelOutputs { get }
}

class DrawerViewModel: DrawerViewModelType, DrawerViewModelInputs, DrawerViewModelOutputs {

    var inputs: DrawerViewModelInputs { return self }
    var outputs: DrawerViewModelOutputs { return self }

    private let authModel = AuthModel()
    private let disposeBag = DisposeBag()

    init() {
    }

    // MARK: - outputs

    var isLoading = BehaviorRelay<Bool>(value: false)

    var moveToLogin = PublishSubject<Void>()

    // MARK: - inputs

    func viewWillDisapper() {
        isLoading.accept(false)
    }

    func logout() {
        isLoading.accept(true)

        authModel.logout()

        // ログアウトしてる感を出すためになんとなくローディングを見せる
        // 最終的にtokenを潰せる方法を見つけたら差し替える
        Completable.empty()
            .delaySubscription(RxTimeInterval(1), scheduler: MainScheduler.instance)
            .subscribe(onCompleted: { [unowned self] in
                self.isLoading.accept(false)
                self.moveToLogin.onNext(())
            }).disposed(by: disposeBag)
    }
}
