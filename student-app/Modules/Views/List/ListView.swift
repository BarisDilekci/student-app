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
    @State private var studentToUpdate: Student?

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.students.isEmpty {
                    Text("Henüz öğrenci yok. Lütfen ekleyin.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.students) { student in // Identifiable ile doğrudan kullanabilirsiniz
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
            .sheet(item: $studentToUpdate) { student in
                UpdateView(student: student)
            }
        }
    }

    private func deleteStudent(_ student: Student) {
        Task {
            await viewModel.deleteStudent(tcNumber: String(student.tcNumber))
        }
    }

    private func updateStudent(_ student: Student) {
        studentToUpdate = student // Güncellenecek öğrenciyi ayarla
    }
}

#Preview {
    ListView()
}
