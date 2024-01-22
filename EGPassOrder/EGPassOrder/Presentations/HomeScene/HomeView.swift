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
        NavigationStack {
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
}


// MARK: - Subview: OrderByListView
fileprivate struct OrderByListView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: CGFloat.subviewVerticalSpacing) {
                PromotionPageTabView(
                    pageList: Image.dummyImageList
                        .enumerated()
                        .map { index, image in
                            // FIXME: - Remove Dummy
                            PromotionPage(
                                pageImage: image,
                                destinationView: Text("ImageIndex: \(index)")
                            )
                    },
                    height: CGFloat.promotionPageTabViewHeight

                )
                .padding()

                NearbyCafeListView()

                PointCafeListView()

                AutoChangeAdvertiseView(
                    pageList: [Text("1"), Text("2"), Text("3")],
                    height: 120,
                    timerInterval: 2.0
                )
                .padding()

                StoryCafeListView()

                DineInCafeListView()

                NewCafeListView()
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


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let subviewVerticalSpacing = CGFloat(20)
    static let promotionPageTabViewHeight = CGFloat(120)
    static let autoChangeAdvertiseViewHeight = CGFloat(120)
}


// MARK: - PREVIEW
#Preview {
    HomeView(isMainTabBarVisible: .constant(true))
}
