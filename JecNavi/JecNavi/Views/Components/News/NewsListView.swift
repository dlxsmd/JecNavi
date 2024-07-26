//
//  NewsListView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/23.
//

import SwiftUI
import WebViewKit

struct NewsListView: View {
    @ObservedObject var model = JecApiModel.shared

    var body: some View {
                ScrollView {
                        ForEach(model.news, id: \.link) { article in
                            NavigationLink(destination: WebView(urlString: article.link)) {
                                VStack(alignment:.leading) {
                                    AsyncImage(url: URL(string: article.image)!) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.main.bounds.width - 20,height: 250)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: UIScreen.main.bounds.width - 20,height: 250)
                                    }
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(article.title)
                                            .font(.headline)
                                            .multilineTextAlignment(
                                                .leading)
                                        Text(article.date)
                                            .font(.title3)
                                    }.foregroundColor(.black)
                                    .padding(10)
                                }
                                .padding()
                            }
                    }
                    if model.isFetching {
                        ProgressView()
                            .padding()
                    } else {
                        Button(action: {
                            model.fetchnews()
                        }) {
                            Text("Load More")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.bottom,100)
                    }
                }
            .onAppear {
                if model.news.isEmpty {
                    model.fetchnews()
                }
            }
        }
}


#Preview {
    NewsListView()
}
