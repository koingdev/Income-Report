//
//  IncomeModel.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import Foundation
import RealmSwift

class IncomeModel: Object {
    @Persisted var income: Double
    @Persisted var date: Date
    
    convenience init(income: Double, date: Date) {
        self.init()
        self.income = income
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
    
    static func totalIncome(from start: Date, to end: Date) -> Double {
        do {
            let realm = try Realm()
            return realm
                .objects(IncomeModel.self)
                .filter("date BETWEEN {%@, %@}", start, end)
                .reduce(0) { $0 + $1.income }
        } catch {
            debugPrint("Failed to read db!")
            return 0
        }
    }
}
