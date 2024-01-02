//
//  HomeView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HomeTabBarView(spacing: 20, height: 40)
            HomePromotionPageView()
                .frame(height: 100)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
