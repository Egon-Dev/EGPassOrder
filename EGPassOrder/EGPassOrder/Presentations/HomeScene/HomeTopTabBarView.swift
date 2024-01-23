//
//  HomeTopTabBarView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/22/24.
//

import SwiftUI

struct HomeTopTabBarView: View {
    @Binding var selectedTabIndex: Int
    @Namespace var namespace
    private let itemInfoList: [TabBarItemInfo]
    private let spacing: CGFloat
    private let height: CGFloat

    init(
        itemInfoList: [TabBarItemInfo] = TabBarItemInfo.allCases,
        selectedTabIndex: Binding<Int>,
        spacing: CGFloat,
        height: CGFloat
    ) {
        self.itemInfoList = itemInfoList
        _selectedTabIndex = selectedTabIndex
        self.spacing = spacing
        self.height = height
    }

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(itemInfoList, id: \.id) { itemInfo in
                TabBarItemView(
                    selectedTabIndex: $selectedTabIndex,
                    tabIndex: itemInfo.index,
                    namespace: namespace,
                    iconImage: itemInfo.iconImage,
                    titleText: itemInfo.titleText
                )
            }
        }
        .background(Color.white)
        .frame(height: height)
    }
}


// MARK: - Model: TabBarItemInfo
enum TabBarItemInfo: CaseIterable, Identifiable {
    static var allCases: [TabBarItemInfo] = [
        .orderByList(icon: Image.orderByListIcon, title: Text.orderByListTitle),
        .orderByMap(icon: Image.orderByMapIcon, title: Text.orderByMapTitle)
    ]

    case orderByList(icon: Image, title: Text)
    case orderByMap(icon: Image, title: Text)

    var id: Int {
        switch self {
        case .orderByList:
            return Int.orderByListID
        case .orderByMap:
            return Int.orderByMapID
        }
    }

    var index: Int {
        switch self {
        case .orderByList:
            return Int.orderByListID
        case .orderByMap:
            return Int.orderByMapID
        }
    }

    var iconImage: Image {
        switch self {
        case .orderByList(let iconImage, _):
            return iconImage
        case .orderByMap(let iconImage, _):
            return iconImage
        }
    }

    var titleText: Text {
        switch self {
        case .orderByList(_, let titleText):
            return titleText
        case .orderByMap(_, let titleText):
            return titleText
        }
    }
}


// MARK: - Subview: TabBarItemView
private struct TabBarItemView: View {
    @Binding var selectedTabIndex: Int
    let tabIndex: Int
    let namespace: Namespace.ID
    let iconImage: Image?
    let titleText: Text

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
                    Color.black
                        .frame(height: CGFloat.tabIndicatorHeight)
                        .matchedGeometryEffect(
                            id: String.underlineEffectID,
                            in: namespace.self
                        )
                } else {
                    Color.clear.frame(height: CGFloat.tabIndicatorHeight)
                }
            }
            .animation(.easeOut, value: selectedTabIndex)
        }
        .buttonStyle(.plain)
    }
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let tabIndicatorHeight = CGFloat(2)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let tabTitleBlack = Color.black
}


// MARK: - Extension: Image
fileprivate extension Image {
    // Icons
    static let orderByMapIcon = Image("HomeScene/MapIcon")
    static let orderByListIcon = Image("HomeScene/listIcon")
}


// MARK: - Extension Int
fileprivate extension Int {
    static let orderByListID = Int.zero
    static let orderByMapID = Int(1)
}


// MARK: - Extension: String
fileprivate extension String {
    static let underlineEffectID: String = "underline"
}


// MARK; - Extension: Text
fileprivate extension Text {
    static let orderByListTitle = Text("리스트로 주문").foregroundStyle(Color.tabTitleBlack)
    static let orderByMapTitle = Text("지도로 주문").foregroundStyle(Color.tabTitleBlack)
}


#Preview {
    HomeTopTabBarView(selectedTabIndex: .constant(1), spacing: 20, height: 40)
}
