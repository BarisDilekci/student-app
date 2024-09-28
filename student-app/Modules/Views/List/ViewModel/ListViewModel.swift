//
//  ListViewModel.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import Foundation

@MainActor
final class ListViewModel: ObservableObject {
    @Published var students: [Student] = []
    @Published var errorMessage: String?

    private let client: Client
    private let networkManager: NetworkManager

    init(client: Client = Client(), networkManager: NetworkManager = NetworkManager(baseUrl: "http://localhost:3000")) {
        self.client = client
        self.networkManager = networkManager
    }
    
    func fetchAllStudents() async {

        guard let url = networkManager.buildURL(urlPath: .getAllStudents) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = NetworkRequest.HTTPMethod.get.rawValue
        
        do {
            let fetchedStudents: [Student] = try await client.fetch(type: [Student].self, with: request)
            students = fetchedStudents
        } catch {
            errorMessage = error.localizedDescription
        }
    }


}

struct ApiResponse: Codable {
    let message: String
    let students: [Student]?
}
