//
//  HomeTabBarView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct HomeTabBarView: View {
    @State var selectedTabIndex: Int
    @Namespace var namespace
    private let itemInfoList: [TabBarItemInfo]
    private let spacing: CGFloat
    private let height: CGFloat
    
    init(
        itemInfoList: [TabBarItemInfo] = TabBarItemInfo.allCases,
        selectedTabIndex: Int = .zero,
        spacing: CGFloat,
        height: CGFloat
    ) {
        self.itemInfoList = itemInfoList
        self.selectedTabIndex = selectedTabIndex
        self.spacing = spacing
        self.height = height
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(itemInfoList.indices, id: \.self) { index in
                let itemInfo = itemInfoList[index]
                TabBarItemView(
                    selectedTabIndex: $selectedTabIndex,
                    namespace: namespace,
                    iconImage: itemInfo.iconImage,
                    titleText: itemInfo.titleText,
                    tabIndex: index
                )
            }
        }
        .background(Color.white)
        .frame(height: height)
    }
}


extension HomeTabBarView {
    fileprivate enum IconPath: String {
        case list = "HomeScene/listIcon"
        case map = "HomeScene/mapIcon"
        
        var string: String {
            return self.rawValue
        }
    }
    
    enum TabBarItemInfo: CaseIterable, Hashable {
        static var allCases: [HomeTabBarView.TabBarItemInfo] = [
            .orderByList(iconPath: IconPath.list.string, title: "리스트로 주문"),
            .orderByMap(iconPath: IconPath.map.string, title: "지도로 주문")
        ]
        
        case orderByList(iconPath: String, title: String)
        case orderByMap(iconPath: String, title: String)
        
        var iconImage: Image {
            switch self {
            case .orderByList(let iconPath, _):
                return Image(iconPath)
            case .orderByMap(let iconPath, _):
                return Image(iconPath)
            }
        }
        
        var titleText: Text {
            switch self {
            case .orderByList(_, let titleText):
                return Text(titleText)
            case .orderByMap(_, let titleText):
                return Text(titleText)
            }
        }
    }
}


extension HomeTabBarView {
    private struct TabBarItemView: View {
        @Binding var selectedTabIndex: Int
        let namespace: Namespace.ID
        let iconImage: Image?
        let titleText: Text
        let tabIndex: Int
        
        var body: some View {
            Button {
                selectedTabIndex = tabIndex
            } label: {
                VStack {
                    Spacer()
                    
                    HStack {
                        iconImage
                        titleText
                    }
                    
                    if selectedTabIndex == tabIndex {
                        Color.black.frame(height: 2)
                            .matchedGeometryEffect(
                                id: "underline",
                                in: namespace.self
                            )
                    } else {
                        Color.clear.frame(height: 2)
                    }
                }
                .animation(.easeOut, value: selectedTabIndex)
            }
            .buttonStyle(.plain)
        }
    }
}


#Preview {
    HomeTabBarView(spacing: 20, height: 40)
}
