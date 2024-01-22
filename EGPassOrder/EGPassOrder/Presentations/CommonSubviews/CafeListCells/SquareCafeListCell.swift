//
//  SquareCafeListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/19/24.
//

import SwiftUI

struct SquareCafeListCell: View, CafeListCellConfigurable {
    @State private(set) var cafeOperationStatus: CafeOperationStatus
    @State var cafeImage: Image?
    @State var imageWidth: CGFloat
    @State static var imageAspectRatio = CGFloat.defaultImageAspectRatio

    init(
        cafeOperationStatus: CafeOperationStatus,
        imageWidth: CGFloat
    ) {
        self.cafeOperationStatus = cafeOperationStatus
        self.imageWidth = imageWidth
    }

    var body: some View {
        NavigationLink(
            // TODO; Add Destination View
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
                        imageAspectRatio:
                            Self.$imageAspectRatio
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
                // TODO: Check Cases
                EmptyView()
//                PhoneOrderOnlyCafeImageOverlayView(
//                    imageWidth: $imageWidth,
//                    imageAspectRatio: $imageAspectRatio
//                )
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


// MARK: - Subview: CafeImageOverlayViews
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
                        Text.dummyHeartCount
                    } icon: {
                        Image.heartOrangeFillIcon
                    }

                    Label {
                        Text.dummyStoryCount
                    } icon: {
                        Image.storyWhiteIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }

                HStack {
                    Label {
                        Text.dummyOrderCount
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
        // TODO: Check Cases
        EmptyView()
    }
}


fileprivate struct PreparingCafeImageOverlayView: View {
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
                        Text.dummyHeartCount
                    } icon: {
                        Image.heartOrangeFillIcon
                    }

                    Label {
                        Text.dummyStoryCount
                    } icon: {
                        Image.storyWhiteIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }

                HStack {
                    Label {
                        Text.dummyOrderCount
                    } icon: {
                        Image.cartIcon
                    }
                    .labelStyle(.titleAndIcon)

                    Spacer()
                }
            }
            .padding(CGFloat.cafeImageContentPadding)

            Color.dimmedOverlayBlack

            VStack(alignment: .center) {
                Image.preparingClockImage
                Text.preparingCafeTitle
            }
        }
    }
}


// MARK: - Subview: CellDescriptionView
fileprivate struct CafeDescriptionView: View {
    @Binding var cafeOperationStatus: CafeOperationStatus
    @Binding var width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text.dummyCafeNameTitle
                .lineLimit(Int.cafeNameLineLimit)
                .multilineTextAlignment(.leading)

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
                Text.dummyCafeDistance
            } icon: {
                Image.locationIcon
            }
        }
        .frame(maxWidth: width)
    }
}



// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let badgeHStackPadding = CGFloat(8)
    static let badgeHStackSpacing = CGFloat(4)
    static let cafeImageContentPadding = CGFloat(8)
    static let cafeImageCornerRadius = CGFloat(4)
    static let cellVerticalSpacing = CGFloat(12)
    static let defaultImageAspectRatio = CGFloat(1)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let cafeNameBlack = Color.black
    static let cartWhite = Color.white
    static let dimmedOverlayBlack = Color.black.opacity(0.5)
    static let distanceGray = Color.gray
    static let heartOrange = Color("CommonSubviews/CafeListCells/orange")
    static let preparingCafeWhite = Color.white
    static let preparingGray = Color.gray
    static let storyWhite = Color.white
}


// MARK: - Extension: Image
fileprivate extension Image {
    // Badges
    static let newCafeBadge = Image("CommonSubviews/CafeListCells/newCafeBadge")
    static let phoneCallBadge = Image("CommonSubviews/CafeListCells/phoneCallBadge")
    static let pointBadge = Image("CommonSubviews/CafeListCells/pointBadge")
    static let pointTogetherBadge = Image("CommonSubviews/CafeListCells/pointTogetherBadge")

    // Icons
    static let cartIcon = Image("CommonSubviews/CafeListCells/cartIcon")
    static let heartOrangeFillIcon = Image("CommonSubviews/CafeListCells/heartOrangeFillIcon")
    static let locationIcon = Image("CommonSubviews/CafeListCells/locationIcon")
    static let pickUpTimeIcon = Image("CommonSubviews/CafeListCells/pickUpTimeIcon")
    static let storyWhiteIcon = Image("CommonSubviews/CafeListCells/storyWhiteIcon")

    // Images
    static let phoneOrderableBalloon = Image("CommonSubviews/CafeListCells/phoneOrderableBalloon")
    static let preparingClockImage = Image("CommonSubviews/CafeListCells/preparingClockImage")

    // FIXME: Remove Dummy
    static let dummyCafeImage = Image("HomeScene/Subviews/NearbyCafeListView/defaultCafeImage")
}


// MARK: - Extension: Int
fileprivate extension Int {
    static let cafeNameLineLimit = Int(2)
}


// MARK: - Extension: Text
fileprivate extension Text {
    // FIXME: Remove Dummy
    static let dummyCafeDistance = Text("14.8km").foregroundStyle(Color.distanceGray)
    static let dummyCafeNameTitle = Text("커피사피엔스 구로한영").font(.title3).foregroundStyle(Color.cafeNameBlack)
    static let dummyHeartCount = Text("123").foregroundStyle(Color.heartOrange)
    static let dummyStoryCount = Text("456").foregroundStyle(Color.storyWhite)
    static let dummyOrderCount = Text("주문수 0").foregroundStyle(Color.cartWhite)
    
    static let preparingNow = Text("준비 중").foregroundStyle(Color.preparingGray)
    static let preparingCafeTitle = Text("준비 중 입니다.").foregroundStyle(Color.preparingCafeWhite)
    static let receiveNow = Text("지금 수령").foregroundStyle(Color.heartOrange)
}


#Preview {
    SquareCafeListCell(
        cafeOperationStatus: .open,
        imageWidth: 240
    )
}
