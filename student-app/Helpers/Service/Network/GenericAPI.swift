//
//  GenericAPI.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import Foundation

protocol GenericAPI {
    var session: URLSession { get }
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
    func post<T: Codable>(type: T.Type, body: T, to request: URLRequest) async throws -> T
    func update<T: Codable, U: Codable>(type: U.Type, body: T, for request: URLRequest) async throws -> U
}

extension GenericAPI {
    func fetch<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Invalid Response")
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            print(error)
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }

    func post<T: Codable>(type: T.Type, body: T, to request: URLRequest) async throws -> T {
        var request = request
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        let data = try encoder.encode(body)
        request.httpBody = data

        let (responseData, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Invalid Response")
        }
        guard httpResponse.statusCode == 201 else { // 201 Created status code
            throw APIError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
        }

        let decoder = JSONDecoder()
        return try decoder.decode(type, from: responseData)
    }
    
    func update<T: Codable, U: Codable>(type: U.Type, body: T, for request: URLRequest) async throws -> U {
           var request = request
           request.httpMethod = "PUT"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           let encoder = JSONEncoder()
           let data = try encoder.encode(body)
           request.httpBody = data

           let (responseData, response) = try await session.data(for: request)
           guard let httpResponse = response as? HTTPURLResponse else {
               throw APIError.requestFailed(description: "Invalid Response")
           }
           guard httpResponse.statusCode == 200 else { // Adjust the status code as needed
               throw APIError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)")
           }

           let decoder = JSONDecoder()
           return try decoder.decode(type, from: responseData)
       }
}
