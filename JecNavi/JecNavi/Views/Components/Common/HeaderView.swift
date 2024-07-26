//
//  HeaderView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack{
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.65)
                .position(x:UIScreen.main.bounds.maxX/2,y:25)
            NavigationLink {
                SettingView()
            } label: {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding()
                    .foregroundColor(.green)
            }
        }.frame(width: UIScreen.main.bounds.maxX, height: 50)
    }
}

#Preview {
    HeaderView()
}
