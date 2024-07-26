//
//  Intro4View.swift
//  JecNavi
//
//  Created by yuki on 2024/07/03.
//

import SwiftUI

struct Intro4View: View {
    @Binding var page:Int
    @State private var offset = 0.0
    @AppStorage("isInit") var isInit = true
    var body: some View {
        ZStack{
            Color.mint
            VStack{
                VStack{
                    
                    Spacer()
                    
                    Image("timeline")
                        .resizable()
                        .frame(width: 200,height:200)
                        .offset(x: 0, y: offset)
                    VStack(spacing:10){
                        Text("日電タイムライン")
                            .font(.title)
                        Text("他学科の学生と\n匿名で交流できる。")
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
                            page = 5
                        }
                    }
                }.foregroundColor(.white)
                    .padding(40)
            }
        }
        .ignoresSafeArea()
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
    Intro4View(page: .constant(4))
}
