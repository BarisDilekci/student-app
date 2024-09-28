//
//  ContentView.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    let users = [
        (name: "John Doe", lastName: "Doe", tc_number: "12345678901", birthDate: Date(timeIntervalSince1970: 0)), // 1 Ocak 1970
        (name: "Jane Smith", lastName: "Smith", tc_number: "10987654321", birthDate: Date(timeIntervalSince1970: 315532800)), // 1 Ocak 1980
        (name: "Alice Johnson", lastName: "Johnson", tc_number: "98765432101", birthDate: Date(timeIntervalSince1970: 631152000)), // 1 Ocak 1990
        (name: "Bob Brown", lastName: "Brown", tc_number: "45678901234", birthDate: Date(timeIntervalSince1970: 915148800)) // 1 Ocak 2000
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.tc_number) { user in
                    NavigationLink(destination: DetailView(user: user)) {
                        HStack {
                            ListCell(name: user.name, tc_number: user.tc_number)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .navigationTitle("Öğrenciler")
            .navigationBarItems(trailing: Button(action: {
                print("Ekle butonuna basıldı!")
            }) {
                Text("Ekle")
            })
        }
    }
}

#Preview {
    ContentView()
}
