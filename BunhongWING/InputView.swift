//
//  InputView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct InputView: View {
    @State private var rielIncome: String = ""
    @State private var usdIncome: String = ""
    @State private var date = Date()
    @State private var showingAlert = false
    
    private var rielValue: Double { Double(rielIncome) ?? 0 }
    private var usdValue: Double { Double(usdIncome) ?? 0 }
    
    private var isValid: Bool {
        if rielValue <= 0 && usdValue <= 0 { return false }
        return true
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("រៀល")
                TextField("៛", text: $rielIncome)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
            }.padding()
            
            HStack {
                Text("ដុល្លារ")
                TextField("$", text: $usdIncome)
                    .keyboardType(.decimalPad)
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
                // validate
                guard isValid else { showingAlert = true; return }
                // add to db
                IncomeModel(rielIncome: rielValue, usdIncome: usdValue, date: date).add()
                // reset
                rielIncome = ""
                usdIncome = ""
            }, label: {
                Text("បញ្ចូល")
                    .frame(maxWidth: .infinity)
            })
            .alert("សូមបញ្ចូលទិន្ន័យឲ្យបានត្រឹមត្រូវ។", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
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
