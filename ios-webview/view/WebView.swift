//
//  WebView.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/11.
//

import UIKit
import SwiftUI
import Combine
import WebKit

struct WebView: UIViewRepresentable {
    
    @ObservedObject var webViewModel: WebViewModel
    @ObservedObject var alertViewModel: AlertViewModel
    
    // MARK: - WebView
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        self.webViewModel.webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        self.webViewModel.webView.uiDelegate = context.coordinator
        self.webViewModel.webView.navigationDelegate = context.coordinator
        self.webViewModel.webView.allowsBackForwardNavigationGestures = true
        self.webViewModel.webView.scrollView.isScrollEnabled = true
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: UIControl.Event.valueChanged)
        self.webViewModel.webView.scrollView.addSubview(refreshControl)
        self.webViewModel.webView.scrollView.bounces = true
        
        if let url = URL(string: self.webViewModel.url) {
            self.webViewModel.webView.load(URLRequest(url: url))
        }
        return self.webViewModel.webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    class Coordinator : NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView
        var refreshcontrol: UIRefreshControl?
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        deinit {
            //
        }
        
        // MARK: - WKNavigationDelegate
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            return decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        }
        
        func webView(_ webview: WKWebView, didFinish: WKNavigation!) {
            self.refreshcontrol?.endRefreshing()
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) {
            self.refreshcontrol?.endRefreshing()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.refreshcontrol?.endRefreshing()
        }
        
        // MARK: - WKUIDelegate
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            self.parent.alertViewModel.message = message
            self.parent.alertViewModel.primaryButton = .default("OK") {
                completionHandler()
            }
            self.parent.alertViewModel.isPresented = true
            self.parent.alertViewModel.secondaryButton = nil
        }
        
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            debugPrint("alert \(message)")
            self.parent.alertViewModel.message = message
            self.parent.alertViewModel.primaryButton = .default("OK") {
                completionHandler(true)
            }
            self.parent.alertViewModel.secondaryButton = .cancel() {
                completionHandler(false)
            }
            self.parent.alertViewModel.isPresented = true
        }
        
        @objc func handleRefresh(refreshcontrol: UIRefreshControl) {
            self.parent.webViewModel.webView.reload()
            self.refreshcontrol = refreshcontrol
        }
    }
}
