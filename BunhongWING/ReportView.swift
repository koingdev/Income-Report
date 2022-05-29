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
    @State private var rielTotal: Double = 0
    @State private var usdTotal: Double = 0
    
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
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
                
                VStack {
                    Text("\(rielTotal, specifier: "%.2f")៛")
                        .font(.largeTitle.bold())
                    Text("\(usdTotal, specifier: "%.2f")$")
                        .font(.largeTitle.bold())
                        
                }.padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        }
        .onAppear {
            sumTotal()
        }
    }
    
    private func sumTotal() {
        let start = startDate.startOfDay
        let end = endDate.endOfDay
        rielTotal = IncomeModel.totalRielIncome(from: start, to: end)
        usdTotal = IncomeModel.totalUsdIncome(from: start, to: end)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
