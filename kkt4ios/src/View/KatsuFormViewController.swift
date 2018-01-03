//
//  KatsuFormViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class KatsuFormViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var dismissButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.setupView()
        self.transitioningDelegate = self
        
        self.dismissButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
        
        super.viewDidLoad()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentSlideAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissSlideAnimator()
    }
    
    // MARK: - private
    
    private func setupView() {
        if let image = UIImage(named: "bg_main.png") {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
    }
}
