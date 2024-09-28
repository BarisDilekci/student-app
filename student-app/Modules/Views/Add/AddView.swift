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
                            Text("\(formattedDate(birthDate))")
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
                    print("Yeni öğrenci eklendi: \(name) \(lastName), TC: \(tc_number), Doğum Tarihi: \(birthDate)")
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Öğrenci Ekle")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Yeni Öğrenci")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    AddView()
}
