//
//  ContentView.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/11.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var webViewModel = WebViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                WebView(webViewModel: self.webViewModel)
                    .ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
