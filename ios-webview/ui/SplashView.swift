//
//  SplashView.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/29.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var isActive: Bool
    
    var body: some View {
        Text("Splash View")
            .font(.title)
            .fontWeight(.heavy)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isActive = true
                }
            }
    }
}

struct SplashView_Previews: PreviewProvider {
    @State static var isActive: Bool = false
    static var previews: some View {
        SplashView(isActive: $isActive)
    }
}
