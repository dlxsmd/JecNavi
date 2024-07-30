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
    @State var likes: [LikeView] = []
    @State var isShowImage = false
    var body: some View {
        VStack{
            Text(portfolio.productName)
                .font(.title)
                .fontWeight(.bold)
            ScrollView(.horizontal){
                HStack{
                    ForEach(uiImages, id: \.self){ uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
                        .onTapGesture {
                            isShowImage.toggle()
                        }
                    }
                }
            }.onAppear(){
                loadImages()
            }
            .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
            .fullScreenCover(isPresented: $isShowImage) {
                PhotoZoomView(images: uiImages)
            }
            
            
            HStack{
                ZStack{
                    Button(action: {
                        model.sendlike(portfolio: portfolio)
                        likeAction()
                    }){
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    ForEach (likes) { like in
                        like.image.resizable()
                            .frame(width: 20, height: 20)
                            .modifier(LikeTapModifier())
                    }.onChange(of: likes) {
                        if likes.count > 5 {
                            likes.removeFirst()
                        }
                    }
                }
                Text("\(portfolio.like)")
                Spacer()
                VStack(alignment:.trailing){
                    Text(portfolio.creatorName)
                        .font(.subheadline)
                    Text(portfolio.creatorClass)
                        .font(.caption)
                }
            }.padding()
            Text(portfolio.description)
            Spacer()
        }.padding()
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
    func likeAction(){
        likes.append(LikeView())
    }
}


#Preview{
    PortfolioDetailView(portfolio: PortfolioDataModel(productName: "プロダクト名", creatorName: "作成者名", creatorClass: "作成者クラス", description: "説明", uiImages: ["https://firebasestorage.googleapis.com:443/v0/b/jecnavi.appspot.com/o/images%2F422B0E79-CCD9-40BE-9570-75A1DC0DB512.jpg?alt=media&token=c50c1996-1c24-4dcd-989e-79b057148633"
, "https://firebasestorage.googleapis.com:443/v0/b/jecnavi.appspot.com/o/images%2F422B0E79-CCD9-40BE-9570-75A1DC0DB512.jpg?alt=media&token=c50c1996-1c24-4dcd-989e-79b057148633"
], isPublished: true,like: 0))
}
