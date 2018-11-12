////
////  LoginViewController.swift
////  GitHub-iOS
////
////  Created by Anna Cherkes on 11/11/18.
////  Copyright © 2018 Anna Cherkes. All rights reserved.
////

import UIKit
import WebKit
import ANLoader

protocol LoginViewControllerProtocol: class {
    func startLoading()
    func stopLoading()
    func dismiss()
}

class LoginViewController: UIViewController, LoginViewControllerProtocol, WKNavigationDelegate {
    
    var presenter: LoginPresenterProtocol!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSettingForWebView()
    }
    
    public func startLoading() {
        ANLoader.showLoading()
    }
    
    public func stopLoading() {
        ANLoader.hide()
    }
    
    private func defaultSettingForWebView() {
        webView.navigationDelegate = self
        guard let url = presenter!.getLoginURL() else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        if presenter.checkURL(url: navigationAction.request.url) {
            guard let code =  navigationAction.request.url?.query?.components(separatedBy: "code=").last else { return }
            if presenter.checkCode(code: code) {
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    public func dismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

