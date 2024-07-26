//
//  IntroTabView.swift
//  JecNavi
//
//  Created by yuki on 2024/07/01.
//

import SwiftUI

struct IntroTabView: View {
    @State var page:Int = 1
    @AppStorage("isInit") var isInit = true
    
    init(){
        
    }
    var body: some View {
        if isInit{
            TabView(selection: $page) {
                Intro1View(page:$page).tag(1)
                    
                Intro2View(page:$page).tag(2)
                    
                Intro3View(page:$page).tag(3)
                
                Intro4View(page:$page).tag(4)
                
                Intro5View(page:$page).tag(5)
                
                IntroSigninView(page:$page).tag(6)
                    
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle())
        }else{
            AppMainView()
        }
    }
}

#Preview {
    IntroTabView()
}
