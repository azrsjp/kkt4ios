//
//  KatsuFormViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class KatsuFormViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet var dismissButton: UIButton!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        setupView()
        transitioningDelegate = self

        dismissButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)

        super.viewDidLoad()
    }

    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented _: UIViewController,
                             presenting _: UIViewController,
                             source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentSlideAnimator()
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissSlideAnimator()
    }

    // MARK: - private

    private func setupView() {
        if let image = UIImage(named: "bg_main.png") {
            view.backgroundColor = UIColor(patternImage: image)
        }
    }
}
