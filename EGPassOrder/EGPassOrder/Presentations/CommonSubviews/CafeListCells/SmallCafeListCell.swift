//
//  SmallCafeListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/17/24.
//

import SwiftUI

struct SmallCafeListCell: View, CafeListCellConfigurable {
    @State private(set) var cafeOperationStatus: CafeOperationStatus
    @State var cafeImage: Image?
    @State var imageWidth: CGFloat
    @State static var imageAspectRatio = CGFloat.defaultImageAspectRatio
    @State static var descriptionAspectRatio = CGFloat.defaultDescriptionRatio

    init(cafeOperationStatus: CafeOperationStatus, imageWidth: CGFloat) {
        self.cafeOperationStatus = cafeOperationStatus
        self.imageWidth = imageWidth
    }

    var body: some View {
        HStack(spacing: CGFloat.cellHorizontalSpacing) {
            CafeImageView(
                status: $cafeOperationStatus,
                image: $cafeImage,
                width: $imageWidth,
                aspectRatio: Self.$imageAspectRatio
            )

            CafeDescriptionView(
                status: $cafeOperationStatus,
                height: $imageWidth,
                aspectRatio: Self.$descriptionAspectRatio
            )
        }
    }
}


// MARK: - Subview: CellImageView
fileprivate struct CafeImageView: View {
    @Binding var status: CafeOperationStatus
    @Binding var image: Image?
    @Binding var width: CGFloat
    @Binding var aspectRatio: CGFloat
    private var height: CGFloat { width * aspectRatio }

    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .clipShape(.rect(cornerRadius: CGFloat.cafeImageCornerRadius))
            } else {
                Image.dummyCafeImage
                    .resizable()
                    .frame(width: width, height: height)
                    .clipShape(.rect(cornerRadius: CGFloat.cafeImageCornerRadius))
            }

            switch status {
            case .open:
                OpenedCafeImageOverlayView(
                    imageWidth: $width,
                    imageAspectRatio: $aspectRatio
                )
            case .phoneOrderOnly:
                // TODO: Check case
                EmptyView()
//                PhoneOrderOnlyCafeImageOverlayView(
//                    imageWidth: $width,
//                    imageAspectRatio: $aspectRatio
//                )
            case .preparing:
                PreparingCafeImageOverlayView(
                    imageWidth: $width,
                    imageAspectRatio: $aspectRatio
                )
            }
        }
    }
}


// MARK: - Subview: CafeImageViews
fileprivate struct OpenedCafeImageOverlayView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat
    private var imageHeight: CGFloat { imageWidth * imageAspectRatio }

    var body: some View {
        ZStack {
            // Badge Stack
            VStack(alignment: .leading) {
                Spacer()

                HStack(spacing: CGFloat.badgeHStackSpacing) {
                    Image.newCafeCircleBadge
                    Image.pointCircleBadge
                    Image.pointTogetherCircleBadge
                    Image.discountCircleBadge

                    Spacer()
                }
                .padding(CGFloat.badgeHStackPadding)
            }
        }
        .frame(width: imageWidth, height: imageHeight)
    }
}


fileprivate struct PhoneOrderOnlyCafeImageOverlayView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat
    private var imageHeight: CGFloat { imageWidth * imageAspectRatio }

    var body: some View {
        ZStack {
            // Badge Stack
            VStack(alignment: .leading) {
                Spacer()

                HStack(spacing: CGFloat.badgeHStackSpacing) {
                    Image.newCafeCircleBadge
                    Image.pointCircleBadge
                    Image.pointTogetherCircleBadge
                    Image.discountCircleBadge

                    Spacer()
                }
                .padding(CGFloat.badgeHStackPadding)
            }

            // Dimmed BG
            Color.dimmedOverlayBlack

            // Preparing Image
            VStack(alignment: .center) {
                // Image.phoneOrderableBalloon
            }
        }
        .frame(width: imageWidth, height: imageHeight)
        .clipShape(.rect(cornerRadius: CGFloat.cafeImageCornerRadius))
    }
}


