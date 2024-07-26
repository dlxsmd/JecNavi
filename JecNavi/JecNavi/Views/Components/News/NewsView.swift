//
//  NewsView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/13.
//

import SwiftUI

struct NewsView: View {
    @State var selectedTab = 0

    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                HeaderView()
                NewsTab(selectedTab: $selectedTab)
                TabView(selection: $selectedTab){
                    NewsListView()
                        .tag(0)
                    ImportantListView()
                        .tag(1)
                }.tabViewStyle(PageTabViewStyle())
            }
        }
    }
}

#Preview {
    NewsView()
}
