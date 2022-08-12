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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        webViewModel.webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webViewModel.webView.navigationDelegate = context.coordinator
        webViewModel.webView.allowsBackForwardNavigationGestures = true
        webViewModel.webView.scrollView.isScrollEnabled = true
        
        if let url = URL(string: self.webViewModel.url) {
            webViewModel.webView.load(URLRequest(url: url))
        }
        return webViewModel.webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        deinit {
            //
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            return decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        }
        
        func webView(_ webview: WKWebView, didFinish: WKNavigation!) {
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) {
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        }
        
        @objc func handleRefresh(sender: UIRefreshControl) {
        }
    }
}
