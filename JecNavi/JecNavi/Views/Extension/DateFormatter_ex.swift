//
//  DateFormatter_ex.swift
//  JecNavi
//
//  Created by yuki on 2024/06/26.
//

import Foundation


extension DateFormatter {
    static var shortTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
    static var mediumDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }
    static var shortDatewithWeek: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd(EEEEE)"
        return formatter
    }
}
