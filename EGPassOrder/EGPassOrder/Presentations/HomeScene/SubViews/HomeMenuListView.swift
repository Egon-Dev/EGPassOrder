//
//  HomeMenuListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/9/24.
//

import SwiftUI

struct HomeMenuListView: View {
    @State var menuItemInfoList: [HomeMenuItemInfo] = HomeMenuItemInfo.defaultItemList

    var body: some View {
        HStack {
            ForEach(menuItemInfoList.indices, id: \.self) { index in
                let itemInfo = menuItemInfoList[index]
                Spacer()

                VStack {
                    itemInfo.iconImage
                    itemInfo.titleText.lineLimit(1)
                }
                .padding(4)
                .background(Color.green)
                .onTapGesture {

                }

                Spacer()
            }
        }
        .background(.cyan)
    }
}


final class HomeMenuItemInfo {
    static let defaultItemList = [
        HomeMenuItemInfo(
            iconImage: Image.homeMenuCouponIcon,
            titleText: Text("쿠폰함").font(.caption),
            destinationView: EmptyView()
        ),
        HomeMenuItemInfo(
            iconImage: Image.homeMenuPointIcon,
            titleText: Text("포인트/스탬프").font(.caption),
            destinationView: EmptyView()
        ),
        HomeMenuItemInfo(
            iconImage: Image.homeMenuNotificationIcon,
            titleText: Text("알림").font(.caption),
            destinationView: EmptyView()
        ),
        HomeMenuItemInfo(
            iconImage: Image.homeMenuMarketIcon,
            titleText: Text("적립마켓").font(.caption),
            destinationView: EmptyView()
        ),
        HomeMenuItemInfo(
            iconImage: Image.homeMenuGiftIcon,
            titleText: Text("선물하기").font(.caption),
            destinationView: EmptyView()
        )
    ]

    let iconImage: Image
    let titleText: Text
    let destinationView: any View

    init(iconImage: Image, titleText: Text, destinationView: any View) {
        self.iconImage = iconImage
        self.titleText = titleText
        self.destinationView = destinationView
    }
}


// MARK: - images
fileprivate extension Image {
    static let homeMenuCouponIcon = Image("HomeScene/homeMenuCouponIcon")
    static let homeMenuPointIcon = Image("HomeScene/homeMenuPointIcon")
    static let homeMenuNotificationIcon = Image("HomeScene/homeMenuNotificationIcon")
    static let homeMenuMarketIcon = Image("HomeScene/homeMenuMarketIcon")
    static let homeMenuGiftIcon = Image("HomeScene/homeMenuGiftIcon")
}


#Preview {
    HomeMenuListView()
}
