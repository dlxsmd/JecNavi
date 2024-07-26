//
//  TimeLineTip.swift
//  JecNavi
//
//  Created by yuki on 2024/06/30.
//

import SwiftUI

struct TimeLineTerms: View {
    var body: some View{
        VStack(alignment:.center){
            Text("日電タイムライン")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("その日あった面白かったことなどを匿名で共有しよう！")
                .font(.title2)
        }.padding()

        VStack(alignment:.leading, spacing: 10){
            Text("-このアプリのユーザーの投稿を見ることができます。")
            Text("-投稿は１２時間に１回行えます。")
            Text("-投稿は10文字以上200文字以内の制限があります。")
            Text("-クラブや同好会の宣伝は大歓迎です。")
            Text("-このタイムラインへの投稿は匿名で行えます。")
            Text("-タイムラインへのリンクの共有、個人の特定が可能な情報の投稿は禁止です。")
            Text("-投稿は自由に行えますが、不適切な内容は削除される場合があります。")
            Text("-タイムラインへの不適切な書き込み、荒らし行為等はアプリの利用を禁止される場合があります。")
            //機能リクエストもお待ちしておりますの文言に入れる
        }.padding()
    }
}
