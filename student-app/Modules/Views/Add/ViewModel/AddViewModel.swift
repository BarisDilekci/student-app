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
    
    private let client: Client
    private let networkManager: NetworkManager

    init(client: Client = Client(), networkManager: NetworkManager = NetworkManager(baseUrl: "http://localhost:3000")) {
        self.client = client
        self.networkManager = networkManager
    }

    func addStudent(name: String, lastName: String, tcNumber: String, birthDate: Date) async {
        let dateOfBirthString = formattedDate(birthDate)
        let newStudent = Student(name: name, lastname: lastName, tcNumber: Int(tcNumber) ?? 0, dateOfBirth: dateOfBirthString)
        
        guard let url = networkManager.buildURL(urlPath: .addStudent) else {
            errorMessage = "Geçersiz URL."
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = NetworkRequest.HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let response: Student = try await client.post(type: Student.self, body: newStudent, to: request)
            print("Yeni öğrenci eklendi: \(response)")
            errorMessage = nil // Başarılı olursa hata mesajını sıfırla
        } catch {
            errorMessage = error.localizedDescription
            print("Hata: \(error.localizedDescription)") // Hata mesajını konsola yazdır
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // API'nin beklediği format
        return formatter.string(from: date)
    }
}
