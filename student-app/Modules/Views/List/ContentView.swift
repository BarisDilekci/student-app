//
//  ContentView.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.students, id: \.tcNumber) { student in
                    NavigationLink(destination: DetailView(student: student)) { // Student nesnesini geçiyoruz
                        HStack {
                            ListCell(name: student.name, tc_number: String(student.tcNumber))
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
            .onAppear {
                Task {
                    await viewModel.fetchAllStudents()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
