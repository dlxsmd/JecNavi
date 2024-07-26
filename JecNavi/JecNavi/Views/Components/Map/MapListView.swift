//
//  MapListVew.swift
//  JecNavi
//
//  Created by yuki on 2024/06/30.
//

import SwiftUI
import MapKit

struct MapListView:View{
    @Environment(\.dismiss) var dm
    @Binding var cameraPosition: MapCameraPosition
    @State var filter:String = ""
    @State var selectedFacilities: [String] = []
    @State var selectedClass: String = ""
    @State var isShowFilter = false
    var body: some View{
        ZStack{
            Color(UIColor.systemGray6).ignoresSafeArea()
            ScrollView{
                HStack{
                    Button(action: {
                        dm()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                            .foregroundColor(.gray)
                    })
                    SearchBar(text: $filter, searchAction: {_ in })
                    Divider()
                    Button(action: {
                        isShowFilter = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                            .scaleEffect(1.5)
                            .padding(.horizontal,5)
                            .foregroundColor(.gray)
                    })
                }.padding()
                ForEach(filteredLocation){ location in
                    MapListRowView(locationData: location)
                        .onTapGesture {
                            cameraPosition = .region(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)))
                            dm()
                        }
                }
            }.animation(.easeInOut(duration: 0.5),value: filteredLocation.count)
        }
        .sheet(isPresented: $isShowFilter) {
            MapListFilterView(selectedFacilities: $selectedFacilities, selectedClass: $selectedClass)
                .presentationDetents([.height(450)])
        }
        .edgeSwipe()
    }
    var filteredLocation: [LocationDataModel] {
            AnnotationLocation.filter { location in
                // 施設のフィルタリング条件
                let facilityMatch = selectedFacilities.isEmpty || selectedFacilities.allSatisfy { facility in
                    location.facilities.contains(facility)
                }
                
                // 学科のフィルタリング条件
                let classMatch = selectedClass.isEmpty || location.classes.contains(selectedClass)
                
                // テキストのフィルタリング条件
                let textMatch = filter.isEmpty || location.name.contains(filter) || location.classes.contains(filter) || location.facilities.contains(filter)
                
                // 全ての条件が満たされていればtrueを返す
                return facilityMatch && classMatch && textMatch
            }
        }
}

