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
                            ListCell(name: student.name, tc_number: String(student.tcNumber))
                                .frame(maxWidth: .infinity, alignment: .leading)
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
}

#Preview {
    ListView()
}

