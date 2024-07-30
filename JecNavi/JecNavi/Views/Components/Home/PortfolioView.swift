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
                                    Text(portfolio.productName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text(portfolio.creatorName)
                                        .font(.subheadline)
                                    Text(portfolio.creatorClass)
                                        .font(.subheadline)
                                    Text(portfolio.description)
                                        .font(.subheadline)
                                }.padding()
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

#Preview {
    PortfolioView()
}
