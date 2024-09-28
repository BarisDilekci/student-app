//
//  ListCell.swift
//  student-app
//
//  Created by Barış Dilekçi on 28.09.2024.
//

import SwiftUI

struct ListCell: View {
    
    @State var name: String
    @State var tc_number: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                
                Text(tc_number)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer()
        }

    }
}

#Preview {
    ListCell(name: "John Doe", tc_number: "131312")
        .previewLayout(.sizeThatFits)
}
