//
//  ImportantListView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/23.
//

import SwiftUI
import WebViewKit

struct ImportantListView: View {
    @ObservedObject var model = JecApiModel.shared
    var body: some View {
        VStack{
            if model.important.isEmpty {
                ProgressView()
                    .padding()
            }else {
                List(model.important, id: \.link) { article in
                    NavigationLink(destination: WebView(urlString: article.link)) {
                        VStack(alignment: .leading) {
                            Text(article.date)
                                .font(.title3)
                            Text(article.title)
                                .font(.headline)
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                    
                }
            }
        }
            .onAppear {
                model.fetchimportant()
            }
    }
}

#Preview {
    ImportantListView()
}
