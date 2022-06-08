//
//  InputTextField.swift
//  Income Report
//
//  Created by KoingDev on 8/6/22.
//

import SwiftUI

struct InputTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .frame(maxWidth: 100, alignment: .leading)
            TextField(placeholder, text: $text)
                .font(.title)
                .keyboardType(.numbersAndPunctuation)
                .textFieldStyle(.roundedBorder)
        }.padding()
    }
}
