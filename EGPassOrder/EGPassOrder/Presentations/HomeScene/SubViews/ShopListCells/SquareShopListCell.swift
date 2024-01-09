//
//  SquareShopListCell.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/4/24.
//

import SwiftUI

struct SquareShopListCell: View {
    @State var width: CGFloat
    @State var height: CGFloat
    @State var isOpenedShop: Bool = true
    
    init(width: CGFloat) {
        self.width = width
        self.height = width
    }

    var body: some View {
        VStack(alignment: .leading) {
            ShopImageView(isOpenedShop: $isOpenedShop, width: $width, height: $height)
            ShopDescriptionView(width: $width)
        }
    }
}

private struct ShopImageView: View {
    @Binding var isOpenedShop: Bool
    @Binding var width: CGFloat
    @Binding var height: CGFloat

    var body: some View {
        ZStack {
            Image.testImage
                .resizable()
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: 12))

            if isOpenedShop == false {
                DimmedShopImageView(width: $width, height: $height)
            } else {
                DefaultImageView(width: $width, height: $height)
            }
        }
        .frame(width: width, height: height)
    }

    struct DimmedShopImageView: View {
        @Binding var width: CGFloat
        @Binding var height: CGFloat
        
        var body: some View {
            ZStack {
                Color.shopListCellImageDimmed
            }
            .frame(width: width, height: height)
        }
    }

    struct DefaultImageView: View {
        @Binding var width: CGFloat
        @Binding var height: CGFloat
        
        var body: some View {
            ZStack {
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
                .padding(8)
            }
            .frame(width: width, height: height)
        }
    }
}


private struct ShopDescriptionView: View {
    @Binding var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("하이브커피 asfasdfasdfadsfads")
                .lineLimit(2)
                .font(.title3)
                .padding(.bottom, 8)
            
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
                Text("구매가능")
                    .foregroundStyle(Color.shopListCellGray)
            } icon: {
                Image.pointIcon
            }
        }
        .frame(maxWidth: width)
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
    static let heartIcon = Image("ShopListCells/heartIcon")
    static let commentIcon = Image("ShopListCells/commentIcon")
    static let cartIcon = Image("ShopListCells/cartIcon")
}


// MARK: - Color
fileprivate extension Color {
    static let shopListCellWhite = Color.white
    static let shopListCellOrange = Color("ShopListCells/orange")
    static let shopListCellImageDimmed = Color.black.opacity(0.5)
    static let shopListCellGray = Color("ShopListCells/gray")
}


#Preview {
    SquareShopListCell(width: 240)
}
