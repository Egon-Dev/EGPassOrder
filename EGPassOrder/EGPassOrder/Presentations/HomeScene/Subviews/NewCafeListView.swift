//
//  NewCafeListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/19/24.
//

import SwiftUI

struct NewCafeListView: View {
    var body: some View {
        TitleView()
            .padding(.horizontal)
        CafeListScrollView()
        AccessaryView()
            .padding()
    }
}


// MARK: - Subview: TitleView
private struct TitleView: View {
    var body: some View {
        HStack {
            Text.titleText

            Spacer()
        }
    }
}


// MARK: - Subview: CafeListScrollView
private struct CafeListScrollView: View {
    // FIXME: Remove Dummy
    let rows = (0...12)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: [GridItem()],
                alignment: .top,
                spacing: CGFloat.cellSpacing
            ) {
                ForEach(rows.indices, id: \.self) { index in
                    SquareCafeListCell(
                        // FIXME: Remove Dummy
                        cafeOperationStatus: .open,
                        imageWidth: UIScreen.main.bounds.width * CGFloat.cellWidthCoefficient
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}


// MARK: - Subview: AccessaryView
private struct AccessaryView: View {
    var body: some View {
        HStack {
            Spacer()

            Button(
                action: {},
                label: {
                    Text.viewMoreButtonText
                }
            )
        }
    }
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let cellSpacing = CGFloat(16)
    static let cellWidthCoefficient = CGFloat(0.55)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let titleTextOrange = Color("HomeScene/Subviews/NewCafeListView/titleOrange")
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let titleText = Text("새로 추가된\n").font(.title3)
    + Text("신규매장")
        .foregroundStyle(Color.titleTextOrange)
        .font(.title3)
        .fontWeight(.bold)
    + Text("을 소개합니다!").font(.title3)
    static let viewMoreButtonText = Text("더보기")
}


#Preview {
    NewCafeListView()
}
