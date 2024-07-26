//
//  LoginView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/17.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseGoogleAuthUI

struct SignInView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()!
        // ログイン方法を選択
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI)
        ]
        authUI.providers = providers
        
        // FirebaseUIを表示する
        let authViewController = authUI.authViewController()
        
        return authViewController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // 処理なし
    }
}


#Preview {
    SignInView()
}
