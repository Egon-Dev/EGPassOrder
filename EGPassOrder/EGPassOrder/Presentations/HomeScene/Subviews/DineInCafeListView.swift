//
//  DineInCafeListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/19/24.
//

import SwiftUI

struct DineInCafeListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TitleView()
                .padding(.horizontal)
            CafeListScrollView()
            AccessaryView()
                .padding()
        }
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
    let rows = (0..<12)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem()], alignment: .top, spacing: CGFloat.cellSpacing) {
                // FIXME: Remove Dummy
                ForEach(rows.indices, id: \.self) { item in
                    MediumCafeListCell(
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

            Button(action: {

            }, label: {
                Text.viewMoreButtonText
            })
        }
    }
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let cellWidthCoefficient = CGFloat(0.35)
    static let cellSpacing = CGFloat(16)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let titleTextYellow = Color("HomeScene/Subviews/DineInCafeListView/yellow")
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let titleText = Text("게스트님 근처에 있는\n").font(.title3)
    + Text("먹고갈 수 있는 매장")
        .foregroundStyle(Color.titleTextYellow)
        .font(.title3)
        .fontWeight(.bold)
    + Text("이에요!").font(.title3)

    static let viewMoreButtonText = Text("더보기")
}


#Preview {
    DineInCafeListView()
}
