//
//  PortfollioView.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/23.
//

import SwiftUI

struct PortfolioView: View {
    @ObservedObject var portfolioModel = PortfolioModel()
    var body: some View {
        VStack{
            Text("ポートフォリオ")
                .font(.title)
                .fontWeight(.bold)
            ScrollView{
                LazyVStack{
                    ForEach(portfolioModel.requests, id: \.id){ portfolio in
                        if portfolio.isPublished{
                            NavigationLink(destination: PortfolioDetailView(portfolio: portfolio)){
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(portfolio.productName)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        Spacer()
                                        VStack(alignment:.trailing){
                                            Text(portfolio.creatorName)
                                                .font(.subheadline)
                                            Text(portfolio.creatorClass)
                                                .font(.caption)
                                        }
                                    }
                                    
                                    Text(portfolio.description)
                                        .font(.subheadline)
                                }.padding()
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            portfolioModel.fetchRequests()
        }
    }
}

#Preview{
    PortfolioView()
}
