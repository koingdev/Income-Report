//
//  InputView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct InputView: View {
    @State private var income: String = ""
    @State private var date = Date()
    
    var incomeValue: Double { Double(income) ?? 0 }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("ចំនេញ")
                TextField("$", text: $income)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            DatePicker("📅", selection: $date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .environment(\.locale, Locale(identifier: "khm"))
                .padding()
                .onTapGesture {
                    hideKeyboard()
                }
            
            Button(action: {
                hideKeyboard()
                income = ""
                date = Date()
            }, label: {
                Text("បញ្ចូល")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.bordered)
            .tint(.green)
            .controlSize(.large)
        }
        .padding(20)
            
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
