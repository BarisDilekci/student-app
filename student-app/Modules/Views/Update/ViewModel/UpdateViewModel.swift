//
//  UpdateViewModel.swift
//  student-app
//
//  Created by Barış Dilekçi on 29.09.2024.
//

import Foundation

@MainActor
final class UpdateViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?

    private let client: Client
    private let networkManager: NetworkManager

    init(client: Client = Client(), networkManager: NetworkManager = NetworkManager(baseUrl: "http://localhost:3000")) {
        self.client = client
        self.networkManager = networkManager
    }

    func updateStudent(tcNumber: String, name: String, lastName: String, birthDate: String) async {
        let updatedStudent = Student(
            name: name, 
            lastname: lastName,
            tcNumber: Int(tcNumber) ?? 0,
            dateOfBirth: birthDate
        )

        guard let url = networkManager.buildURL(urlPath: .updateStudent(tcNumber: tcNumber)) else { return }
        var request = URLRequest(url: url)

        do {
            let response: Student = try await client.update(type: Student.self, body: updatedStudent, for: request)
            successMessage = "Öğrenci güncellendi: \(response.name) \(response.lastname)"
        } catch {
            errorMessage = error.localizedDescription
        }
    }



}
