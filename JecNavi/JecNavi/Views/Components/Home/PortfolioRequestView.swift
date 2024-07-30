//
//  PortfolioRequestView.swift
//  JecNavi
//
//  Created by Yuki Imai on 2024/07/23.
//

import SwiftUI
import PhotosUI

struct PortfolioRequestView: View {
    @State private var productName: String = ""
    @State private var creatorName: String = ""
    @State private var creatorClass: String = ""
    @State private var description: String = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var uiImages: [UIImage?] = []
    
    @Environment(\.dismiss) var dm
    
    let portfolioModel = PortfolioModel()
    
 //request datamodel

    var body: some View {
        ScrollView{
            VStack{
                Text("ポートフォリオ掲載リクエスト")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading){
                    Text("掲載したい作品名")
                        .font(.subheadline)
                    TextField("ぼくのなつやすみ", text: $productName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                VStack(alignment: .leading){
                    Text("掲載する際の名前・ニックネーム")
                        .font(.subheadline)
                    TextField("電子　太郎", text: $creatorName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                VStack(alignment: .leading){
                    Text("所属している学科")
                        .font(.subheadline)
                    TextField("モバイルアプリケーション開発科", text: $creatorClass)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding()
                
                VStack(alignment: .leading){
                    Text("作品の画像（最大5枚まで）")
                        .font(.subheadline)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(uiImages, id: \.self) { uiImage in
                                if let uiImage {
                                    
                                    ZStack(alignment:.topLeading){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .scaledToFit()
                                            .contextMenu {
                                                Button(action: {
                                                    if let index = uiImages.firstIndex(of: uiImage) {
                                                        uiImages.remove(at: index)
                                                    }
                                                }) {
                                                    Label("削除", systemImage: "trash")
                                                }
                                            }
                                        
                                        //写真番号
                                        Text("\((uiImages.firstIndex(of: uiImage) ?? 0) + 1)")
                                            .padding(10)
                                            .background(Color.white.opacity(0.7))
                                            .clipShape(Circle())
                                            .font(.caption)
                                    }
                                }
                            }
                            if uiImages.count < 5{
                                PhotosPicker(selection: $selectedPhoto ,matching: .images){
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 100)
                                        .overlay(
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                        )
                                }
                                .onChange(of: selectedPhoto) {
                                    Task { await loadImageFromSelectedPhoto(photo: selectedPhoto) }
                                }
                            }
                        }
                    }
                }.padding(.horizontal)


                
                VStack(alignment: .leading){
                    Text("作品の説明・アピールポイント")
                        .font(.subheadline)
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .border(Color.gray, width: 1)
                }.padding()
                
                
                Button(action: {
                    portfolioModel.UploadImage(uiImages: uiImages) { result in
                            switch result {
                            case .success(let urls):
                                let requestData = PortfolioDataModel(
                                    productName: productName,
                                    creatorName: creatorName,
                                    creatorClass: creatorClass,
                                    description: description,
                                    uiImages: urls,
                                    isPublished: false
                                )
                                portfolioModel.addRequest(request: requestData)
                                dm()
                            case .failure(let error):
                                print("Image upload failed with error: \(error)")
                            }
                        }
                }) {
                    Text("リクエストを送信")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                } .padding()
                    .disabled(productName.isEmpty || creatorName.isEmpty || creatorClass.isEmpty || description.isEmpty || uiImages.isEmpty)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

    }

    private func loadImageFromSelectedPhoto(photo: PhotosPickerItem?) async {
        if let data = try? await photo?.loadTransferable(type: Data.self) {
            self.uiImages.append(UIImage(data: data))
        }
    }
}

#Preview {
    PortfolioRequestView()
}
