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
    
    private var incomeValue: Double { Double(income) ?? 0 }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("ចំនេញ")
                TextField("$", text: $income)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            DatePicker("📅", selection: $date, displayedComponents: .date)
                .environment(\.locale, .khm)
                .padding()
                .onTapGesture {
                    hideKeyboard()
                }
            
            Button(action: {
                hideKeyboard()
                // add to db
                IncomeModel(income: incomeValue, date: date).add()
                // reset
                income = ""
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
