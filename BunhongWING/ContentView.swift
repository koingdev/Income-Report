//
//  ContentView.swift
//  BunhongWING
//
//  Created by KoingDev on 29/5/22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView: View {
    var body: some View {
        TabView {
            InputView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("បញ្ចូលចំណូល")
                        .font(.largeTitle)
                }
            
            Text("Home Tab")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("របាយការណ៍")
                        .font(.largeTitle)
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
