//
//  FunctionRequestView.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/23.
//

import SwiftUI

struct FunctionRequestView: View {
    @State var requestContent = ""
    var body: some View {
        
        VStack(alignment:.center){
            Text("機能リクエスト")
                .font(.title)
                .fontWeight(.bold)
            Text("このアプリに追加してほしい機能や改善してほしい点があれば、お知らせください。")
        }.padding()
        
        VStack(alignment: .leading){
            Text("機能リクエスト内容")
                .font(.subheadline)
            TextField("例：タイムラインに画像投稿機能を追加してほしい", text: $requestContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }.padding()
        
        Button(action: {
            //機能リクエスト送信処理
        }) {
            Text("送信")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
            .cornerRadius(10)}
    }
}

#Preview {
    FunctionRequestView()
}
