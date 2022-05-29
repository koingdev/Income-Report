//
//  Helper.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import Foundation
import UIKit
import SwiftUI

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

extension Locale {
    static let khm = Locale(identifier: "khm")
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
