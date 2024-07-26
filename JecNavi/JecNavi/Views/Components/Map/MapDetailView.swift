//
//  MapDetailView.swift
//  JecNavi
//
//  Created by yuki on 2024/07/16.
//

import SwiftUI
import Zoomable

struct MapDetailView: View {
    let locationData: LocationDataModel
    @ObservedObject private var locationModel = LocationModel.shared
    @Environment(\.dismiss) var dm
    @State var selectedPhoto: String = ""
    @State var isfullPhoto = false
    @State private var refresh: Bool = false
    
    private var travelTime: String {
        guard let route = locationModel.route else { return "30分" }
        let time = route.expectedTravelTime
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: time) ?? ""
    }
    
    private var distance: String {
        guard let route = locationModel.route else { return "500m" }
        let distance = Int(route.distance)
        return "\(distance) m"
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            
            //建物スライドビュー
            ZStack(alignment:.top){
                TabView{
                    ForEach(locationData.images,id:\.self){ image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .background(Image(image).resizable().scaledToFill().blur(radius: 30))
                            .zoomable() //photoviewにする？
                    }.ignoresSafeArea()
                }.tabViewStyle(PageTabViewStyle())
                    .ignoresSafeArea()
                        .frame(width:UIScreen.main.bounds.width,height: 250)

                HStack{
                    Button(action: {
                        dm()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                            .padding(15)
                            .background(
                                Circle().fill(Color.white)
                            )
                            .padding()
                    })
                    Spacer()
                }
            }
              //詳細表示部分
            ZStack{
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                VStack{
                    HStack{
                        VStack(alignment:.leading,spacing:10){
                            
                            Text(locationData.name)
                                .font(.title).bold()
            
                            Label(
                                title: {Text(locationData.address)},
                                icon: {Image(systemName: "location") }
                            )
                            
                            Spacer()
                            
                            Text("学科")
                                .font(.title).bold()
                            VStack(alignment:.leading){
                                ForEach(locationData.classes,id: \.self){ index in
                                    Text(index)
                                }
                            }
                            
                            Spacer()
                            
                            Text("フロアガイド")
                                .font(.title).bold()
                            ScrollView(.horizontal){
                                HStack{
                                    Text("設備:")
                                        .font(.title2)
                                    ForEach(locationData.facilities,id: \.self){ facility in
                                        Text(facility)
                                    }
                                }
                            }
                                 
                            HStack{
                                Spacer()
                                Button(action: {
                                    selectedPhoto = locationData.name
                                    refresh.toggle()
                                    DispatchQueue.main.async {
                                        isfullPhoto = true
                                    }
                                }, label: {
                                    Text("フロアマップを見る")
                                        .font(.title2)
                                        .underline()
                                        .padding()
                                })
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    HStack{
                        //歩きアイコン
                        //距離
                        HStack(spacing:20){
                            VStack(alignment:.leading){
                                Text("距離")
                                    .foregroundColor(.gray)
                                Text(distance)
                                    .font(.title)
                                    .bold()
                            }
                            //時間
                            VStack(alignment:.leading){
                                Text("時間")
                                    .foregroundColor(.gray)
                                Text(travelTime)
                                    .font(.title)
                                    .bold()
                            }
                        }
                        Spacer()
                        Button(action: {
                            locationModel.startFetchingRoute(to: locationData.coordinate)
                            dm()
                        }, label: {
                            Text("Go here")
                                .padding(.horizontal)
                        }).buttonStyle(.borderedProminent)
                            .clipShape(Capsule())
                    }
                }
            }.padding()
                
        }.fullScreenCover(isPresented: $isfullPhoto, content: {
            MapDetailPhotoView(Imagename: selectedPhoto)
        })
        .id(refresh) 
        .edgeSwipe()
    }
}

#Preview {
    MapDetailView(locationData: LocationDataModel(id: 0, name: "本館", latitude: 35.6585805, longitude: 139.7454329, address: "東京都千代田区丸の内1-1-1",classes: [""], facilities: ["トイレ","多目的トイレ","AED","学習スペース","喫煙スペース","自動販売機"], images: ["6","保健室"]))
}
