//
//  ReportView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject private var viewModel = ReportViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            DatePicker("ចាប់ពី", selection: $viewModel.startDate, displayedComponents: .date)
                .font(.title)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: viewModel.startDate) { _ in
                    viewModel.fetchAndSumTotalIfUnlocked()
                }

            DatePicker("ដល់", selection: $viewModel.endDate, displayedComponents: .date)
                .font(.title)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: viewModel.endDate) { _ in
                    viewModel.fetchAndSumTotalIfUnlocked()
                }
            
            HStack {
                Text("សរុប")
                    .font(.title)
                    .padding()
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(viewModel.rielTotal.stringWithoutZeroFraction)៛")
                        .font(.largeTitle.bold())
                    Text("\(viewModel.usdTotal.stringWithoutZeroFraction)$")
                        .font(.largeTitle.bold())
                        
                }.padding()
                
            }
            
            if viewModel.listReport.isEmpty {
                Text("គ្មានទិន្នន័យចន្លោះពេលនេះ")
                    .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.listReport.freeze()) { report in
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
                        viewModel.listReport[index].delete()
                        viewModel.fetchAndSumTotalIfUnlocked()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchAndSumTotalIfUnlocked()
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
