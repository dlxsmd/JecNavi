//
//  PopUpView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/13.
//

import SwiftUI
import MapKit

struct PopUpView: View {
    let locationData: LocationDataModel
    @ObservedObject private var locationModel = LocationModel.shared
    @Binding var isShowPopUp: Bool
    
    private var travelTime: String {
        guard let route = locationModel.route else { return "" }
        let time = route.expectedTravelTime
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
//        formatter.includesApproximationPhrase = true
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: time) ?? ""
    }
    

    var body: some View {
        ZStack(alignment:.bottomTrailing){
                HStack(spacing:0){
                    // PopUpViewを非表示にする
                    TabView{
                        ForEach(locationData.images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .background(Image(image).resizable().aspectRatio(contentMode: .fill).blur(radius: 30))
                        }.frame(width: 150, height: 150)
                            .cornerRadius(30)
                    }.tabViewStyle(PageTabViewStyle())
                        .frame(width: 150, height: 150)
                        .padding()

                    VStack(alignment:.leading){
                        Text(locationData.name)
                            .font(.title3)
                        Text(locationData.address)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(travelTime)
                            .font(.title).bold()
                            .foregroundColor(.black)
                    }.frame(height: 130)
                    Spacer()
                }
            
            Button(action: {
                locationModel.startFetchingRoute(to: locationData.coordinate)
                isShowPopUp = false
            }, label: {
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 40, height: 40)
                    .padding()
            })
        }.frame(width: UIScreen.main.bounds.width - 40, height: 200)
    }
}

#Preview {
    PopUpView(locationData: LocationDataModel(id: 0, name: "本館", latitude: 35.6585805, longitude: 139.7454329, address:"東京都中央区１丁目",classes: [""],facilities: ["fac"], images: ["6", "1", "1"]), isShowPopUp: .constant(true))
}
