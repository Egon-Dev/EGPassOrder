//
//  LargeCafeListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/15/24.
//

import SwiftUI

struct LargeCafeListCell: View, CafeListCellConfigurable {
    @State private(set) var cafeOperationStatus: CafeOperationStatus
    @State private var isFirst: Bool = false
    @State var cafeImage: Image?
    @State var imageWidth: CGFloat
    @State static var imageAspectRatio = CGFloat.defaultImageAspectRatio

    init(cafeOperationStatus: CafeOperationStatus, imageWidth: CGFloat) {
        self.cafeOperationStatus = cafeOperationStatus
        self.imageWidth = imageWidth
    }

    var body: some View {
        NavigationLink(
            destination: { EmptyView() },
            label: {
                VStack(
                    alignment: .leading,
                    spacing: CGFloat.cellVerticalSpacing
                ) {
                    CafeImageView(
                        cafeOperationStatus: $cafeOperationStatus,
                        cafeImage: $cafeImage,
                        imageWidth: $imageWidth,
                        imageAspectRatio: Self.$imageAspectRatio
                    )

                    CafeDescriptionView(
                        cafeOperationStatus: $cafeOperationStatus,
                        width: $imageWidth
                    )
                }
            }
        )
    }
}


// MARK: - Subview: CellImageView
fileprivate struct CafeImageView: View {
    @Binding var cafeOperationStatus: CafeOperationStatus
    @Binding var cafeImage: Image?
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat
    private var imageHeight: CGFloat { imageWidth * imageAspectRatio }

    var body: some View {
        ZStack {
            if let cafeImage = cafeImage {
                cafeImage
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
            } else {
                // FIXME: Remove Dummy
                Image.dummyCafeImage
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
            }

            switch cafeOperationStatus {
            case .open:
                OpenedCafeImageOverlayView(
                    imageWidth: $imageWidth,
                    imageAspectRatio: $imageAspectRatio
                )
            case .phoneOrderOnly:
                PhoneOrderOnlyCafeImageOverlayView(
                    imageWidth: $imageWidth,
                    imageAspectRatio: $imageAspectRatio
                )
            case .preparing:
                PreparingCafeImageOverlayView(
                    imageWidth: $imageWidth,
                    imageAspectRatio: $imageAspectRatio
                )
            }
        }
        .frame(width: imageWidth, height: imageHeight)
        .clipShape(.rect(cornerRadius: CGFloat.cafeImageCornerRadius))
    }
}


// MARK: - Subview: CafeImageViews
fileprivate struct OpenedCafeImageOverlayView: View {
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
                    Image.newCafeBadge
                }

                HStack {
                    Label {
                        Text.heartCount
                    } icon: {
                        Image.heartOrangeFillIcon
                    }

                    Label {
                        Text.storyCount
                    } icon: {
                        Image.storyWhiteIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }

                HStack {
                    Label {
                        Text.cartCount
                    } icon: {
                        Image.cartIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }
            }
        }
        .padding(CGFloat.cafeImageContentPadding)
    }
}


fileprivate struct PhoneOrderOnlyCafeImageOverlayView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat

    var body: some View {
        ZStack {
            Color.dimmedOverlayBlack

            VStack(alignment: .center) {
                Image.phoneOrderableBalloon
                Text.phoneOrderableCafe
            }

            VStack(alignment: .leading) {
                Spacer()

                HStack {
                    Image.phoneCallBadge
                    Spacer()
                }

                HStack {
                    Label {
                        Text.heartCount
                    } icon: {
                        Image.heartOrangeFillIcon
                    }

                    Label {
                        Text.storyCount
                    } icon: {
                        Image.storyWhiteIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }
            }
            .padding(CGFloat.cafeImageContentPadding)
        }
    }
}


fileprivate struct PreparingCafeImageOverlayView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat

    var body: some View {
        ZStack {
            Color.dimmedOverlayBlack

            VStack(alignment: .center) {
                Image.preparingClockImage
                Text.preparingCafeTitle
            }

            VStack(alignment: .leading) {
                Spacer()

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text.preparingButton
                        .padding(CGFloat.preparingButtonPadding)
                        .frame(width: imageWidth - CGFloat.preparingButtonMargin)
                        .background(Color.preparingButtonOrange)
                        .clipShape(.rect(cornerRadius: CGFloat.preparingButtonCornerRadius))
                })
            }
            .padding(CGFloat.cafeImageContentPadding)
        }
    }
}


