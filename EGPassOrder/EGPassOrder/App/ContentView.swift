//
//  ContentView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView(tabItemList: [
            MainTabView.TabItem(
                view: HomeView(isTabBarHidden: .constant(true)),
                iconImage: Image(systemName: "1.square.fill"),
                titleText: Text("홈1")
            ),
            MainTabView.TabItem(
                view: Text("홈2 Tab"),
                iconImage: Image(systemName: "2.square.fill"),
                titleText: Text("홈2")
            ),
            MainTabView.TabItem(
                view: Text("홈3 Tab"),
                iconImage: Image(systemName: "3.square.fill"),
                titleText: Text("홈3")
            ),
            MainTabView.TabItem(
                view: Text("홈4 Tab"),
                iconImage: Image(systemName: "4.square.fill"),
                titleText: Text("홈4")
            ),
            MainTabView.TabItem(
                view: Text("홈5 Tab"),
                iconImage: Image(systemName: "5.square.fill"),
                titleText: Text("홈5")
            )
        ])
    }
}

#Preview {
    ContentView()
}
