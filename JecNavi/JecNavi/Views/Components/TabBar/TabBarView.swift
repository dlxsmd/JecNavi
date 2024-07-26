//
//  TabBarView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/18.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab:Int
    var body: some View {
        ZStack{
            TabBarShape(insetRadius: 32.5)
                .frame(width: 360, height: 70)
                .foregroundColor(.white)
                .shadow(color: Color(white: 0.8), radius: 6, x: 0, y: 3)
            
            Button {
                selectedTab = 2
            } label: {
                CustomTabItem(imageName: "map", isActive: (selectedTab == 2))
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 0.8)
            .offset(y: -50)
            
            HStack {
                ForEach(TabbarItem.allCases, id: \.self) { item in
                    if item != .map { // Exclude the center button
                        Button {
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
            }
            .frame(height: 70)
        }
    }
}

#Preview {
    TabBarView(selectedTab: .constant(2))
}
