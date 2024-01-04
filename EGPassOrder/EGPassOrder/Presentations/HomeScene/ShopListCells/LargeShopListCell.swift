//
//  LargeShopListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct LargeShopListCell: View, ShopListCellConfigurable {
    @State var imageWidth: CGFloat
    @State static var imageAspectRatio: CGFloat = 600 / 770
    @State private var isPhoneOrderShop: Bool

    init(imageWidth: CGFloat, isPhoneOrderShop: Bool = false) {
        self.imageWidth = imageWidth
        self.isPhoneOrderShop = isPhoneOrderShop
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CellImageView(
                imageWidth: $imageWidth,
                imageAspectRatio: Self.$imageAspectRatio,
                isPhoneOrderShop: $isPhoneOrderShop
            )
            CellDescriptionView(
                imageWidth: $imageWidth,
                imageAspectRatio: Self.$imageAspectRatio,
                isPhoneOrderShop: $isPhoneOrderShop
            )
        }
    }
}


private struct CellImageView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat
    @Binding var isPhoneOrderShop: Bool

    var body: some View {
        ZStack {
            Image.testShopImage
                .resizable()
                .frame(width: imageWidth, height: imageWidth / imageAspectRatio)

            if isPhoneOrderShop == true {
                LargeShopListDimmedImageView(
                    imageWidth: $imageWidth,
                    imageAspectRatio: $imageAspectRatio
                )
            } else {
                LargeShopListDefaultImageView(
                    imageWidth: $imageWidth,
                    imageAspectRatio: $imageAspectRatio
                )
            }
        }
        .frame(width: imageWidth, height: imageWidth / imageAspectRatio)
        .clipShape(.rect(cornerRadius: 4))
    }
}


extension CellImageView {
    struct LargeShopListDefaultImageView: View {
        @Binding var imageWidth: CGFloat
        @Binding var imageAspectRatio: CGFloat

        var body: some View {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()

                    HStack {
                        Image.pointBadge
                        Image.pointTogetherBadge
                    }
                    HStack {
                        Image.newShopBadge
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
            }
            .padding(8)
        }
    }

    private struct LargeShopListDimmedImageView: View {
        @Binding var imageWidth: CGFloat
        @Binding var imageAspectRatio: CGFloat

        var body: some View {
            ZStack {
                Color.shopListCellImageDimmed

                VStack(alignment: .center) {
                    Image.phoneOrderLargeIcon
                    Text("전화주문 매장")
                        .font(.title3)
                        .fontWeight(.bold)
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
                .padding(8)
            }
        }
    }
}


private struct CellDescriptionView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat
    @Binding var isPhoneOrderShop: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("커피사피엔스 구로한영 캐슬시티점 aaaaaaaa")
                .lineLimit(2)
                .font(.title3)
            Text("")
                .frame(width: imageWidth)

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
        .frame(maxWidth: imageWidth)
    }
}


// MARK: - Images {
fileprivate extension Image {
    // Icons
    static let phoneOrderLargeIcon = Image("ShopListCells/phoneOrderBalloonIcon")
    static let heartIcon = Image("ShopListCells/heartIcon")
    static let commentIcon = Image("ShopListCells/commentIcon")
    static let cartIcon = Image("ShopListCells/cartIcon")
    static let pickUpTimeIcon = Image("ShopListCells/pickUpTimeIcon")
    static let shopDistanceIcon = Image("ShopListCells/shopDistanceIcon")

    // Badges
    static let pointBadge = Image("ShopListCells/pointBadge")
    static let pointTogetherBadge = Image("ShopListCells/pointTogetherBadge")
    static let newShopBadge = Image("ShopListCells/newShopBadge")
    static let phoneCallBadge = Image("ShopListCells/phoneCallBadge")
    
    // Images
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
    LargeShopListCell(imageWidth: 200)
}
