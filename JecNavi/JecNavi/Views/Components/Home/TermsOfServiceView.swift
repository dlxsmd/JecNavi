//
//  TermsOfServiceView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/30.
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("利用規約")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("1. サービスの提供")
                    .fontWeight(.bold)
                Text("本アプリは、以下のサービスを提供します：")
                    .padding(.leading, 10)
                
                Text("- チャット機能：ユーザー同士のメッセージの送受信")
                    .padding(.leading, 20)
                Text("- 匿名タイムライン：ユーザーが匿名で投稿できるタイムライン機能")
                    .padding(.leading, 20)
                Text("- 地図表示機能：特定の場所やイベントの地図表示")
                    .padding(.leading, 20)
                Text("- 公式ニュースの閲覧：学校からの公式情報やニュースの閲覧")
                    .padding(.leading, 20)
                Text("- リンク集の提供：関連するウェブページへのリンク集の提供")
                    .padding(.leading, 20)
                
                Text("2. 利用条件")
                    .fontWeight(.bold)
                Text("ユーザーは次の行動を禁止します：")
                    .padding(.leading, 10)
                
                Text("- 不正なアクセスや情報の改ざん")
                    .padding(.leading, 20)
                Text("- 他者のプライバシーを侵害する行為")
                    .padding(.leading, 20)
                Text("- 法的規制に違反する行為")
                    .padding(.leading, 20)
                
                Text("3. 免責事項")
                    .fontWeight(.bold)
                Text("アプリ提供者は、以下の事項について責任を負いません：")
                    .padding(.leading, 10)
                
                Text("- ユーザーが他者によるデータの送信や受信によって被った損害")
                    .padding(.leading, 20)
                Text("- サービスの中断や停止による損害")
                    .padding(.leading, 20)
                
                Text("4. 契約解除")
                    .fontWeight(.bold)
                Text("ユーザーが利用規約に違反した場合、アプリ提供者はアカウントの制限や契約の解除を行う権利を有します。")
                    .padding(.leading, 10)
                
                Text("5. 法的規定")
                    .fontWeight(.bold)
                Text("本利用規約は、日本国内の法律に準拠し、訴訟管轄は東京地方裁判所とします。")
                    .padding(.leading, 10)
            }
            .padding()
        }
    }
}

#Preview {
    TermsOfServiceView()
}
