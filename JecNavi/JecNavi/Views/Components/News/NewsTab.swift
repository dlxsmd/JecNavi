//
//  NewsTab.swift
//  JecNavi
//
//  Created by yuki on 2024/06/23.
//

import SwiftUI

struct NewsTab: View {
    let tabs = [NSLocalizedString("News", comment: ""), NSLocalizedString("Important", comment: "")]
    @Binding var selectedTab: Int
    var body: some View {
        HStack(spacing: 0) {
                    ForEach(0 ..< tabs.count, id: \.self) { row in
                        Button(action: {
                            withAnimation {
                                selectedTab = row
                            }
                        }, label: {
                            VStack(spacing: 0) {
                                HStack {
                                    Text(tabs[row])
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.primary)
                                }
                                .frame(
                                    width: (UIScreen.main.bounds.width / CGFloat(tabs.count)),
                                    height: 48 - 3
                                )
                                Rectangle()
                                    .fill(selectedTab == row ? Color.green : Color.clear)
                                    .frame(height: 3)
                            }
                            .fixedSize()
                        })
                    }
                }
                .frame(height: 48)
    }
}

#Preview {
    NewsTab(selectedTab: .constant(0))
}

