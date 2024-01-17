//
//  PromotionPageTabView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/15/24.
//

import SwiftUI

struct PromotionPageTabView: View {
    @State private var pageList: [PromotionPage]
    @State private var pageIndex: Int = .zero
    @State var isVisible: Bool = true
    private let height: CGFloat
    private let timerInterval: TimeInterval

    init(
        pageList: [PromotionPage],
        height: CGFloat,
        timerInterval: TimeInterval = TimeInterval.defaultFlipTime
    ) {
        self.pageList = pageList
        self.height = height
        self.timerInterval = timerInterval

        if pageList.isEmpty == true {
            isVisible = false
        }
    }

    var body: some View {
        if isVisible == false {
            EmptyView()
        } else {
            TabView(selection: $pageIndex) {
                ForEach(pageList.indices, id: \.self) { index in
                    let page = pageList[index]

                    GeometryReader { proxy in
                        NavigationLink(
                            destination: { AnyView(page.destinationView) },
                            label: {
                                page.pageImage
                                    .resizable()
                                    .frame(
                                        width: proxy.size.width,
                                        height: proxy.size.height
                                    )
                                    .scaledToFit()
                                    .background(.cyan)
                            }
                        )
                        .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: height)
            .overlay {
                GeometryReader { proxy in
                    PageIndicatorView(
                        pageIndex: $pageIndex,
                        pageList: $pageList,
                        isVisible: $isVisible
                    )
                    .position(
                        x: proxy.size.width - CGFloat.indicatorTrailingMargin,
                        y: proxy.size.height - CGFloat.indicatorBottomMargin
                    )
                }
            }
            .onAppear {
                startTimer()
            }
        }
    }

    private func startTimer() {
        guard isVisible == true else { return }

        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                incrementPageIndex()
            }
        }
    }

    private func incrementPageIndex() {
        pageIndex = (pageIndex + 1) % pageList.count
    }
}


// MARK: - Subview: Indicator
private struct PageIndicatorView<Page>: View {
    @Binding var pageIndex: Int
    @Binding var pageList: [Page]
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible == false {
            EmptyView()
        } else {
            Text("\(pageIndex + 1)/\(pageList.count)")
                .foregroundStyle(Color.indicatorTextWhite)
                .padding(.horizontal, CGFloat.indicatorHorizontalPadding)
                .padding(.vertical, CGFloat.indicatorVerticalpadding)
                .background(
                    Color.indicatorBackgroundGray
                        .clipShape(.rect(cornerRadius: CGFloat.indicatorCornerRadius))
                )
        }
    }
}


// MARK: - Model: PromotionPage
struct PromotionPage {
    let pageImage: Image
    let destinationView: any View
}


// MARK: - Extension: TimeInterval
fileprivate extension TimeInterval {
    static let defaultFlipTime = 3.0
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let indicatorTrailingMargin = 36.0
    static let indicatorBottomMargin = 20.0
    static let indicatorHorizontalPadding = 12.0
    static let indicatorVerticalpadding = 2.0
    static let indicatorCornerRadius = 18.0
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let indicatorTextWhite = Color.white
    static let indicatorBackgroundGray = Color.gray.opacity(0.4)
}


// MARK: - Extension: Image
fileprivate extension Image {
    // FIXME: Remove Dummy
    static let promotionImage_1 = Image("CommonSubviews/PromotionPageTabView/image_1")
    static let promotionImage_2 = Image("CommonSubviews/PromotionPageTabView/image_2")
    static let promotionImage_3 = Image("CommonSubviews/PromotionPageTabView/image_3")
    static let promotionImage_4 = Image("CommonSubviews/PromotionPageTabView/image_4")
    static let promotionImage_5 = Image("CommonSubviews/PromotionPageTabView/image_5")
    static let promotionImage_6 = Image("CommonSubviews/PromotionPageTabView/image_6")
    static let promotionImage_7 = Image("CommonSubviews/PromotionPageTabView/image_7")
    static let promotionImage_8 = Image("CommonSubviews/PromotionPageTabView/image_8")
    static let promotionImage_9 = Image("CommonSubviews/PromotionPageTabView/image_9")
    static let promotionImage_10 = Image("CommonSubviews/PromotionPageTabView/image_10")
    static let promotionImage_11 = Image("CommonSubviews/PromotionPageTabView/image_11")
    static let promotionImage_12 = Image("CommonSubviews/PromotionPageTabView/image_12")
    static let promotionImage_13 = Image("CommonSubviews/PromotionPageTabView/image_13")
}

// FIXME: Remove Dummy
public extension Image {
    static let dummyImageList: [Image] = [
        Image.promotionImage_1,
        Image.promotionImage_2,
        Image.promotionImage_3,
        Image.promotionImage_4,
        Image.promotionImage_5,
        Image.promotionImage_6,
        Image.promotionImage_7,
        Image.promotionImage_8,
        Image.promotionImage_9,
        Image.promotionImage_10,
        Image.promotionImage_11,
        Image.promotionImage_12,
        Image.promotionImage_13
    ]
}


// MARK: - PREVIEW
#Preview {
    PromotionPageTabView(
        pageList: Image.dummyImageList
            .enumerated()
            .map { index, image in
                PromotionPage(pageImage: image, destinationView: Text("ImageIndex: \(index)"))
        },
        height: 120
    )
}
