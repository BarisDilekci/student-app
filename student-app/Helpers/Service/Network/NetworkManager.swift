//
//  NetworkManager.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import Foundation


enum URLPath: String {
    case addStudent = "/students/addStudent" // Yeni yol ekleniyor
    case getAllStudents = "/students/getAllStudent" // Diğer yol
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
    }
}
