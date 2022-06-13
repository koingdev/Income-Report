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
                .font(.title3)
                .environment(\.locale, .khm)
                .padding()
                .onChange(of: viewModel.startDate) { _ in
                    viewModel.fetchAndSumTotalIfUnlocked()
                }

            DatePicker("ដល់", selection: $viewModel.endDate, displayedComponents: .date)
                .font(.title3)
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
            
            if viewModel.incomes.isEmpty {
                Text("គ្មានទិន្នន័យចន្លោះពេលនេះ")
                    .font(.title3)
                    .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.incomes) { income in
                        HStack {
                            Text(income.date?.formattedString ?? "")
                                .font(.title3)
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(income.rielIncome.stringWithoutZeroFraction)៛")
                                    .font(.title2)
                                     Text("\(income.usdIncome.stringWithoutZeroFraction)$")
                                    .font(.title2)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        guard let index = indexSet.first else { return }
                        CoreDataCloudKitService.delete(income: viewModel.incomes[index])
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
