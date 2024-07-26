//
//  MapListFilterView.swift
//  JecNavi
//
//  Created by yuki on 2024/07/18.
//

import SwiftUI

struct MapListFilterView: View {
    let facilities = ["トイレ","多目的トイレ","AED","学習スペース","喫煙スペース","自動販売機"]
    
    //学科は辞書型で
    let classes = [
        "AD":"コンピュータグラフィックス科",
        "AU":"コンピュータグラフィックス研究科",
        "AV":"ＣＧ映像制作科",
        "CI":"ゲーム制作科",
        "CU":"ゲーム制作研究科",
        "CR":"ゲーム企画科",
        "AC":"アニメーション科",
        "AR":"アニメーション研究科",
        "AG":"グラフィックデザイン科",
        "JN":"情報処理科",
        "JZ":"高度情報処理科",
        "JY":"情報システム開発科",
        "CM":"モバイルアプリケーション開発科",
        "AW":"Ｗｅｂデザイン科",
        "CA":"ＡＩシステム科",
        "JK":"ＤＸスペシャリスト科",
        "CC":"ネットワークセキュリティ科",
        "E0":"電子応用工学科",
        "KJ":"電気工学科",
        "KK":"電気工事技術科",
    ]
    
    @Binding var selectedFacilities: [String]
    @Binding var selectedClass: String
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    selectedFacilities = []
                    selectedClass = ""
                }, label: {
                    Text("条件をクリアする")
                        .font(.title3)
                        .foregroundColor(.red)
                })
            }.padding()
            Text("学科から探す")
                .font(.title3).bold()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 6))], spacing: 5) {
                ForEach(classes.sorted(by: <),id:\.key){ key, value in
                    Button(action: {
                        if selectedClass != value{
                            selectedClass = value
                        } else {
                            selectedClass = ""
                        }
                    }, label: {
                        if selectedClass == value {
                            Text( "\(key)")
                                .font(.caption)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().stroke(Color(.green),lineWidth: 2)
                                )
                        }else{
                            Text("\(key)")
                                .font(.caption)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .foregroundColor(.black)
                                .clipShape(Capsule())

                        }
                    })
                }
            }.padding()
            
            
            
            
            Text("設備から探す")
                .font(.title3).bold()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100,maximum: UIScreen.main.bounds.width / 3))], spacing: 10) {
                ForEach(facilities,id:\.self){ facility in
                    Button(action: {
                        if !selectedFacilities.contains(facility) {
                            selectedFacilities.append(facility)
                        } else {
                            selectedFacilities.removeAll { $0 == facility }
                        }
                    }, label: {
                        if selectedFacilities.contains(facility) {
                            Text( "\(facility)")
                                .font(.caption)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().stroke(Color(.green),lineWidth: 2)
                                )
                        }else{
                            Text("\(facility)")
                                .font(.caption)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                        }
                    })
                }
            }.padding()
        }.frame(height:450)
        
    }
}

#Preview {
    MapListFilterView(selectedFacilities:.constant([""]),selectedClass:.constant(""))
}
