//
//  Intro1View.swift
//  JecNavi
//
//  Created by yuki on 2024/07/01.
//

import SwiftUI

struct Intro1View: View {
    @Binding var page:Int
    @State private var offset = 0.0
    @AppStorage("isInit") var isInit = true
    var body: some View {
        ZStack{
            Color.green
            VStack{
                VStack{
                    Spacer()
                    
                    Image("qrBackground")
                        .resizable()
                        .frame(width: 100,height:100)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .offset(x: 0, y: offset)
                    VStack(spacing:10){
                        Text("日本電子専門学校\n公式アプリ")
                            .font(.title)
                            .multilineTextAlignment(.center)
                        Text("学生による、\n学生のためのアプリ。")
                    }.foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                HStack{
                    Button("SKIP"){
                        withAnimation {
                            page = 6
                        }
                    }
                    Spacer()
                    Button("NEXT"){
                        withAnimation {
                            page = 2
                        }
                    }
                }.foregroundColor(.white)
                    .padding(40)
            }
        }.ignoresSafeArea()
            .onAppear(){
                withAnimation(.easeInOut(duration: 1.0)){
                    offset = -30.0
                }
            }
            .onDisappear(){
                offset = 0.0
            }
    }
}

#Preview {
    Intro1View(page:.constant(1))
}
