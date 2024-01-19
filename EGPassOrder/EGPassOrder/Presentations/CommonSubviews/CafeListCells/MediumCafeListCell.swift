//
//  MediumCafeListCell.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/19/24.
//

import SwiftUI

struct MediumCafeListCell: View, CafeListCellConfigurable {
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
            // TODO: Add Destination View
            destination: { EmptyView() },
            label: {
                VStack(
                    alignment: .leading,
                    spacing: CGFloat.cellVerticalSpacing
                ) {
                    CafeImageView(
                        status: $cafeOperationStatus,
                        image: $cafeImage,
                        width: $imageWidth,
                        aspectRatio: Self.$imageAspectRatio
                    )

                    CafeDescriptionView(
                        status: $cafeOperationStatus,
                        width: $imageWidth
                    )
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
            } else {
                // FIXME: Remove Dummy
                Image.dummyCafeImage
                    .resizable()
                    .frame(width: width, height: height)
            }

            switch status {
            case .open:
                OpenedCafeImageOverlayView(
                    width: $width,
                    aspectRatio: $aspectRatio
                )
            case .phoneOrderOnly:
                PhoneOrderOnlyCafeImageOverlayView(
                    width: $width,
                    aspectRatio: $aspectRatio
                )
            case .preparing:
                PreparingCafeImageOverlayView(
                    width: $width,
                    aspectRatio: $aspectRatio
                )
            }
        }
        .frame(width: width, height: height)
        .clipShape(.rect(cornerRadius: CGFloat.cafeImageCornerRadius))
    }
}


// MARK: - Subview: CafeImageOverlayViews
fileprivate struct OpenedCafeImageOverlayView: View {
    @Binding var width: CGFloat
    @Binding var aspectRatio: CGFloat
    private var height: CGFloat { width * aspectRatio }

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
        .frame(width: width, height: height)
    }
}


fileprivate struct PhoneOrderOnlyCafeImageOverlayView: View {
    @Binding var width: CGFloat
    @Binding var aspectRatio: CGFloat

    var body: some View {
        // TODO: - Check Cases
        EmptyView()
    }
}


fileprivate struct PreparingCafeImageOverlayView: View {
    @Binding var width: CGFloat
    @Binding var aspectRatio: CGFloat

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

            Color.dimmedOverlayBlack

            VStack(alignment: .center) {
                Image.preparingClockImage
                Text.preparingDescription
            }
        }
    }
}


// MARK: - Subview: CellDescriptionView
fileprivate struct CafeDescriptionView: View {
    @Binding var status: CafeOperationStatus
    @Binding var width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            // FIXME: Remove Dummy
            // Cafe Name
            Text.dummyCafeNameTitle
                .lineLimit(Int.cafeNameLineLimit)
                .multilineTextAlignment(.leading)
            Text("")
                .frame(width: width)

            // Hearts & Stories
            HStack {
                Label {
                    Text.dummyHeartCount
                } icon: {
                    Image.heartOrangeFillIcon
                }
                
                Label {
                    Text.dummyStoryCount
                } icon: {
                    Image.storyNavyIcon
                }
            }
            
            // Pick Up or Preparing
            switch status {
            case .open:
                Label {
                    Text.dummyPickUpDescription
                } icon: {
                    Image.pickUpTimeIcon
                }
            case .phoneOrderOnly:
                EmptyView()
            case .preparing:
                Label {
                    Text.dummyPreparingDescription
                } icon: {
                    Image.pickUpTimeIcon
                        .renderingMode(.template)
                        .foregroundStyle(Color.preparingGray)
                }
            }
            
            // Distance
            Label {
                Text.dummyCafeDistance
            } icon: {
                Image.locationIcon
            }

            // Order Count
            Label {
                Text.dummyOrderCount
            } icon: {
                Image.cartIcon
                    .renderingMode(.template)
                    .foregroundStyle(Color.cartGray)
            }
        }
        .frame(maxWidth: width)
    }
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let cafeNameBlack = Color.black
    static let cartGray = Color.gray
    static let distanceGray = Color.gray
    static let heartOrange = Color("CommonSubviews/CafeListCells/orange")
    static let pickUpGray = Color.gray
    static let preparingWhite = Color.white
    static let preparingGray = Color.gray
    static let storyNavy = Color.indigo
    static let dimmedOverlayBlack = Color.black.opacity(0.5)
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let cellVerticalSpacing = CGFloat(12)
    static let defaultImageAspectRatio = CGFloat(240) / CGFloat(410)
    static let badgeHStackSpacing = CGFloat(4)
    static let badgeHStackPadding = CGFloat(8)
    static let cafeImageCornerRadius = CGFloat(4)
}


// MARK: - Extension: Image
fileprivate extension Image {
    // FIXME: Remove Dummy
    static let dummyCafeImage = Image("HomeScene/Subviews/NearbyCafeListView/defaultCafeImage")

    // Images
    static let preparingClockImage = Image("CommonSubviews/CafeListCells/preparingClockImage")

    // Icons
    static let heartOrangeFillIcon = Image("CommonSubviews/CafeListCells/heartOrangeFillIcon")
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
    static let dummyCafeNameTitle = Text("커피사피엔스 구로한영 캐슬시티점 aaaaa").font(.title3).foregroundStyle(Color.cafeNameBlack)
    static let dummyHeartCount = Text("123").foregroundStyle(Color.heartOrange)
    static let dummyStoryCount = Text("456").foregroundStyle(Color.storyNavy)
    static let dummyPickUpDescription = Text("5분 후 수령")
        .foregroundStyle(Color.heartOrange)
    static let dummyPreparingDescription = Text("준비 중")
        .foregroundStyle(Color.preparingGray)
    static let dummyCafeDistance = Text("120.0m").foregroundStyle(Color.distanceGray)
    static let dummyOrderCount = Text("주문수 \(1234.decimalString)").foregroundStyle(Color.cartGray)
    
    static let preparingDescription = Text("준비 중 입니다.").foregroundStyle(Color.preparingWhite)
    static let receiveNow = Text("지금 수령").foregroundStyle(Color.heartOrange)
}


#Preview {
    MediumCafeListCell(
        cafeOperationStatus: .open,
        imageWidth: 180
    )
}
