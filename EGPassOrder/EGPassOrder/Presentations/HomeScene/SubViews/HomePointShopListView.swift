//
//  HomePointShopListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct HomePointShopListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HomePointShopTitleView()
            HomePointShopScrollView()
            HomePointShopAccessaryView()
                .padding()
        }
    }
}


private struct HomePointShopTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("게스트님 근처에")
                Text("판매중인 적립이 있는 매장")
                    .foregroundStyle(Color.pointShopListBlue)
                    .fontWeight(.bold)
                + Text("이에요!")
            }

            Spacer()
        }
    }
}


private struct HomePointShopScrollView: View {
    let rows: [GridItem] = [
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem()
    ]

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 10) {
                    ForEach(rows.indices, id: \.self) { item in
                        SmallShopListCell()
                    }
                }
            }
        }
        .frame(height: 320)
    }
}


private struct HomePointShopAccessaryView: View {
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
    static let pointShopListBlue = Color("HomeScene/orange")
}


#Preview {
    HomePointShopListView()
}
