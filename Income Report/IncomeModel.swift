//
//  IncomeModel.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import Foundation
import RealmSwift

class IncomeModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
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
    
    func delete() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(self)
            }
        } catch {
            debugPrint("Failed to add to db!")
        }
    }
    
    static func all() -> Results<IncomeModel> {
        let realm = try! Realm()
        return realm.objects(IncomeModel.self)
    }
    
    static func filteredAll(from start: Date, to end: Date) -> Results<IncomeModel> {
        return all()
            .filter("date BETWEEN {%@, %@}", start, end)
            .sorted(by: \.date, ascending: false)
    }
}
