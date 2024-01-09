//
//  SmallShopListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct SmallShopListCell: View {
    @State var isOpenedShop: Bool = true

    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            ShopImageView(isOpenedShop: $isOpenedShop, imageHeight: 100)
            ShopDescriptionView()
        }
    }
}


private struct ShopImageView: View {
    @Binding var isOpenedShop: Bool
    @State var imageHeight: CGFloat

    var body: some View {
        ZStack {
            Image.testImage
                .resizable()
                .frame(width: imageHeight, height: imageHeight)
                .clipShape(.rect(cornerRadius: 12))

            if isOpenedShop == false {
                DimmedShopImageView(imageHeight: $imageHeight)
            } else {
                DefaultImageView(imageHeight: $imageHeight)
            }
        }
        .frame(width: imageHeight, height: imageHeight)
    }

    struct DimmedShopImageView: View {
        @Binding var imageHeight: CGFloat
        
        var body: some View {
            ZStack {
                Color.shopListCellImageDimmed
            }
            .frame(width: imageHeight, height: imageHeight)
        }
    }

    struct DefaultImageView: View {
        @Binding var imageHeight: CGFloat
        
        var body: some View {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image.pointBadge
                        Image.pointTogetherBadge
                        Image.dineInBadge
                        Image.discountBadge
                        Spacer()
                    }
                    .padding(6)
                }
            }
            .frame(width: imageHeight, height: imageHeight)
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
        .padding(.leading, 8)
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
    SmallShopListCell()
}
