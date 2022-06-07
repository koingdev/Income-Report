//
//  ReportView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI
import RealmSwift

struct ReportView: View {
    @State private var startDate = Date().startOfMonth
    @State private var endDate = Date().endOfMonth
    @State private var rielTotal: Double = 0
    @State private var usdTotal: Double = 0
    
    @State private var listReport: Results<IncomeModel> = IncomeModel.filteredAll(from: Date().startOfMonth, to: Date().endOfMonth)
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            DatePicker("ចាប់ពី", selection: $startDate, displayedComponents: .date)
                .font(.title)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: startDate) { _ in
                    fetchAndSumTotal()
                }

            DatePicker("ដល់", selection: $endDate, displayedComponents: .date)
                .font(.title)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: endDate) { _ in
                    fetchAndSumTotal()
                }
            
            HStack {
                Text("សរុប")
                    .font(.title)
                    .padding()
                Spacer()
                
                VStack {
                    Text("\(rielTotal.stringWithoutZeroFraction)៛")
                        .font(.largeTitle.bold())
                    Text("\(usdTotal.stringWithoutZeroFraction)$")
                        .font(.largeTitle.bold())
                        
                }.padding()
                
            }
            
            if listReport.isEmpty {
                Text("គ្មានទិន្នន័យចន្លោះពេលនេះ")
                    .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(listReport.freeze()) { report in
                        HStack {
                            Text(report.date.formattedString)
                                .font(.title3)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(report.rielIncome.stringWithoutZeroFraction)៛")
                                    .font(.title2)
                                     Text("\(report.usdIncome.stringWithoutZeroFraction)$")
                                    .font(.title2)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        guard let index = indexSet.first else { return }
                        listReport[index].delete()
                        fetchAndSumTotal()
                    }
                }
            }
        }
        .onAppear {
            fetchAndSumTotal()
        }
    }
    
    private func fetchAndSumTotal() {
        let start = startDate.startOfDay
        let end = endDate.endOfDay
        listReport = IncomeModel.filteredAll(from: start, to: end)
        rielTotal = listReport.reduce(0) { $0 + $1.rielIncome }
        usdTotal = listReport.reduce(0) { $0 + $1.usdIncome }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
