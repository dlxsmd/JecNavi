//
//  MapDetailPhotoView.swift
//  JecNavi
//
//  Created by yuki on 2024/07/18.
//

import SwiftUI
import Zoomable

struct MapDetailPhotoView: View {
    let Imagename: String
    @Environment(\.dismiss) var dm
    var body: some View {
        ZStack(alignment:.bottomLeading){
            Color.black.opacity(0.7).ignoresSafeArea()
            
            VStack{
                Spacer()
                Image(Imagename)
                    .resizable()
                    .scaledToFit()
                    .zoomable()
                    .onAppear(){
                        print("photo loaded")
                    }
                Spacer()
            }
     
            Button(action: {
                dm()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white,Color(.systemGray2))
            }).padding()
        }
    }
}

#Preview {
    MapDetailPhotoView(Imagename: "2号館")
}
