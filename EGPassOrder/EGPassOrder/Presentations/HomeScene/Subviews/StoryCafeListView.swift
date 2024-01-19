//
//  StoryCafeListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/18/24.
//

import SwiftUI

struct StoryCafeListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TitleView()
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
        .padding(.horizontal)
    }
}


private struct CafeListScrollView: View {
    // FIXME: Remove Dummy
    let rows = (0..<12)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()],
                      alignment: .leading,
                      spacing: CGFloat.cellSpacing) {
                // FIXME: Remove Dummy
                ForEach(rows.indices, id: \.self) { item in
                    // FIXME: Remove Dummy
                    SmallCafeListCell(
                        cafeListType: .story,
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
    static let cellWidthCoefficient = CGFloat(0.25)
    static let cellSpacing = CGFloat(16)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let titleTextTurquoise = Color("HomeScene/Subviews/StoryCafeListView/turquoise")
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let titleText = Text("게스트님 근처에\n").font(.title3)
    + Text("스토리가 많은 매장")
        .foregroundStyle(Color.titleTextTurquoise)
        .font(.title3)
        .fontWeight(.bold)
    + Text("이에요!").font(.title3)

    static let viewMoreButtonText = Text("더보기")
}


#Preview {
    StoryCafeListView()
}
