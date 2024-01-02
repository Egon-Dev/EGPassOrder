//
//  LargeShopListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct LargeShopListCell: View {
    @State private  var isPhoneOrderShop: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            LargeShopListImageView(isPhoneOrderShop: $isPhoneOrderShop)
            LargeShopListDescriptionView(isPhoneOrderShop: $isPhoneOrderShop)
                .padding()
        }
    }
}


private struct LargeShopListImageView: View {
    @Binding fileprivate var isPhoneOrderShop: Bool

    var body: some View {
        ZStack {
            Image.testShopImage
                .resizable()
                .aspectRatio(contentMode: .fill)

            if isPhoneOrderShop == true {
                LargeShopListDimmedImageView()
            } else {
                LargeShopListDefaultImageView()
            }
        }
    }
}


extension LargeShopListImageView {
    private struct LargeShopListDimmedImageView: View {
        var body: some View {
            Color.shopListCellImageDimmed

            VStack {
                Image.phoneOrderLargeIcon
                Text("전화주문 매장")
                    .font(.title3)
                    .foregroundStyle(Color.shopListCellWhite)
            }

            VStack(alignment: .leading) {
                Spacer()

                HStack {
                    Image.phoneCallBadge
                    Spacer()
                }

                HStack {
                    Label {
                        Text("0")
                            .foregroundStyle(Color.shopListCellOrange)
                    } icon: {
                        Image.heartIcon
                    }

                    Label {
                        Text("0")
                            .foregroundStyle(Color.shopListCellWhite)
                    } icon: {
                        Image.commentIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }
            }
        }
    }
}


extension LargeShopListImageView {
    private struct LargeShopListDefaultImageView: View {
        var body: some View {
            VStack(alignment: .leading) {
                Spacer()

                HStack {
                    Image.pointBadge
                    Image.pointTogetherBadge
                    Image.newShopBadge
                    Spacer()
                }

                HStack {
                    Label {
                        Text("0")
                            .foregroundStyle(Color.shopListCellOrange)
                    } icon: {
                        Image.heartIcon
                    }

                    Label {
                        Text("0")
                            .foregroundStyle(Color.shopListCellWhite)
                    } icon: {
                        Image.commentIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }

                HStack {
                    Label {
                        var formattedNumber: String {
                            let numberFormatter = NumberFormatter()
                            numberFormatter.numberStyle = .decimal

                            return numberFormatter.string(from: NSNumber(value: 1234)) ?? "0"
                        }

                        Text("주문수 \(formattedNumber)")
                            .foregroundStyle(Color.shopListCellWhite)
                            .font(.subheadline)
                    } icon: {
                        Image.cartIcon
                    }
                    .labelStyle(.titleAndIcon)
                    Spacer()
                }
            }
            .padding()
        }
    }
}


private struct LargeShopListDescriptionView: View {
    @Binding fileprivate var isPhoneOrderShop: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("커피사피엔스 구로한영 캐슬시티점")
                .font(.title3)
                .lineLimit(2)
            
            if isPhoneOrderShop == false {
                Label {
                    Text("지금 수령")
                        .foregroundStyle(Color.shopListCellOrange)
                } icon: {
                    Image.pickUpTimeIcon
                }
            }

            Label {
                Text("120.0m")
                    .foregroundStyle(Color.shopListCellGray)
            } icon: {
                Image.shopDistanceIcon
            }
        }
    }
}


// MARK: - Images {
fileprivate extension Image {
    static let phoneOrderLargeIcon = Image("ShopListCells/phoneOrderBalloonIcon")
    static let phoneCallBadge = Image("ShopListCells/phoneCallBadge")
    static let pointBadge = Image("ShopListCells/pointBadge")
    static let pointTogetherBadge = Image("ShopListCells/pointTogetherBadge")
    static let newShopBadge = Image("ShopListCells/newShopBadge")
    static let heartIcon = Image("ShopListCells/heartIcon")
    static let commentIcon = Image("ShopListCells/commentIcon")
    static let cartIcon = Image("ShopListCells/cartIcon")
    static let pickUpTimeIcon = Image("ShopListCells/pickUpTimeIcon")
    static let shopDistanceIcon = Image("ShopListCells/shopDistanceIcon")

    static let testShopImage = Image("ShopListCells/testImage")
}


// MARK: - Colors {
fileprivate extension Color {
    static let shopListCellWhite = Color.white
    static let shopListCellOrange = Color("ShopListCells/orange")
    static let shopListCellImageDimmed = Color.black.opacity(0.5)
    static let shopListCellGray = Color("ShopListCells/gray")
}

#Preview {
    LargeShopListCell()
}
