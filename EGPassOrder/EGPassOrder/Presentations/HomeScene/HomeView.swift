//
//  HomeView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HomeTabBarView(spacing: 20, height: 40)
                HomePromotionPageView()
                    .frame(height: 100)
                HomeNearbyShopListView()
                // HomePointShopListView()
                // HomePassOrderAdView()
                // HomeDrinkAndGoShopListView()
                // HomeNewShopListView()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
