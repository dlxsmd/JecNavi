//
//  PhotoZoomView.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/30.
//

import Foundation
import SwiftUI
import Zoomable

struct PhotoZoomView :View {
    @Environment(\.dismiss) var dm
    let images: [UIImage]
    var body: some View {
        ZStack(alignment:.bottomTrailing){
            
            TabView{
                ForEach(images, id: \.self){ image in
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(Color.black)
                        .zoomable()
                }
            }.tabViewStyle(PageTabViewStyle())
            
            Button(action: {
                dm()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white,Color(.systemGray2))
            }).padding()
        }.edgesIgnoringSafeArea(.all)
    }
}
