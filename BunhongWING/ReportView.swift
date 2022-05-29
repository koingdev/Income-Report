//
//  ReportView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct ReportView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var total: Double = 0
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            DatePicker("ចាប់ពី", selection: $startDate, displayedComponents: .date)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: startDate) { _ in
                    sumTotal()
                }

            DatePicker("ដល់", selection: $endDate, displayedComponents: .date)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: endDate) { _ in
                    sumTotal()
                }
            
            HStack {
                Text("សរុប")
                    .font(.largeTitle.bold())
                    .padding()
                Spacer()
                Text("\(total, specifier: "%.2f")")
                    .font(.largeTitle.bold())
                    .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        }
        .onAppear {
            sumTotal()
        }
    }
    
    private func sumTotal() {
        total = IncomeModel.totalIncome(from: startDate.startOfDay, to: endDate.endOfDay)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
