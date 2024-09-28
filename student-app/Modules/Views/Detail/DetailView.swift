//
//  DetailView.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import SwiftUI

struct DetailView: View {
    var student: Student

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Öğrenci Bilgileri").font(.headline)) {
                    HStack {
                        Text("Ad:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(student.name)
                    }
                    
                    HStack {
                        Text("Soyad:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(student.lastname)
                    }
                    
                    HStack {
                        Text("TC Numarası:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(String(student.tcNumber))
                    }
                    
                    HStack {
                        Text("Doğum Tarihi:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(formattedDate(student.dateOfBirth)) // String'den Date'e çevirip formatlıyoruz
                    }
                }
            }
            .navigationTitle("Detaylar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func formattedDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Gelen tarih formatı
        
        if let date = formatter.date(from: dateString) {
            return date.formattedForDisplay() // Uzantıyı kullan
        }
        
        return dateString // Dönüşüm başarısızsa orijinal string'i döndür
    }
}
