//
//  FavoriteCafeView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/9/24.
//

import SwiftUI

struct FavoriteCafeView: View {
    @State var protomotionImages: [Image]

    var body: some View {
        VStack {
            TitleView()
            PromotionPageView(imageList: [Image(systemName: "1.fill")], height: 100)
            FavoriteCafeTitleView()
            FavoriteCafeContentView()

            Spacer()
        }
    }
}


private struct TitleView: View {
    var body: some View {
        HStack {
            Text("자주가요")
                .font(.title)
                .fontWeight(.bold)

            Spacer()
        }
    }
}


private struct FavoriteCafeTitleView: View {
    var body: some View {
        HStack {
            Text("패써님이 자주가는 매장이에요!")
                .font(.headline)

            Spacer()
        }
    }
}


private struct FavoriteCafeContentView: View {
    // @State private var favoriteCafe: CafeInfo

    var body: some View {
        VStack {

        }
    }
}


#Preview {
    FavoriteCafeView(protomotionImages: [])
}
