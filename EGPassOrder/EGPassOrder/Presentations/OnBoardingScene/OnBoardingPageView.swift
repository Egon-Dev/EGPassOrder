//
//  OnBoardingPageView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/28/23.
//

import SwiftUI

struct OnBoardingPageView: View {
    var pageImages: [Image]
    private var lastIndex: Int { pageImages.count - 1 }
    @State private var currentPageIndex = 0

    var body: some View {
        let resizedPages = pageImages.enumerated().map { offset, image in
            OnBoardingPage(isLast: offset == pageImages.count - 1, backgroundImage: image)
        }

        VStack {
            OnBoardingPageViewController(pages: resizedPages, currentPageIndex: $currentPageIndex)
            OnBoardingPageControl(numberOfPages: resizedPages.count, currentPageIndex: $currentPageIndex)
                .frame(width: CGFloat(pageImages.count * 18))
                .padding()
        }
        .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    OnBoardingPageView(pageImages: [
        Image("OnBoardingScene/page_1"),
        Image("OnBoardingScene/page_2"),
        Image("OnBoardingScene/page_3"),
        Image("OnBoardingScene/page_4")
    ])
}
