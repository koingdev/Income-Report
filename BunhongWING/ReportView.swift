//
//  ReportView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct ReportView: View {
    @State var datasources = [Income(income: 10, date: Date())]
    var body: some View {
        VStack {
            List(datasources, id: \.id) { data in
                HStack {
                    Text("\(data.income)$")
                    Spacer()
                    Text(data.date.description)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
