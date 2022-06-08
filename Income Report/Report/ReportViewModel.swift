//
//  ReportViewModel.swift
//  Income Report
//
//  Created by KoingDev on 8/6/22.
//

import SwiftUI
import RealmSwift

final class ReportViewModel: ObservableObject {
    @Published var startDate = Date().startOfMonth
    @Published var endDate = Date().endOfMonth
    @Published var rielTotal: Double = 0
    @Published var usdTotal: Double = 0
    @Published var listReport: Results<IncomeModel> = IncomeModel.filteredAll(from: Date().startOfMonth, to: Date().endOfMonth)
    
    func fetchAndSumTotal() {
        let start = startDate.startOfDay
        let end = endDate.endOfDay
        listReport = IncomeModel.filteredAll(from: start, to: end)
        rielTotal = listReport.reduce(0) { $0 + $1.rielIncome }
        usdTotal = listReport.reduce(0) { $0 + $1.usdIncome }
    }
}
