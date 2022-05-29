//
//  IncomeModel.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import Foundation
import RealmSwift

class IncomeModel: Object {
    @Persisted var rielIncome: Double
    @Persisted var usdIncome: Double
    @Persisted var date: Date
    
    convenience init(rielIncome: Double, usdIncome: Double, date: Date) {
        self.init()
        self.rielIncome = rielIncome
        self.usdIncome = usdIncome
        self.date = date
    }
    
    func add() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch {
            debugPrint("Failed to add to db!")
        }
    }
    
    static func totalRielIncome(from start: Date, to end: Date) -> Double {
        do {
            let realm = try Realm()
            return realm
                .objects(IncomeModel.self)
                .filter("date BETWEEN {%@, %@}", start, end)
                .reduce(0) { $0 + $1.rielIncome }
        } catch {
            debugPrint("Failed to read db!")
            return 0
        }
    }
    
    static func totalUsdIncome(from start: Date, to end: Date) -> Double {
        do {
            let realm = try Realm()
            return realm
                .objects(IncomeModel.self)
                .filter("date BETWEEN {%@, %@}", start, end)
                .reduce(0) { $0 + $1.usdIncome }
        } catch {
            debugPrint("Failed to read db!")
            return 0
        }
    }
}
