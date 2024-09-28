//
//  AddView.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//
import SwiftUI

struct AddView: View {
    @State private var name: String = ""
    @State private var lastName: String = ""
    @State private var tc_number: String = ""
    @State private var birthDate: Date = Date()
    @State private var showDatePicker: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Yeni Öğrenci Ekle")) {
                    TextField("Adı", text: $name)
                    TextField("Soyadı", text: $lastName)
                    TextField("TC Numarası", text: $tc_number)
                        .keyboardType(.numberPad)

                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        HStack {
                            Text("Doğum Tarihi: ")
                                .foregroundStyle(.black)
                            Spacer()
                            Text(birthDate.formattedForDisplay()) // Kullanıcı dostu tarih formatı
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.down")
                        }
                    }
                    .foregroundColor(.blue)

                    if showDatePicker {
                        DatePicker("", selection: $birthDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                    }
                }
                
                Button(action: {
                    Task {
                        await viewModel.addStudent(name: name, lastName: lastName, tcNumber: tc_number, birthDate: birthDate)
                    }
                }) {
                    Text("Öğrenci Ekle")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                if let successMessage = viewModel.successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .font(.caption)
                }
            }
            .navigationTitle("Yeni Öğrenci")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


}

#Preview {
    AddView()
}
