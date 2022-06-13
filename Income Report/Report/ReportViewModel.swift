//
//  ReportViewModel.swift
//  Income Report
//
//  Created by KoingDev on 8/6/22.
//

import SwiftUI

final class ReportViewModel: ObservableObject {
    @Published var startDate = Date().startOfMonth
    @Published var endDate = Date().endOfMonth
    @Published var rielTotal: Double = 0
    @Published var usdTotal: Double = 0
    @Published var isUnlocked = false
    @Published var incomes: [Income] = []
    private var fetchRequest = Income.fetchRequest()
    
    private func fetchAndSumTotal() {
        let start = startDate.startOfDay
        let end = endDate.endOfDay
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Income.date, ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", start as CVarArg, end as CVarArg)
        incomes = CoreDataCloudKitService.fetch(fetchRequest)
        rielTotal = incomes.reduce(0) { $0 + $1.rielIncome }
        usdTotal = incomes.reduce(0) { $0 + $1.usdIncome }
    }
    
    func fetchAndSumTotalIfUnlocked() {
        if isUnlocked {
            fetchAndSumTotal()
        } else {
            Task { @MainActor in
                isUnlocked = await Authentication.start()
                if isUnlocked {
                    fetchAndSumTotal()
                }
            }
        }
    }
}
