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
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = .systemBackground.withAlphaComponent(0.1)
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
