//
//  Schedule.swift
//  JecNavi
//
//  Created by yuki on 2024/06/27.
//

import SwiftUI
import PDFKit

struct ScheduleView: View {
    let url = Bundle.main.url(forResource: "schedule", withExtension: "pdf")!
    var body: some View {
            SchedulePDFKitView(url: url)
    }
}

struct SchedulePDFKitView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        // 処理なし
    }
}

#Preview {
    ScheduleView()
}
