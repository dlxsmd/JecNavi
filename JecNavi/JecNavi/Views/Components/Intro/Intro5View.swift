//
//  Intro5Vie.swift
//  JecNavi
//
//  Created by yuki on 2024/07/01.
//

import SwiftUI

struct Intro5View: View {
    @Binding var page:Int
    @State private var offset = 0.0
    @AppStorage("isInit") var isInit = true
    var body: some View {
        ZStack{
            Color.blue
            VStack{
                VStack{
                    Spacer()
                    
                    Image("chat")
                        .resizable()
                        .frame(width: 200,height:200)
                        .offset(x: 0, y: offset)
                    VStack(spacing:10){
                        Text("日電生専用チャット")
                            .font(.title)
                        Text("友達との連絡まで\n公式アプリで完結。")
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
                            page = 6
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
    Intro5View(page:.constant(5))
}
