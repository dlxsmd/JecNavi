//
//  PrivacyPolicyView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/30.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("プライバシーポリシー")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("1. 収集する情報の種類")
                    .fontWeight(.bold)
                Text("当アプリは、次の情報を収集する場合があります：")
                    .padding(.leading, 10)
                
                Text("- ユーザーが提供する登録情報（例：ユーザー名、メールアドレス）")
                    .padding(.leading, 20)
                Text("- デバイス情報（例：デバイスの種類、OSバージョン）")
                    .padding(.leading, 20)
                Text("- 位置情報（オプションで、GPS情報など）")
                    .padding(.leading, 20)
                
                Text("2. 情報の使用目的")
                    .fontWeight(.bold)
                Text("収集した情報は以下の目的で使用される場合があります：")
                    .padding(.leading, 10)
                
                Text("- アプリの機能提供および運営")
                    .padding(.leading, 20)
                Text("- ユーザーサポートの提供")
                    .padding(.leading, 20)
                Text("- サービス向上のための分析")
                    .padding(.leading, 20)
                
                Text("3. 情報の共有")
                    .fontWeight(.bold)
                Text("収集した情報は次の場合に限り、第三者と共有されることがあります：")
                    .padding(.leading, 10)
                
                Text("- ユーザーの同意がある場合")
                    .padding(.leading, 20)
                Text("- 法的義務を果たす必要がある場合")
                    .padding(.leading, 20)
                
                Text("4. セキュリティ対策")
                    .fontWeight(.bold)
                Text("収集した情報の安全管理にはSSL暗号化通信などの適切な技術的手段を用い、データの保護を行います。")
                    .padding(.leading, 10)
                
                Text("5. ユーザーの権利")
                    .fontWeight(.bold)
                Text("ユーザーは収集された個人情報に関して、以下の権利を行使することができます：")
                    .padding(.leading, 10)
                
                Text("- 収集されたデータにアクセスする権利")
                    .padding(.leading, 20)
                Text("- 収集されたデータの修正や削除の権利")
                    .padding(.leading, 20)
                Text("- 収集されたデータの処理停止や移行の権利")
                    .padding(.leading, 20)
            }
            .padding()
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
