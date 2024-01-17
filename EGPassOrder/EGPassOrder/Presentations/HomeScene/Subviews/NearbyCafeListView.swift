//
//  NearbyCafeListView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/15/24.
//

import SwiftUI

struct NearbyCafeListView: View {
    @State private var isPhoneOrderable: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            TitleView(isPhoneOrderable: $isPhoneOrderable)

            CafeListScrollView(isPhoneOrderable: $isPhoneOrderable)

            AccessaryView()
                .padding()
        }
    }
}


// MARK: - Subview: TitleView
fileprivate struct TitleView: View {
    @Binding var isPhoneOrderable: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text.titleText
                }

                Spacer()

                Image.passbadge
            }

            HStack {
                Text.titleToggleLeadingText
                Toggle("", isOn: $isPhoneOrderable)
                    .tint(Color.titleTextOrange)
                    .labelsHidden()

                Spacer()
            }
        }
    }
}


// MARK: - Subview: CafeListScrollView
fileprivate struct CafeListScrollView: View {
    @Binding var isPhoneOrderable: Bool
    
    // FIXME: Remove Dummy
    let rows = (0..<5)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem()], alignment: .top, spacing: CGFloat.cellSpacing) {
                // FIXME: Remove Dummy
                ForEach(rows.indices, id: \.self) { item in
                    LargeCafeListCell(
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
    static let cellSpacing: CGFloat = 20
    static let cellWidthCoefficient: CGFloat = 0.55
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let titleTextOrange = Color("HomeScene/Subviews/NearbyCafeListView/orange")
}


// MARK: - Extension: Image
fileprivate extension Image {
    static let passbadge = Image("HomeScene/Subviews/NearbyCafeListView/passBadge")
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let titleText = Text("게스트님과\n")
    + Text("가까이 있는 매장")
        .foregroundStyle(Color.titleTextOrange)
        .fontWeight(.bold)
    + Text("이에요!")

    static let titleToggleLeadingText = Text("전화주문 매장 보기")
    static let viewMoreButtonText = Text("더보기")
}


#Preview {
    NearbyCafeListView()
}
