//
//  AddViewModel.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//
import Foundation

@MainActor
final class AddViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?

    private let client: Client
    private let networkManager: NetworkManager

    init(client: Client = Client(), networkManager: NetworkManager = NetworkManager(baseUrl: "http://localhost:3000/students")) {
        self.client = client
        self.networkManager = networkManager
    }

    func addStudent(name: String, lastName: String, tcNumber: String, birthDate: Date) async {
        let newStudent = Student(name: name, lastname: lastName, tcNumber: Int(tcNumber) ?? 0, dateOfBirth: birthDate.formattedForAPI())
        
        guard let url = networkManager.buildURL(urlPath: .addStudent) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = NetworkRequest.HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let response: Student = try await client.post(type: Student.self, body: newStudent, to: request)
            successMessage = "Yeni öğrenci eklendi: \(response.name) \(response.lastname)"
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