// MARK: - Subview: CellDescriptionView
fileprivate struct CafeDescriptionView: View {
    @Binding var cafeOperationStatus: CafeOperationStatus
    @Binding var width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text.cafeNameTitle
                .foregroundStyle(Color.cafeNameBlack)
                .lineLimit(Int.cafeNameLineLimit)
            Text("")
                .frame(width: width)

            switch cafeOperationStatus {
            case .open:
                Label {
                    Text.receiveNow
                } icon: {
                    Image.pickUpTimeIcon
                }
            case .phoneOrderOnly:
                EmptyView()
            case .preparing:
                Label {
                    Text.preparingNow
                } icon: {
                    Image.pickUpTimeIcon
                        .renderingMode(.template)
                        .foregroundStyle(Color.preparingGray)
                }
            }

            Label {
                Text.cafeDistance
            } icon: {
                Image.locationIcon
            }
        }
        .frame(maxWidth: width)
    }
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let phoneOrderableWhite = Color.white
    static let preparingCafeWhite = Color.white
    static let dimmedOverlayBlack = Color.black.opacity(0.5)
    static let cafeNameBlack = Color.black
    static let heartOrange = Color("CommonSubviews/CafeListCells/orange")
    static let storyWhite = Color.white
    static let cartWhite = Color.white
    static let distanceGray = Color.gray
    static let preparingButtonOrange = Color("CommonSubviews/CafeListCells/orange")
    static let preparingGray = Color.gray
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let defaultImageAspectRatio = CGFloat(840) / CGFloat(660)
    static let cellVerticalSpacing: CGFloat = 12
    static let cafeImageCornerRadius: CGFloat = 4
    static let cafeImageContentPadding: CGFloat = 8
    static let preparingButtonMargin: CGFloat = 16
    static let preparingButtonPadding: CGFloat = 8
    static let preparingButtonCornerRadius: CGFloat = 6
}


// MARK: - Extension: Image
fileprivate extension Image {
    // Icons
    static let heartOrangeFillIcon = Image("CommonSubviews/CafeListCells/heartOrangeFillIcon")
    static let storyWhiteIcon = Image("CommonSubviews/CafeListCells/storyWhiteIcon")
    static let cartIcon = Image("CommonSubviews/CafeListCells/cartIcon")
    static let pickUpTimeIcon = Image("CommonSubviews/CafeListCells/pickUpTimeIcon")
    static let locationIcon = Image("CommonSubviews/CafeListCells/locationIcon")

    // Badges
    static let pointBadge = Image("CommonSubviews/CafeListCells/pointBadge")
    static let pointTogetherBadge = Image("CommonSubviews/CafeListCells/pointTogetherBadge")
    static let newCafeBadge = Image("CommonSubviews/CafeListCells/newCafeBadge")
    static let phoneCallBadge = Image("CommonSubviews/CafeListCells/phoneCallBadge")

    // Images
    static let phoneOrderableBalloon = Image("CommonSubviews/CafeListCells/phoneOrderableBalloon")
    static let preparingClockImage = Image("CommonSubviews/CafeListCells/preparingClockImage")

    // FIXME: Remove Dummy
    static let dummyCafeImage = Image("HomeScene/Subviews/NearbyCafeListView/defaultCafeImage")
}


// MARK: - Extension: Int
fileprivate extension Int {
    static let cafeNameLineLimit: Int = 2

    var decimalString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}


// MARK: - Extension: Text
fileprivate extension Text {
    // FIXME: Replace Dummy
    static let phoneOrderableCafe = Text("전화주문 매장").font(.title3).fontWeight(.bold).foregroundStyle(Color.phoneOrderableWhite)
    static let preparingCafeTitle = Text("준비 중 입니다.").foregroundStyle(Color.preparingCafeWhite)
    static let preparingButton = Text("매장이 열리면 알려드릴까요?").font(.footnote).fontWeight(.semibold).foregroundStyle(Color.preparingCafeWhite)
    static let heartCount = Text("0").foregroundStyle(Color.heartOrange)
    static let storyCount = Text("0").foregroundStyle(Color.storyWhite)
    static let cartCount = Text("주문수 \(1234.decimalString)").foregroundStyle(Color.cartWhite).font(.subheadline)
    static let cafeNameTitle = Text("커피사피엔스 구로한영 캐슬시티점 aaaaaaaa").font(.title3)
    static let receiveNow = Text("지금 수령").foregroundStyle(Color.heartOrange)
    static let preparingNow = Text("준비 중").foregroundStyle(Color.preparingGray)
    static let cafeDistance = Text("120.0m").foregroundStyle(Color.distanceGray)
}


#Preview {
    LargeCafeListCell(cafeOperationStatus: .open, imageWidth: 200)
}
