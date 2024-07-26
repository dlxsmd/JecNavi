//
//  DateHeaderView.swift
//  JecNavi
//
//  Created by yuki on 2024/06/26.
//

import SwiftUI

struct DateHeaderView: View {
    let date: Date
    
    var body: some View {
        Text(date, style: .date)
            .font(.headline)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.vertical, 8)
    }
}

#Preview{
    DateHeaderView(date: Date())
}
