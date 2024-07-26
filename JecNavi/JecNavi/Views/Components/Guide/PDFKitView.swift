//
//  PDFKitView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/17.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL
    @Binding var searchResults: [PDFSearchResult]
    @Binding var selectedPageIndex: Int
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
            if let page = pdfView.document?.page(at: selectedPageIndex) {
                pdfView.go(to: page)
            }
        
        pdfView.highlightSelections(searchResults.map { $0.selection })
    }
}

extension PDFView {
    func highlightSelections(_ selections: [PDFSelection]) {
        for selection in selections {
            selection.color = .yellow
            self.setCurrentSelection(selection, animate: true)
        }
    }
}
