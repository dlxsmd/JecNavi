//
//  AppMainView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/15.
//

import SwiftUI
import StoreKit

struct AppMainView: View {
    @Environment(\.requestReview) var requestReview
    @State var selectedTab = 2
    @AppStorage("launchCount") var launchCount = 0
    @AppStorage("didRequestReview") var didRequestReview = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                    
                    NewsView()
                        .tag(1)
                    
                    MapView()
                        .tag(2)
                    
                    TimeLineView()
                        .tag(3)
                    
                    ChatRoomsView()
                        .tag(4)
                    
                }
                TabBarView(selectedTab: $selectedTab)
            }
        }
        .onAppear(){
            UITabBar.appearance().isHidden = true
            launchCount += 1
            
            if launchCount >= 10 && !didRequestReview{
                requestReview()
                didRequestReview = true
            }
        }
    }
}
#Preview {
    AppMainView()
}
