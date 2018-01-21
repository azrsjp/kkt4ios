//
//  AuthViewControllerDelegate.swift
//  kkt4ios
//
//  Created by tt on 2018/01/21.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import OAuthSwift
import RxCocoa
import RxSwift
import UIKit
import WebKit

// AuthWebViewVCが閉じてもとのVCに戻って来た時に，Cancelによるものなのか，認証成功あるいは失敗によるものなのかを知らせる
// Cancel(ユーザによるUI操作)と成功失敗(WebView内の通信結果)は異なるソースから起こるイベントなので，統合することで，ローディングViewの制御などがうまく行く
protocol AuthWebViewControllerDelegate: class {
    func authViewControllerWillDisappear(_ viewController: AuthWebViewController, isCanceled: Bool)
}

// Oauthに利用するWebViewを表示するためのViewController
// WebView内の通信状態や遷移をフックすることでOAuthSwiftを利用して進行途中のAuthの成功あるいは失敗イベントが進む
final class AuthWebViewController: OAuthWebViewController {

    weak var authWebVCDelegate: AuthWebViewControllerDelegate?
    private var isAuthCanceled = false

    private let disposeBag = DisposeBag()
    
    private var observeEstimatedProgress: NSKeyValueObservation?
    private var observeLoading: NSKeyValueObservation?

    private let headerView = UIView()
    private let progressBar = UIProgressView()
    private let titleLabel = UILabel()
    private let cancelButton = UIButton()
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = self

        setupView()
        bindUIEvents()
        observeKeysFowWebView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        authWebVCDelegate?.authViewControllerWillDisappear(self, isCanceled: isAuthCanceled)

        super.viewWillDisappear(animated)
    }

    override func handle(_ url: URL) {
        super.handle(url)

        let req = URLRequest(url: url)
        webView.load(req)
    }

    // MARK: - private

    private func setupView() {
        let bounds = UIScreen.main.bounds

        view = UIView(frame: bounds)

        let headerHeight: CGFloat = 48.0
        let barHeight = Utility.statusBarHeight()
        let headerHeightWithBar = headerHeight + barHeight

        headerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: headerHeightWithBar)
        if let image = UIImage(asset: Asset.bgHeader) {
            headerView.backgroundColor = UIColor(patternImage: image)
        }
        view.addSubview(headerView)

        let progressBarHeight: CGFloat = 2
        progressBar.frame = CGRect(x: 0, y: headerHeight + barHeight - progressBarHeight,
                                   width: bounds.width, height: progressBarHeight)
        view.addSubview(progressBar)

        titleLabel.frame = CGRect(x: 0, y: barHeight, width: bounds.width, height: headerHeight)
        titleLabel.text = "アカウントにログイン"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)

        cancelButton.setTitle("もどる", for: .normal)
        cancelButton.contentHorizontalAlignment = .left
        cancelButton.setTitleColor(UIColor.blue, for: .normal)
        cancelButton.frame = CGRect(x: 10, y: barHeight, width: 100, height: headerHeight)
        view.addSubview(cancelButton)

        var webViewBounds = UIScreen.main.bounds
        webViewBounds.origin.y = headerView.frame.height
        webViewBounds.size.height = webViewBounds.size.height - headerView.frame.height

        webView.frame = webViewBounds
        webView.navigationDelegate = self
        view.addSubview(webView)
    }

    private func bindUIEvents() {
        cancelButton
            .rx.tap
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.isAuthCanceled = true
                self.dismissWebViewController()
            })
            .disposed(by: disposeBag)
    }

    private func observeKeysFowWebView() {
        observeEstimatedProgress
            = webView.observe(\.estimatedProgress, options: [.new], changeHandler: { [unowned self] webView, _ in
                self.progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
            })

        observeLoading
            = webView.observe(\.loading, options: [.new], changeHandler: { [unowned self] webView, _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = webView.isLoading

                if webView.isLoading {
                    self.progressBar.setProgress(0.1, animated: true)
                } else {
                    self.progressBar.setProgress(0.0, animated: false)
                }
            })
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AuthWebViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented _: UIViewController,
                             presenting _: UIViewController,
                             source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentSlideAnimator()
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissSlideAnimator()
    }
}

// MARK: - WKNavigationDelegate

extension AuthWebViewController: WKNavigationDelegate {

    func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        // リンクがコールバックURLの時には遷移をキャンセルしてOAuthSwiftにハンドルしてもらい，このViewController自体を閉じる
        if let url = navigationAction.request.url, url.host == Config.Scheme.login {
            OAuthSwift.handle(url: url)
            decisionHandler(.cancel)
            dismissWebViewController()

            return
        }

        decisionHandler(.allow)
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError error: Error) {
        dismissWebViewController()
    }
}
