//
//  DetailView.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import SwiftUI

struct DetailView: View {
    var user: (name: String, lastName: String, tc_number: String, birthDate: Date)
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Öğrenci Bilgileri").font(.headline)) {
                    HStack {
                        Text("Ad:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.name)
                    }
                    
                    HStack {
                        Text("Soyad:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.lastName)
                    }
                    
                    HStack {
                        Text("TC Numarası:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.tc_number)
                    }
                    
                    HStack {
                        Text("Doğum Tarihi:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(formattedDate(user.birthDate))
                    }
                }
            }
            .navigationTitle("Detaylar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Tarih formatlama fonksiyonu
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Tarih stilini orta boyda ayarla
        return formatter.string(from: date)
    }
}

#Preview {
    DetailView(user: (name: "John", lastName: "Doe", tc_number: "12345678901", birthDate: Date()))
}
