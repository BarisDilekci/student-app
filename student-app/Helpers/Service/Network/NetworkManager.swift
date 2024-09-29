//
//  NetworkManager.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import Foundation



enum URLPath {
    case addStudent
    case getAllStudents
    case deleteStudent(tcNumber: String)
    case updateStudent(tcNumber: String)

    var rawValue: String {
        switch self {
        case .addStudent:
            return "/students/addStudent"
        case .getAllStudents:
            return "/students/getAllStudent"
        case .deleteStudent(let tcNumber):
            return "/students/deleteStudent/\(tcNumber)"
        case .updateStudent(let tcNumber):
            return "/students/updateStudent/\(tcNumber)"
                
        }
    }
}

struct NetworkRequest {
    let method: HTTPMethod
    let url: URL
}

class NetworkManager {
    let baseUrl: URL?
    
    init(baseUrl: String) {
        self.baseUrl = URL(string: baseUrl)
        
        guard self.baseUrl != nil else {
            fatalError("Geçersiz base URL: \(baseUrl)")
        }
    }
    
    func buildURL(urlPath: URLPath) -> URL? {
        guard let baseUrl = baseUrl else {
            return nil
        }
        return baseUrl.appendingPathComponent(urlPath.rawValue)
    }
}

extension NetworkRequest {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
}
