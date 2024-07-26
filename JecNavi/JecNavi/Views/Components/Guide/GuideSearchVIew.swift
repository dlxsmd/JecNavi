import SwiftUI
import PDFKit

struct GuideSearchView: View {
    @Environment(\.dismiss) var dm
    @ObservedObject var searchManager = PDFSearchManager()
    @State private var searchText: String = ""
    @State private var selectedResultIndex: Int = 0
    @State private var currentPageIndex: Int = 0
    @State private var pageCount: Int = 0 // ドキュメントのページ数を保存
    private var url: URL? {
        return Bundle.main.url(forResource: "living-guide", withExtension: "pdf")
    }
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    dm()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .padding(.leading)
                }

                SearchBar(text: $searchText, searchAction: { text in
                    searchManager.search(query: text)
                    selectedResultIndex = 0 // リセット
                    if !searchManager.searchResults.isEmpty {
                        currentPageIndex = searchManager.searchResults[selectedResultIndex].pageIndex
                    }
                })
            }.padding(10)
            
                if let url = url {
                        PDFKitView(url: url, searchResults: $searchManager.searchResults, selectedPageIndex: $currentPageIndex)
                            .edgesIgnoringSafeArea(.all)
                } else {
                    Text("PDF file is not available.")
                }
                
                HStack {
                    Button(action: {
                        if !searchManager.searchResults.isEmpty {
                            if selectedResultIndex > 0 {
                                selectedResultIndex -= 1
                                currentPageIndex = searchManager.searchResults[selectedResultIndex].pageIndex
                            }
                        } else {
                            currentPageIndex = max(currentPageIndex - 1, 0)
                        }
                    }) {
                        Image(systemName: "arrow.backward.circle")
                            .scaleEffect(1.5)
                            .padding()
                            
                    }
                    .disabled(currentPageIndex == 0 && searchManager.searchResults.isEmpty)
                    
                    Spacer()
                    
                    Text(searchManager.searchResults.isEmpty ? "ページ数: \(currentPageIndex + 1) / \(pageCount)" : "検索結果: \(selectedResultIndex + 1)/\(searchManager.searchResults.count)件")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Spacer()
                    
                    Button(action: {
                        if !searchManager.searchResults.isEmpty {
                            if selectedResultIndex < searchManager.searchResults.count - 1 {
                                selectedResultIndex += 1
                                currentPageIndex = searchManager.searchResults[selectedResultIndex].pageIndex
                            }
                        } else {
                            currentPageIndex = min(currentPageIndex + 1, pageCount - 1)
                        }
                    }) {
                        Image(systemName: "arrow.forward.circle")
                            .scaleEffect(1.5)
                            .padding()
                    }
                    .disabled(currentPageIndex >= pageCount - 1 && searchManager.searchResults.isEmpty)
                    .padding()
                }
        }
        .onAppear {
            if let url = url {
                searchManager.loadPDF(url: url)
                currentPageIndex = 0
                pageCount = searchManager.pdfDocument?.pageCount ?? 0 // ページ数を取得
            }
        }
        .onDisappear(){
            searchManager.searchResults.removeAll()
        }
        .navigationBarHidden(true)
        .edgeSwipe()
    }
}

#Preview {
    GuideSearchView()
}
