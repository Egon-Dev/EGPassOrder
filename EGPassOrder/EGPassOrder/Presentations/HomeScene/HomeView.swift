//
//  HomeView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HomeTabBarView(spacing: 20, height: 40)
                    .padding()
                HomePromotionPageView()
                    .frame(height: 100)
                    .padding()
                HomeNearbyShopListView()
                HomePointShopListView()
                HomePassOrderAdView()
                HomeStoryShopListView()
                HomeDrinkAndGoShopListView()
                HomeNewShopListView()
            }
        }
    }
}

#Preview {
    HomeView()
}
