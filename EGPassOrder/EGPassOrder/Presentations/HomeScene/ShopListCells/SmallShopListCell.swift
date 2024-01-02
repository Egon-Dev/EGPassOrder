//
//  SmallShopListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct SmallShopListCell: View {
    @State var isOpenedShop: Bool = true
    @State var proxy: GeometryProxy

    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            ShopImageView(isOpenedShop: $isOpenedShop)
                .aspectRatio(1, contentMode: .fit)
                .frame(
                    width: proxy.size.width * 0.3,
                    height: proxy.size.width * 0.3
                )
            ShopDescriptionView()
                .frame(
                    width: proxy.size.width * 0.5,
                    height: proxy.size.width * 0.3
                )
        }
    }
}


private struct ShopImageView: View {
    @Binding var isOpenedShop: Bool

    var body: some View {
        ZStack {
            Image.testImage
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.rect(cornerRadius: 12))

            if isOpenedShop == false {
                DimmedShopImageView()
            } else {
                DefaultImageView()
            }
        }
    }

    struct DimmedShopImageView: View {
        var body: some View {
            ZStack {
                Color.shopListCellImageDimmed
            }
        }
    }

    struct DefaultImageView: View {
        var body: some View {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    HStack {
                        Image.pointBadge
                        Image.pointTogetherBadge
                        Image.dineInBadge
                        Image.discountBadge
                        Spacer()
                    }
                    .padding(6)
                }
            }
        }
    }
}


private struct ShopDescriptionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("하이브커피")

            Label {
                Text("132.0m")
                    .foregroundStyle(Color.shopListCellGray)
            } icon: {
                Image.shopDistanceIcon
            }

            Label {
                Text("판매글 1")
                    .foregroundStyle(Color.shopListCellGray)
            } icon: {
                Image.salePostIcon
            }

            Label {
                Text("구매가능 포인트 330P")
                    .foregroundStyle(Color.shopListCellGray)
            } icon: {
                Image.pointIcon
            }
        }
    }
}


// MARK: - Images
fileprivate extension Image {
    static let testImage = Image("ShopListCells/testImage")
    static let shopDistanceIcon = Image("ShopListCells/shopDistanceIcon")
    static let salePostIcon = Image("ShopListCells/salePostIcon")
    static let pointIcon = Image("ShopListCells/pointIcon")
    static let stampIcon = Image("ShopListCells/stampIcon")
    static let newShopBadge = Image("ShopListCells/newShopCircleSmallBadge")
    static let dineInBadge = Image("ShopListCells/dineInCircleSmallBadge")
    static let discountBadge =
        Image("ShopListCells/discountCircleSmallBadge")
    static let pointBadge = Image("ShopListCells/pointCircleSmallBadge")
    static let pointTogetherBadge = Image("ShopListCells/pointTogetherCircleSmallBadge")
}


// MARK: - Color
fileprivate extension Color {
    static let shopListCellGray = Color("ShopListCells/gray")
    static let shopListCellImageDimmed = Color.black.opacity(0.5)
}


#Preview {
    GeometryReader { proxy in
        SmallShopListCell(proxy: proxy)
    }
}
