//
//  PDFSearchManager.swift
//  JecNavi
//
//  Created by yuki on 2024/06/28.
//

import SwiftUI
import PDFKit

struct PDFSearchResult: Identifiable {
    let id = UUID()
    let selection: PDFSelection
    let pageIndex: Int
}

class PDFSearchManager: ObservableObject {
    @Published var searchResults: [PDFSearchResult] = []
     var pdfDocument: PDFDocument?
    
    func loadPDF(url: URL) {
        pdfDocument = PDFDocument(url: url)
    }
    
    func search(query: String) {
        searchResults.removeAll()
        guard let pdfDocument = pdfDocument else { return }
        
        let selections = pdfDocument.findString(query, withOptions: .caseInsensitive)
        searchResults = selections.map { selection in
            let pageIndex = pdfDocument.index(for: selection.pages.first!) // 最初のページのインデックスを取得
            return PDFSearchResult(selection: selection, pageIndex: pageIndex)
        }
    }
}
