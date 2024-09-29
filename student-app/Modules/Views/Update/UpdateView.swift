//
//  UpdateView.swift
//  student-app
//
//  Created by Barış Dilekçi on 29.09.2024.
//

import SwiftUI

struct UpdateView: View {
    var student: Student
    @State private var name: String
    @State private var lastName: String
    @State private var tc_number: String
    @State private var birthDate: Date
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = UpdateViewModel()
    @State private var showWarning = false

    init(student: Student) {
        self.student = student
        _name = State(initialValue: student.name)
        _lastName = State(initialValue: student.lastname)
        _tc_number = State(initialValue: String(student.tcNumber))
        _birthDate = State(initialValue: DateFormatter().date(from: student.dateOfBirth) ?? Date())
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Öğrenciyi Güncelle")) {
                    TextField("Adı", text: $name)
                    TextField("Soyadı", text: $lastName)

                    HStack {
                        Text("TC Numarası:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(tc_number)
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Doğum Tarihi:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(birthDate.formattedForDisplay())
                            .foregroundStyle(.secondary)
                    }
                }
                
                Button(action: {
                    Task {
                        await viewModel.updateStudent(
                            tcNumber: String(student.tcNumber),
                            name: name,
                            lastName: lastName,
                            birthDate: student.dateOfBirth
                        )
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Güncelle")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }

                if showWarning {
                    HStack {
                        Button(action: {
                            showWarning.toggle()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                        Text("TC kimlik numarası ve doğum tarihi buradan değiştirilemiyor. Lütfen okulunza danışın.")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Öğrenciyi Güncelle")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                showWarning = true 
            }
        }
    }
}

#Preview {
    let sampleStudent = Student(name: "Ali", lastname: "Veli", tcNumber: 12345678901, dateOfBirth: "2000-01-01")
    UpdateView(student: sampleStudent)
}
 
