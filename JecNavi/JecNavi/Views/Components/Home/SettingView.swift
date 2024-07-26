//
//  SettingView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/23.
//

import SwiftUI
import WebViewKit
import StoreKit
import Alamofire

struct SettingView: View {
    @AppStorage("isInit") var isInit = true
    @Environment(\.requestReview) var requestReview
    @ObservedObject var model = ChatRoomsModel.shared
    @State private var isContactDev = false
    @State private var weather: WeatherDataModel?

    private let ID = Config.developerID
    var body: some View {
        List{
            Section{
                AccountView()
            }
            Section("レビュー・シェアで開発を応援しよう！"){ //宣伝、評価
                Button {
                    requestReview()
                } label: {
                    Label("App Storeで評価", systemImage: "star.fill")
                        .foregroundColor(.black)
                }
                ShareLink(
                    item: URL(string:"https://apps.apple.com/jp/app/jecmap/id6443915440")!,
                    subject: Text("JecNavi"),
                    message: Text("""
                    🚀 JecNavi - 学校生活がもっと便利に！ 🚀
                    
                    学校のニュースやキャンパスマップを一目でチェックできる「JecNavi」は、あなたの学校生活をよりスムーズにサポートします！✨
                    
                    🎉 今すぐダウンロードして、JecNaviで学校生活をもっと楽しもう！ 🎉
                    
                    #JecNavi #日本電子専門学校
                    """
                                 )
                    
                )
                
                
                
            }
            Section("学校周辺の気象情報"){
                //仮
                VStack{
                    if let weather = weather {
                        HStack{
                            VStack{
                                Text(weather.weather[0].description)
                                    .font(.title)
                                HStack{
                                    Image(systemName: "drop")
                                    Text("湿度: \(weather.main.humidity)%")
                                }
                                HStack{
                                    Image(systemName: "wind")
                                    Text("風速: \(String(format: "%.1f", weather.wind.speed))m/s")
                                }
                            }.font(.caption)
                            Spacer()
                                VStack{
                                    //小数点１桁までの気温表示
                                    Text(String(format: "%.1f", weather.main.temp)).font(.system(size: 50))
                                
                                    Text("\(Image(systemName:"arrowtriangle.up.fill"))\(String(format: "%.1f", weather.main.tempMax))   \(Image(systemName:"arrowtriangle.down.fill"))\(String(format: "%.1f", weather.main.tempMin))")
                                    
                                }
                            }.padding(10)
                    }else{
                        Text("天気情報を取得中...")
                    }
                }
                //仮
            }.onAppear(){
                FetchWeather() { weatherData in
                    DispatchQueue.main.async {
                        self.weather = weatherData
                    }
                }
            }
            Section{
                NavigationLink(destination: SongView()) {
                    HStack{
                        Image(systemName: "music.note")
                            .foregroundColor(.green)
                        Text("School Song")
                            .padding()
                    }
                }
            }
            
            Section("Others"){
                NavigationLink(destination: WebView(urlString: "https://www.jec.ac.jp")) {
                    Text("記事及び各学内サイトの掲載元")
                }
                
                NavigationLink(destination: WebView(urlString: "https://doso.jec.ac.jp/")) {
                    Text("同窓会サイト")
                }
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text("プライバシーポリシー")
                }
                NavigationLink(destination: TermsOfServiceView()) {
                    Text("利用規約")
                }
                Button(action: {
                    if UIApplication.shared.canOpenURL(URL(string: "instagram://")!) {
                        guard let url = URL(string: "instagram://user?username=nichiden1951") else { return }
                        UIApplication.shared.open(url)
                    }else{
                        guard let url = URL(string: "https://www.instagram.com/nichiden1951") else { return }
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    HStack{
                        Image("instalogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("公式インスタグラム")
                            .foregroundColor(.black)
                    }
                })
            }
            
            Section(header: Text("開発者について")){
                Button(action: {
                    if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
                        guard let url = URL(string: "twitter://user?id=1809757309243203584") else { return }
                        UIApplication.shared.open(url)
                    }else{
                        guard let url = URL(string: "https://X.com/JecNavi") else { return }
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    HStack{
                        Image("xlogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("アプリ公式X")
                            .foregroundColor(.black)
                    }
                })
                Link(destination: URL(string: "https://dlxsmd.github.io/portfolio/")!) {
                    HStack{
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                        Text("ポートフォリオ")
                            .foregroundColor(.black)
                    }
                }
                Button(action: {
                    model.chatRoomExists(otherUserID:ID) { exists in
                        if !exists {
                            model.createChatRoom(otherUserID: ID)
                            //alert??
                        }else{
                            //alert??
                        }
                    }
                    isContactDev = true
                }, label:{
                    HStack{
                        Image("support")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .overlay{
                                Circle().stroke(Color.black,lineWidth: 2)
                            }
                        Text("開発者のチャットを追加する\n")
                            .foregroundColor(.black)
                        +
                        Text("※サポートが必要な時にご利用ください")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                })
            }
            Button("イントロデバッグ"){
                isInit = true
            }
        }
        .fullScreenCover(isPresented: $isContactDev) {
            ChatRoomsView()
        }
    }
    private func FetchWeather(completion: @escaping (WeatherDataModel?) -> Void){
        
        let apikey = Config.weatherAPIKey
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=35.6982122&lon=139.6981188&appid=\(apikey)&units=metric&lang=ja").responseDecodable(of: WeatherDataModel.self) { response in
            switch response.result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.weather = value
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    SettingView()
}
