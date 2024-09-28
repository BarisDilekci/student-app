//
//  DateFormatter+Extensions.swift
//  student-app
//
//  Created by Barış Dilekçi on 29.09.2024.
//

import Foundation

extension Date {
    func formattedForAPI() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: self)
    }

    func formattedForDisplay() -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd MMMM yyyy" // Kullanıcı dostu format
           return formatter.string(from: self)
       }
}
