//
//  JecApiModel.swift
//  JecNavi
//
//  Created by yuki on 2024/06/17.
//

import Foundation
import Alamofire


class JecApiModel: ObservableObject {
    public static let shared = JecApiModel()
    @Published var important: [importantData] = []
    @Published var news: [newsData] = []
    @Published var isFetching = false // フェッチ中かどうかのフラグ
    private var currentPage = 1 //
    
    func fetchimportant() {
        AF.request("https://jecapi.onrender.com/api/important").responseDecodable(of: [importantData].self) { response in
            switch response.result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.important = value
                }
                print(self.important)
            case .failure(let error):
                print(error)
            }
        }
    }
    func fetchnews() {
            guard !isFetching else { return } // フェッチ中でない場合のみフェッチを開始
            isFetching = true
            
            let url = "https://jecapi.onrender.com/api/news?page=\(currentPage)"
            
            AF.request(url).responseDecodable(of: [newsData].self) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let newArticles):
                        self.news.append(contentsOf: newArticles)
                        self.currentPage += 1
                        print(newArticles)
                    case .failure(let error):
                        print(error)
                    }
                    self.isFetching = false
                }
            }
        }
}
