//
//  BaseViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/13.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import KRProgressHUD

extension UIViewController {
    
    func showLoadingView() {
        KRProgressHUD.show()
    }
    
    func hideLoadingView() {
        KRProgressHUD.dismiss()
    }
    
    var loadingView: Binder<Bool> {
        return Binder(self) {(vc, value: Bool) in
            value ? vc.showLoadingView() : vc.hideLoadingView()
        }
    }
}