fileprivate struct PreparingCafeImageOverlayView: View {
    @Binding var imageWidth: CGFloat
    @Binding var imageAspectRatio: CGFloat
    private var imageHeight: CGFloat { imageWidth * imageAspectRatio }

    var body: some View {
        ZStack {
            // Badge Stack
            VStack(alignment: .leading) {
                Spacer()

                HStack(spacing: CGFloat.badgeHStackSpacing) {
                    Image.newCafeCircleBadge
                    Image.pointCircleBadge
                    Image.pointTogetherCircleBadge
                    Image.discountCircleBadge

                    Spacer()
                }
                .padding(CGFloat.badgeHStackPadding)
            }

            // Dimmed BG
            Color.dimmedOverlayBlack

            // Preparing Image
            VStack(alignment: .center) {
                Image.preparingClockImage
            }
        }
        .frame(width: imageWidth, height: imageHeight)
        .clipShape(.rect(cornerRadius: CGFloat.cafeImageCornerRadius))
    }
}


// MARK: - Subview: CellDescriptionView
fileprivate struct CafeDescriptionView: View {
    @Binding var status: CafeOperationStatus
    @Binding var height: CGFloat
    @Binding var aspectRatio: CGFloat
    private var width: CGFloat { height / aspectRatio }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: CGFloat.DescriptionVerticalSpacing
        ) {
            Text.dummyCafeNameText
                .lineLimit(Int.cafeNameLineLimit)

            Label(
                title: { Text.dummyCafeDistanceText },
                icon: { Image.locationIcon }
            )

            Label(
                title: { Text.dummyCafeSalePostText },
                icon: { Image.salePostIcon }
            )

            Label(
                title: { Text.dummyCafePointText },
                icon: { Image.pointIcon }
            )
        }
        .frame(width: width, height: height)
    }
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let cellHorizontalSpacing = CGFloat(8)
    static let cafeImageCornerRadius = CGFloat(12)
    static let defaultImageAspectRatio = CGFloat(1)
    static let defaultDescriptionRatio = CGFloat(0.45)
    static let badgeHStackSpacing = CGFloat(4)
    static let badgeHStackPadding = CGFloat(6)
    static let DescriptionVerticalSpacing = CGFloat(4)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let titleBlack = Color.black
    static let descriptionGray = Color.gray
    static let dimmedOverlayBlack = Color.black.opacity(0.5)
}


// MARK: - Extension: Image
fileprivate extension Image {
    // FIXME: Remove Dummy
    static let dummyCafeImage = Image("HomeScene/Subviews/NearbyCafeListView/defaultCafeImage")

    // Images
    static let preparingClockImage = Image("CommonSubviews/CafeListCells/preparingClockImage")

    // Icons
    static let locationIcon = Image("CommonSubviews/CafeListCells/locationIcon")
    static let salePostIcon = Image("CommonSubviews/CafeListCells/salePostIcon")
    static let pointIcon = Image("CommonSubviews/CafeListCells/pointIcon")
    static let stampIcon = Image("CommonSubviews/CafeListCells/stampIcon")

    // Badges
    // TODO: Add Image Assets
    static let newCafeCircleBadge = Image("CommonSubviews/CafeListCells/newCafeCircleBadge")
    static let discountCircleBadge = Image("CommonSubviews/CafeListCells/discountCircleBadge")
    static let pointCircleBadge = Image("CommonSubviews/CafeListCells/pointCircleBadge")
    static let pointTogetherCircleBadge = Image("CommonSubviews/CafeListCells/pointTogetherCircleBadge")
}


// MARK: - Extension: Int
fileprivate extension Int {
    static let cafeNameLineLimit: Int = 1
}


// MARK: - Extension: Text
fileprivate extension Text {
    // FIXME: Replace Dummy
    static let dummyCafeNameText = Text("하이브커피하이브커피하이브커피하이브커피").font(.title3)
    static let dummyCafeDistanceText = Text("132.0m").foregroundStyle(Color.descriptionGray)
    static let dummyCafeSalePostText = Text("판매글 1").foregroundStyle(Color.descriptionGray)
    static let dummyCafePointText = Text("구매가능 포인트 330P").foregroundStyle(Color.descriptionGray)
    static let dummyCafeStampText = Text("구매가능 스탬프 2개 쿠폰 0개").foregroundStyle(Color.descriptionGray)
}


#Preview {
    SmallCafeListCell(cafeOperationStatus: .open, imageWidth: 100)
}
