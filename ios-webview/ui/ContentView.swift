//
//  ContentView.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/11.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var webViewModel = WebViewModel()
    @ObservedObject private var alertViewModel = AlertViewModel()
    
    @State private var isActive: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                if self.isActive {
                    WebView(webViewModel: self.webViewModel, alertViewModel: self.alertViewModel)
                        .ignoresSafeArea()
                } else {
                    SplashView(isActive: $isActive)
                }
            }
        }.alert(isPresented: $alertViewModel.isPresented) {
            Alert(viewModel: self.alertViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
