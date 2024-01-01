//
//  OnBoardingPageView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/28/23.
//

import SwiftUI

struct OnBoardingPageView<Page: View>: View {
    private let pageImages: [Image] = [
        Image("OnBoardingView/page_1"),
        Image("OnBoardingView/page_2"),
        Image("OnBoardingView/page_3"),
        Image("OnBoardingView/page_4")
    ]
    @State private var currentPage = 0
    private var lastIndex: Int { pageImages.count - 1 }
    @State private var isPopoverPresented = false

    var body: some View {
        // let resizedPages = pageImages.map { OnBoardingPage(backgroundImage: $0) }
        let resizedPages = pageImages.enumerated().map { offset, image in
            OnBoardingPage(isLast: offset == pageImages.count - 1, backgroundImage: image)
        }

        VStack {
            OnBoardingPageViewController(pages: resizedPages, currentPageIndex: $currentPage)
                .onChange(of: currentPage) { newIndex in
                    if newIndex == lastIndex {
                        isPopoverPresented.toggle()
                    }
                }
            OnBoardingPageControl(numberOfPages: resizedPages.count, currentPageIndex: $currentPage)
                .frame(width: CGFloat(pageImages.count * 18))
                .padding()
        }
        .aspectRatio(contentMode: .fill)

        if currentPage == pageImages.count - 1 {
            Button(action: {

            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            .popover(isPresented: $isPopoverPresented, attachmentAnchor: .,content: {
                Text("POPOVER")
            })
        }
    }
}

#Preview {
    OnBoardingPageView<Image>()
}
