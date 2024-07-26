//
//  MapListRowView.swift
//  JecNavi
//
//  Created by yuki on 2024/07/17.
//

import SwiftUI

struct MapListRowView: View {
    let locationData:LocationDataModel
    @Environment(\.dismiss) var dm
    @ObservedObject private var locationModel = LocationModel.shared
    var body: some View {
        VStack(spacing:0){
            TabView{
                ForEach(locationData.images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 60, height: 150)
                        .scaledToFit()
                        .background(Image(image).resizable().scaledToFill().blur(radius: 30))
                        .cornerRadius(30)
                }
                
            }.tabViewStyle(PageTabViewStyle())
                .frame(height: 150)
                .padding()

            HStack{
                VStack(alignment:.leading){
                    Text(locationData.name)
                        .font(.title3)
                    Text(locationData.address)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }.frame(height: 50)
                Spacer()
                Button(action: {
                    locationModel.startFetchingRoute(to: locationData.coordinate)
                    dm()
                }, label: {
                    Image(systemName: "chevron.forward.circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                })
            }.padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width - 60)
        }
        .padding(.bottom)
        .frame(width: UIScreen.main.bounds.width - 30)
            .background(Color.white)
            .cornerRadius(30)
    }
}

#Preview {
    MapListRowView(locationData: LocationDataModel(id: 0, name: "東京タワー", latitude: 35.6585805, longitude: 139.7454329, address:"東京都中央区１丁目",classes: [""],facilities: ["fac"], images: ["6", "sample", "sample"]))
}
