//
//  Student.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import Foundation

struct Student: Codable, Identifiable {
    var id: Int { tcNumber }
    let name: String
    let lastname: String
    let tcNumber: Int
    let dateOfBirth: String // Öncelikle String olarak tanımlayın

    enum CodingKeys: String, CodingKey {
        case name
        case lastname
        case tcNumber = "tc_number"
        case dateOfBirth = "date_of_birth"
    }
}
