//
//  MainTabView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTabIndex: Int = 0
    private let tabItemList: [TabItem]
    
    init(tabItemList: [TabItem]) {
        self.tabItemList = tabItemList
    }
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            ForEach(tabItemList.indices, id: \.self) { index in
                let tabItem = tabItemList[index]
                AnyView(tabItem.view)
                    .tabItem {
                        tabItem.iconImage
                        tabItem.titleText
                    }
            }
        }
    }
}


// MARK: - TabItem
extension MainTabView {
    struct TabItem {
        let view: any View
        let iconImage: Image?
        let titleText: Text
    }
}


#Preview {
    MainTabView(tabItemList: [
        MainTabView.TabItem(
            view: Text("홈1 Tab"),
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
