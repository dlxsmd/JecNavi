//
//  ContentView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/11.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let main_building = CLLocationCoordinate2D(latitude: 35.698425, longitude: 139.698122)
}
let stroke = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)

let gradient = Gradient(colors: [.green, .yellow, .orange])

struct MapView: View {
    @ObservedObject private var locationModel = LocationModel.shared
    @State private var selectedFeature: MapFeature?
    @State private var selectedLocation: LocationDataModel?
    @State private var locationManager = CLLocationManager()
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: .main_building,
        latitudinalMeters: 500,
        longitudinalMeters: 500
    ))
    
    @State private var isShowPopUp = false
    @State private var isShowList = false
    @State private var isShowDetail = false
    
//    @State private var isConfirmStop = false
    
    private var travelTime: String {
        guard let route = locationModel.route else { return "" }
        let time = route.expectedTravelTime
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: time) ?? ""
    }
    
    
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Map(position: $cameraPosition, selection: $selectedFeature) {
                UserAnnotation()
                ForEach(AnnotationLocation) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        VStack {
                            spotIcon()
                                .onTapGesture {
                                    if !locationModel.isFetchingRoute{
                                    isShowPopUp = true
                                    selectedLocation = location
                                        locationModel.fetchRoute(destination: selectedLocation!.coordinate)
                                    }
                                    withAnimation {
                                        let cameraLocation = CLLocationCoordinate2D(latitude: location.latitude - 0.0002, longitude: location.longitude)
                                        cameraPosition = .region(MKCoordinateRegion(center: cameraLocation, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)))
                                    }
                                }
                        }
                    }
                }
                if let route = locationModel.route {
                    MapPolyline(route)
                        .stroke(gradient, style: stroke)
                }
            }
            .mapControls {
                MapUserLocationButton()
            }
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
            }
            if isShowPopUp{
                Button {
                    isShowPopUp = false
                    if !locationModel.isFetchingRoute{
                        locationModel.route = nil
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.gray)
                        .padding(15)
                        .background(
                            Circle().fill(Color.white)                            .shadow(radius: 10)
                        )
                        .padding()
                }

            }else if locationModel.isFetchingRoute{
                Button(action: {
                    locationModel.stopFetchingRoute()
                }, label: {
                    ZStack{
                        Circle()
                            .fill(Color.red)
                            .frame(width: 50, height: 50)
                            .shadow(radius: 10)
                        
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }.padding()
                })
                Text("TravelTime:\(travelTime)")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .position(x:UIScreen.main.bounds.maxX/2, y: 40)
                
            }
            if !isShowPopUp{
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isShowList = true
                        }, label: {
                            Image(systemName: "list.bullet")
                                .font(.title)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        })
                        .padding()
                        .padding(.bottom, 70)
                    }
                }
            }

            if isShowPopUp {
                if let location = selectedLocation {
                    VStack {
                        Spacer()
                        PopUpView(locationData: location, isShowPopUp: $isShowPopUp)
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                            .padding()
                            .onTapGesture {
                                isShowDetail = true
                            }
                            .offset(y: -100)
                    }
                    .fullScreenCover(isPresented: $isShowDetail, content: {
                        MapDetailView(locationData: location)
                    })
                    .transition(.move(edge: .bottom))
                }
            }
        }//ZStack
        .tint(.green)
        .fullScreenCover(isPresented: $isShowList, content: {
            MapListView(cameraPosition: $cameraPosition)
        })
        .alert(isPresented: $locationModel.isArrived) {
            Alert(title: Text("Arrived at the destination"), dismissButton: .default(Text("OK"), action: {
                locationModel.stopFetchingRoute()
            }))
        }
        
        
        
        
    }
}

struct spotIcon: View {
    var body: some View {
        ZStack {
            Text("🏢")
                .frame(width: 40, height: 40)
                .background(Color.green.opacity(0.7))
                .cornerRadius(30.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
            Circle()
                .stroke(Color.white, lineWidth: 2)
        }
    }
}

#Preview {
    MapView()
}
