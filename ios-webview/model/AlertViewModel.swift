//
//  AlertViewModel.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/13.
//

import SwiftUI
//import WebKit

final class AlertViewModel: ObservableObject {
    var title: String
    var message: String
    var primaryButton: Alert.Button
    var secondaryButton: Alert.Button?

    @Published var isPresented = false

    init(title: String = "알림",
         message: String = "",
         primaryButton: Alert.Button = .default(Text("Ok")),
         secondaryButton: Alert.Button? = nil) {
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
}

extension Alert {
    init(viewModel: AlertViewModel) {
        if let secondaryButton = viewModel.secondaryButton {
            debugPrint("confirm")
            self.init(title: Text(viewModel.title),
                      message: Text(viewModel.message),
                      primaryButton: viewModel.primaryButton,
                      secondaryButton: secondaryButton)
        } else {
            debugPrint("alert")
            self.init(title: Text(viewModel.title),
                      message: Text(viewModel.message),
                      dismissButton: viewModel.primaryButton)
        }
    }
}

extension Alert.Button {
    static func `default`(_ label: String, action: (() -> Void)? = nil) -> Alert.Button {
        .default(Text(label), action: action)
    }

    static func destructive(_ label: String, action: (() -> Void)? = nil) -> Alert.Button {
        .destructive(Text(label), action: action)
    }
}
