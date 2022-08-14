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
    
    var body: some View {
        VStack {
            ZStack {
                WebView(webViewModel: self.webViewModel, alertViewModel: self.alertViewModel)
                    .ignoresSafeArea()
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
