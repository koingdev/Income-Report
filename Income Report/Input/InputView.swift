//
//  InputView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct InputView: View {
    @ObservedObject private var viewModel = InputViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            InputTextField(title: "រៀល", placeholder: "៛", text: $viewModel.rielIncome)
            InputTextField(title: "ដុល្លារ", placeholder: "$", text: $viewModel.usdIncome)
            
            DatePicker("📅", selection: $viewModel.date, displayedComponents: .date)
                .font(.title)
                .environment(\.locale, .khm)
                .padding()
                .onTapGesture {
                    hideKeyboard()
                }
            
            Button(action: {
                hideKeyboard()
                viewModel.submit()
            }, label: {
                Text("បញ្ចូល")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: 54)
            })
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("សូមបញ្ចូលទិន្ន័យឲ្យបានត្រឹមត្រូវ។"),
                    dismissButton: .cancel(Text("OK"))
                )
            }
        }
        .padding(20)
            
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
