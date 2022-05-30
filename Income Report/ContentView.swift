//
//  ContentView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            InputView()
                .tabItem {
                    Label("បញ្ចូលចំណូល", systemImage: "dollarsign.circle")
                }
            
            ReportView()
                .tabItem {
                    Label("របាយការណ៍", systemImage: "doc.circle")
                }

        }
        .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
