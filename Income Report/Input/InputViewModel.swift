//
//  InputViewModel.swift
//  Income Report
//
//  Created by KoingDev on 8/6/22.
//

import Foundation
import SwiftUI

final class InputViewModel: ObservableObject {
    @Published var rielIncome: String = ""
    @Published var usdIncome: String = ""
    @Published var date = Date()
    @Published var showingAlert = false
    
    var rielValue: Double { Double(rielIncome) ?? 0 }
    var usdValue: Double { Double(usdIncome) ?? 0 }
    
    func isValid() -> Bool {
        if rielValue <= 0 && usdValue <= 0 { return false }
        return true
    }
    
    func submit() {
        // validate
        guard isValid() else { showingAlert = true; return }
        // add to db
        IncomeModel(rielIncome: rielValue, usdIncome: usdValue, date: date).add()
        // reset
        rielIncome = ""
        usdIncome = ""
        date = Date()
    }
}
