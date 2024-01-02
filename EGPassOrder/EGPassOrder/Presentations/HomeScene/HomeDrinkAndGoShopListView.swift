//
//  HomeDrinkAndGoShopListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct HomeDrinkAndGoShopListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HomeDrinkAndGoShopTitleView()
            HomeDrinkAndGoShopScrollView()
            HomeDrinkAndGoShopAccessaryView()
        }
    }
}


private struct HomeDrinkAndGoShopTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("게스트님 근처에")
                Text("판매중인 적립이 있는 매장")
                    .foregroundStyle(Color.drinkAndGoShopListBlue)
                    .fontWeight(.bold)
                + Text("이에요!")
            }

            Spacer()
        }
    }
}


private struct HomeDrinkAndGoShopScrollView: View {
    let rows: [GridItem] = [
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem()
    ]

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem()], spacing: 20) {
                    ForEach(rows.indices, id: \.self) { item in
                        LargeShopListCell()
                    }
                }
            }
        }
    }
}


private struct HomeDrinkAndGoShopAccessaryView: View {
    var body: some View {
        HStack {
            Spacer()
            Button("더보기", action: {

            })
        }
    }
}


// MARK: - Colors
fileprivate extension Color {
    static let drinkAndGoShopListBlue = Color("HomeScene/orange")
}

#Preview {
    HomeDrinkAndGoShopListView()
}
