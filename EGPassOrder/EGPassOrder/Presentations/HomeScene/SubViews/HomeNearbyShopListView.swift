//
//  HomeNearbyShopListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct HomeNearbyShopListView: View {
    @State private var isPhoneOrderShop: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            HomeNearbyShopListTitleView(isPhoneOrderShop: $isPhoneOrderShop)
            HomeNearbyShopListScrollView()
            HomeNearbyShopListAccessaryView()
                .padding()
        }
    }
}


private struct HomeNearbyShopListTitleView: View {
    @Binding var isPhoneOrderShop: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("게스트님과")
                    Text("가까이 있는 매장")
                        .foregroundStyle(Color.nearbyShopListOrange)
                        .fontWeight(.bold)
                    + Text("이에요!")
                }

                Spacer()

                Image.passbadgeIcon
            }

            HStack {
                Text("전화주문 매장 보기")
                Toggle("", isOn: $isPhoneOrderShop)
                    .tint(Color.nearbyShopListOrange)
                    .labelsHidden()
                Spacer()
            }
        }
    }
}


private struct HomeNearbyShopListScrollView: View {
    let rows: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem()], alignment:.top ,spacing: 20) {
                    ForEach(rows.indices, id: \.self) { item in
                        LargeShopListCell(imageWidth: proxy.size.width * 0.5)
                    }
                }
            }
        }
        .frame(height: 400)
    }
}

private struct HomeNearbyShopListAccessaryView: View {
    var body: some View {
        HStack {
            Spacer()
            Button("더보기", action: {

            })
        }
    }
}


// MARK: - Images
fileprivate extension Image {
    static let passbadgeIcon = Image("HomeScene/passbadgeIcon")
}


// MARK: - Colors
fileprivate extension Color {
    static let nearbyShopListOrange = Color("HomeScene/orange")
}

#Preview {
    HomeNearbyShopListView()
}
