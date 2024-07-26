//
//  Intro3View.swift
//  JecNavi
//
//  Created by yuki on 2024/07/01.
//

import SwiftUI

struct Intro3View: View {
    @Binding var page:Int
    @State private var offset = 0.0
    @AppStorage("isInit") var isInit = true
    var body: some View {
        ZStack{
            Color.yellow
            VStack{
                VStack{
                    Spacer()
                    
                    Image("news")
                        .resizable()
                        .frame(width: 200,height:200)
                        .offset(x: 0, y: offset)
                    VStack(spacing:10){
                        Text("最新ニュース")
                            .font(.title)
                        Text("学校からのニュースを\nいち早くゲット。")
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
                            page = 4
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
    Intro3View(page: .constant(3))
}
