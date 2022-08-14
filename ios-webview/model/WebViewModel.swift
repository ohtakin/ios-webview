//
//  WebViewModel.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/11.
//


import Combine
import WebKit

class WebViewModel: ObservableObject {
    
    var url: String
    var webView: WKWebView
    
    init(url: String = "", webView: WKWebView = WKWebView()) {
        self.url = Bundle.main.object(forInfoDictionaryKey: "hostUrl") as! String
        self.webView = webView
        debugPrint("hostUrl: \(self.url)")
    }
}
