//
//  LoginViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/10.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import KYDrawerController

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.loginButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.moveToHomeVC()
        }).disposed(by: self.disposeBag)
    }

    // MARK: - private
    
    private func onTapKatsu() {
        let katsuFormVC: UIViewController = KatsuFormViewController()
        
        self.present(katsuFormVC, animated: true, completion: nil)
    }
    
    private func setupView() {
        if let image = UIImage(asset: Asset.bgMain) {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    private func moveToHomeVC() {
        let mainViewController   = HomeViewController()
        let drawerViewController = DrawerViewController()
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = mainViewController
        drawerController.drawerViewController = drawerViewController
        
        UIApplication.shared.keyWindow?.rootViewController = drawerController
    }
}
