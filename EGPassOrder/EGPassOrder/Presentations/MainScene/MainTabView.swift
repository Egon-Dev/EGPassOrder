//
//  MainTabView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTabIndex: Int = 0
    @State var isTabBarHidden: Bool = false
    private let tabItemList: [TabItem]
    
    init(tabItemList: [TabItem]) {
        self.tabItemList = tabItemList
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTabIndex) {
                ForEach(tabItemList.indices, id: \.self) { index in
                    let tabItem = tabItemList[index]

                    if tabItem.view is HomeView {
                        AnyView(HomeView(isTabBarHidden: $isTabBarHidden))
                            .tag(index)
                    } else {
                        AnyView(tabItem.view)
                            .tag(index)
                    }
                }
            }
            
            if isTabBarHidden == false {
                TabBarView(
                    selectedTabIndex: $selectedTabIndex,
                    tabItemList: tabItemList
                )
            }
        }
    }
}


extension MainTabView {
    private struct TabBarView: View {
        @Binding var selectedTabIndex: Int
        let tabItemList: [TabItem]

        var body: some View {
            GeometryReader { proxy in
                HStack(alignment: .top) {
                    ForEach(tabItemList.indices, id: \.self) { index in
                        let tabItem = tabItemList[index]

                        Button {
                            selectedTabIndex = index
                        } label: {
                            VStack(spacing: 10) {
                                tabItem.iconImage
                                tabItem.titleText
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(.cyan)
            }
            .background(.red)
            .frame(height: 52)
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
