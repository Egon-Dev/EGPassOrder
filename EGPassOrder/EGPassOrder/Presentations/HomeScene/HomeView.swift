//
//  HomeView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/15/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var isMainTabBarVisible: Bool
    @State var selectedTabIndex: Int = .zero

    var body: some View {
        VStack {
            if selectedTabIndex == .zero {
                OrderByListView()
                    .onAppear {
                        isMainTabBarVisible = true
                    }
            } else {
                OrderByMapView()
                    .onAppear {
                        isMainTabBarVisible = false
                    }
                    .ignoresSafeArea(edges: .bottom)
            }

            Spacer()
        }
    }
}


// MARK: - Subview: OrderByListView
fileprivate struct OrderByListView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                // FIXME: - Remove Dummy
                PromotionPageTabView(
                    pageList: Image.dummyImageList
                        .enumerated()
                        .map { index, image in
                            PromotionPage(pageImage: image, destinationView: Text("ImageIndex: \(index)"))
                    },
                    height: 120
                )
                .padding()
            }
        }
    }
}


// MARK: - Subview: OrderByMapView
fileprivate struct OrderByMapView: View {
    var body: some View {
        EmptyView()
    }
}



// MARK: - PREVIEW
#Preview {
    HomeView(isMainTabBarVisible: .constant(true))
}
