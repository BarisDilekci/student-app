//
//  ContentView.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    @State private var isPresentingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.students, id: \.tcNumber) { student in
                    NavigationLink(destination: DetailView(student: student)) {
                        HStack {
                            ListCell(name: student.name, lastname: student.lastname, tc_number: String(student.tcNumber))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteStudent(student)
                        } label: {
                            Label("Sil", systemImage: "trash")
                        }
                        
                        Button {
                            updateStudent(student)
                        } label: {
                            Label("Güncelle", systemImage: "pencil")
                        }
                    }
                }
            }
            .navigationTitle("Öğrenciler")
            .navigationBarItems(trailing: Button(action: {
                isPresentingAddView.toggle()
            }) {
                Text("Ekle")
            })
            .onAppear {
                Task {
                    await viewModel.fetchAllStudents()
                }
            }
            .sheet(isPresented: $isPresentingAddView) {
                AddView()
            }
        }
    }

    private func deleteStudent(_ student: Student) {

    }

    private func updateStudent(_ student: Student) {

    }
}

#Preview {
    ListView()
}
