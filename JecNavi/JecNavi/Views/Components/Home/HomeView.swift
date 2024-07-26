//
//  HomeView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/13.
//

import SwiftUI
import WebViewKit

struct HomeView: View {
    @State var isShowSetting = false
    @ObservedObject var authenticationManager = AuthenticationManager()
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                HeaderView()
                ScrollView{
                    VStack(spacing:0){
                        ZStack(alignment:.bottom){
                            Image("Home")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            NavigationLink(destination: WebView(urlString: "https://www.jec.ac.jp/")){
                                Text("Tap here for official website")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width,height: 50)
                                    .background(Color.black.opacity(0.6))
                            }
                        }//ZStack
                        ZStack{
                            Color(UIColor.systemGray6).ignoresSafeArea()
                            VStack{
                                Spacer(minLength: 20)
                                
                                Link(destination: URL(string: "https://sip5.jec.ac.jp/prx/000/http/localhost/login/index.html")!){
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("Student Portal Site")
                                                .foregroundColor(.black)
                                            Text("Login")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .padding(5)
                                                .padding(.horizontal,20)
                                                .background(Color.orange)
                                                .cornerRadius(30)
                                        }
                                        Spacer()
                                        Image("portal_logo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100)
                                    }.padding(20)
                                        .frame(width: UIScreen.main.bounds.width - 30)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                Link(destination: URL(string: "https://sites.google.com/jec.ac.jp/jecsakuranavi/")!){
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("Sakura Navi")
                                                .foregroundColor(.black)
                                            Text("Login")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .padding(5)
                                                .padding(.horizontal,20)
                                                .background(Color.pink)
                                                .cornerRadius(30)
                                        }
                                        Spacer()
                                        Image("sakura_logo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80)
                                            .padding(.trailing,15)
                                    }.padding(20)
                                        .frame(width: UIScreen.main.bounds.width - 30)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                
                                NavigationLink {
                                    PortfolioRequestView()
                                } label: {
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("みんなの作品集")
                                                .foregroundColor(.black)
                                            Text("一覧を見る")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .padding(5)
                                                .padding(.horizontal,20)
                                                .background(Color.blue)
                                                .cornerRadius(30)
                                        }
                                        Spacer()
                                        Image("sakura_logo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80)
                                            .padding(.trailing,15)
                                    }.padding(20)
                                        .frame(width: UIScreen.main.bounds.width - 30)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }

                                
                                
                                
                                HStack{
                                    VStack{
                                        
                                        Link(destination: URL(string:"https://sites.google.com/jec.ac.jp/gakuseimadoguchi")!){
                                            VStack{
                                                Image(systemName:"graduationcap")
                                                    .foregroundColor(.green)
                                                    .scaleEffect(2)
                                                    .padding()
                                                Text("Student Counter")
                                            }
                                        }
                                        .foregroundColor(.black)
                                        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                        .background(Color.white)
                                        
                                        Link(destination: URL(string:"https://sites.google.com/jec.ac.jp/jecryugakusei/")!){
                                            VStack{
                                                Image(systemName:"globe.asia.australia")
                                                    .foregroundColor(.green)
                                                    .scaleEffect(2)
                                                    .padding()
                                                Text("International Student Counter")
                                            }
                                        }
                                        .foregroundColor(.black)
                                        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                        .background(Color.white)
                                        
                                        NavigationLink(destination: GuideSearchView()){
                                            VStack{
                                                Image(systemName:"globe.asia.australia")
                                                    .foregroundColor(.green)
                                                    .scaleEffect(2)
                                                    .padding()
                                                Text("Campus Life Guide")
                                            }
                                        }
                                        .foregroundColor(.black)
                                        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                        .background(Color.white)
                                        
                                        
                                        
                                    }//VStack
                                    VStack{
                                        Link(destination: URL(string:"https://sites.google.com/jec.ac.jp/license/home")!){
                                            VStack{
                                                Image(systemName:"person.text.rectangle")
                                                    .foregroundColor(.green)
                                                    .scaleEffect(2)
                                                    .padding()
                                                Text("License Center")
                                            }.foregroundColor(.black)
                                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                                .background(Color.white)
                                        }
                                        
                                        Link(destination: URL(string:"https://sites.google.com/jec.ac.jp/health")!){
                                            VStack{
                                                Image(systemName:"heart.text.square")
                                                    .foregroundColor(.green)
                                                    .scaleEffect(2)
                                                    .padding()
                                                Text("School Infirmary")
                                            }.foregroundColor(.black)
                                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                                .background(Color.white)
                                        }
                                        NavigationLink(destination: ScheduleView()){
                                            VStack{
                                                Image(systemName:"heart.text.square")
                                                    .foregroundColor(.green)
                                                    .scaleEffect(2)
                                                    .padding()
                                                Text("Yearly Schedule")
                                            }.foregroundColor(.black)
                                                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 100)
                                                .background(Color.white)
                                        }
                                        
                                    }//VStack
                                }
                            }
                            .padding(.bottom,80)
                        }//ZStack
                    }//VStack
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
