//
//  SmallCafeListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/17/24.
//

import SwiftUI

enum CafeListType {
    case point
    case story
}

struct SmallCafeListCell: View, CafeListCellConfigurable {
    @State private(set) var cafeOperationStatus: CafeOperationStatus
    @State var cafeImage: Image?
    @State var imageWidth: CGFloat
    @State static var imageAspectRatio = CGFloat.defaultImageAspectRatio
    @State static var descriptionAspectRatio = CGFloat.defaultDescriptionRatio
    let cafeListType: CafeListType

    init(
        cafeListType: CafeListType,
        cafeOperationStatus: CafeOperationStatus,
        imageWidth: CGFloat
    ) {
        self.cafeListType = cafeListType
        self.cafeOperationStatus = cafeOperationStatus
        self.imageWidth = imageWidth
    }

    var body: some View {
        NavigationLink(
            // TODO: Add Destination View
            destination: { EmptyView() },
            label: {
                HStack(spacing: CGFloat.cellHorizontalSpacing) {
                    CafeImageView(
                        status: $cafeOperationStatus,
                        image: $cafeImage,
                        width: $imageWidth,
                        aspectRatio: Self.$imageAspectRatio
                    )

                    switch cafeListType {
                    case .point:
                        PointCafeDescriptionView(
                            status: $cafeOperationStatus,
                            height: $imageWidth,
                            aspectRatio: Self.$descriptionAspectRatio
                        )
                    case .story:
                        StoryCafeDescriptionView(
                            status: $cafeOperationStatus,
                            height: $imageWidth,
                            aspectRatio: Self.$descriptionAspectRatio
                        )
                    }
                }
            }
        )
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


// MARK: - Subview: PointCafeDescriptionView
fileprivate struct PointCafeDescriptionView: View {
    @Binding var status: CafeOperationStatus
    @Binding var height: CGFloat
    @Binding var aspectRatio: CGFloat
    private var width: CGFloat { height / aspectRatio }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: CGFloat.DescriptionVerticalSpacing
        ) {
            // Cafe Name
            Text.dummyCafeNameText
                .lineLimit(Int.cafeNameLineLimit)

            // Cafe Distance
            Label(
                title: { Text.dummyCafeDistanceText },
                icon: { Image.locationIcon }
            )
            
            // Cafe Sale Posts
            Label(
                title: { Text.dummyCafeSalePostText },
                icon: { Image.salePostIcon }
            )
            
            // Cafe Points
            Label(
                title: { Text.dummyCafePointText },
                icon: { Image.pointIcon }
            )
        }
        .frame(width: width, height: height)
    }
}


// MARK: - Subview: StoryCafeDescriptionView
fileprivate struct StoryCafeDescriptionView: View {
    @Binding var status: CafeOperationStatus
    @Binding var height: CGFloat
    @Binding var aspectRatio: CGFloat
    private var width: CGFloat { height / aspectRatio }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: CGFloat.DescriptionVerticalSpacing
        ) {
            // Cafe Name
            Text.dummyCafeNameText
                .foregroundStyle(Color.cafeNameBlack)
                .lineLimit(Int.cafeNameLineLimit)
            
            // Cafe Hearts & Stories
            HStack {
                Label(
                    title: { Text.dummyCafeHeartCountText },
                    icon: { Image.heartOrangeFillIcon }
                )

                Label(
                    title: { Text.dummyCafeStoryCountText },
                    icon: { Image.storyNavyIcon }
                )

                Spacer()
            }

            // Cafe Receive Time & Distance
            HStack {
                switch status {
                case .open:
                    Label(
                        title: { Text.dummyCafePickUpTimeText },
                        icon: { Image.pickUpTimeIcon }
                    )
                case .phoneOrderOnly:
                    // TODO: Check case
                    EmptyView()
                case .preparing:
                    Label(
                        title: { Text.preparingCafe },
                        icon: {
                            Image.pickUpTimeIcon
                                .renderingMode(.template)
                                .foregroundStyle(Color.preparingGray)
                        }
                    )
                }

                Label(
                    title: { Text.dummyCafeDistanceText },
                    icon: { Image.locationIcon }
                )

                Spacer()
            }

            // Cafe Order Counts
            Label(
                title: { Text.dummyCafeOrderCountText },
                icon: { Image.cartIcon }
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
    static let cafeNameBlack = Color.black
    static let dimmedOverlayBlack = Color.black.opacity(0.5)
    static let preparingGray = Color.gray
    static let heartOrange = Color.orange
    static let pickUpOrange = Color.orange
    static let storyNavy = Color.indigo
    static let cartGray = Color.gray
}


// MARK: - Extension: Image
fileprivate extension Image {
    // FIXME: Remove Dummy
    static let dummyCafeImage = Image("HomeScene/Subviews/NearbyCafeListView/defaultCafeImage")

    // Images
    static let preparingClockImage = Image("CommonSubviews/CafeListCells/preparingClockImage")

    // Icons
    static let heartOrangeFillIcon = Image("CommonSubviews/CafeListCells/heartOrangeFillIcon")
    static let salePostIcon = Image("CommonSubviews/CafeListCells/salePostIcon")
    static let pointIcon = Image("CommonSubviews/CafeListCells/pointIcon")
    static let stampIcon = Image("CommonSubviews/CafeListCells/stampIcon")
    static let storyNavyIcon = Image("CommonSubviews/CafeListCells/storyNavyIcon")
    static let pickUpTimeIcon = Image("CommonSubviews/CafeListCells/pickUpTimeIcon")
    static let locationIcon = Image("CommonSubviews/CafeListCells/locationIcon")
    static let cartIcon = Image("CommonSubviews/CafeListCells/cartIcon")

    // Badges
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
    static let dummyCafeNameText = Text("하이브커피하이브커피하이브커피하이브커피").font(.title3).foregroundStyle(Color.cafeNameBlack)
    static let dummyCafeDistanceText = Text("132.0m").foregroundStyle(Color.descriptionGray)
    static let dummyCafeSalePostText = Text("판매글 1").foregroundStyle(Color.descriptionGray)
    static let dummyCafePointText = Text("구매가능 포인트 330P").foregroundStyle(Color.descriptionGray)
    static let dummyCafeStampText = Text("구매가능 스탬프 2개 쿠폰 0개").foregroundStyle(Color.descriptionGray)
    static let dummyCafeHeartCountText = Text("1234").foregroundStyle(Color.heartOrange)
    static let dummyCafeStoryCountText = Text("5678").foregroundStyle(Color.storyNavy)
    static let dummyCafePickUpTimeText = Text("5분 후 수령").foregroundStyle(Color.pickUpOrange)
    static let dummyCafeOrderCountText = Text("주분수 39,448").foregroundStyle(Color.cartGray)

    static let preparingCafe = Text("준비 중").foregroundStyle(Color.preparingGray)
}


#Preview {
    SmallCafeListCell(
        cafeListType: .story,
        cafeOperationStatus: .open,
        imageWidth: 100
    )
}
