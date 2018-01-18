//
//  LoginViewModel.swift
//  kkt4ios
//
//  Created by tt on 2018/01/13.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol LoginViewModelInputs {
    func login(from: UIViewController)
    func viewWillDisapper()
}

protocol LoginViewModelOutputs {
    var isLoading: BehaviorRelay<Bool> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {

    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }

    private let authModel = AuthModel()
    private let disposeBag = DisposeBag()

    init() {
    }

    // MARK: - outputs

    var isLoading = BehaviorRelay<Bool>(value: false)

    var moveToHome = PublishSubject<Void>()

    // MARK: - inputs

    func viewWillDisapper() {
        isLoading.accept(false)
    }

    func login(from: UIViewController) {
        isLoading.accept(true)

        // delaySubscriptionを使う理由
        // ローディングが一瞬で終わるパターンがあり，不自然な画面のチラツキが発生するため，良い感じに多少遅延させる
        authModel
            .login(fromVC: from)
            .delaySubscription(RxTimeInterval(0.3), scheduler: MainScheduler.instance)
            .subscribe(onCompleted: { [unowned self] in
                self.isLoading.accept(false)
                self.moveToHome.onNext(())
            }, onError: { [unowned self] error in
                self.isLoading.accept(false)
                print(error)
            }).disposed(by: disposeBag)
    }
}
