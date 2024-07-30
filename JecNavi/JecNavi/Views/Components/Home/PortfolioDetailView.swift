//
//  PortfolioDetilView.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/29.
//

import SwiftUI

struct PortfolioDetailView: View {
    let portfolio: PortfolioDataModel
    var model = PortfolioModel()
    @State var uiImages: [UIImage] = []
    var body: some View {
        VStack{
            Text(portfolio.productName)
                .font(.title)
                .fontWeight(.bold)
            Text(portfolio.creatorName)
                .font(.subheadline)
            Text(portfolio.creatorClass)
                .font(.subheadline)
            Text(portfolio.description)
                .font(.subheadline)
            ScrollView(.horizontal){
                HStack{
                    ForEach(uiImages, id: \.self){ uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
            }.onAppear(){
                loadImages()
            }
        }
    }
    func loadImages() {
            for url in portfolio.uiImages {
                model.loadImage(url: url) { image in
                    if let image = image {
                        DispatchQueue.main.async {
                            self.uiImages.append(image)
                        }
                    }
                }
            }
        }
}
