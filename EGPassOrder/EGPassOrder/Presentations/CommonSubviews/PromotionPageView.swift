//
//  PromotionPageView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/9/24.
//

import SwiftUI

struct PromotionPageView<Page: View>: View {
    @State private var pageList: [Page]
    @State private var pageIndex: Int = .zero
    @State var isVisible: Bool = true
    private let height: CGFloat
    private let timerInterval: TimeInterval

    init(pageList: [Page], height: CGFloat, timerInterval: TimeInterval = 3.0) {
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
                    page.tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: height)
            .overlay {
                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        PageIndicatorView(
                            pageIndex: $pageIndex,
                            pageList: $pageList,
                            isVisible: $isVisible
                        )
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
                }
            }
            .onAppear {
                startTimer()
            }
            .background(.red)
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


private struct PageIndicatorView<Page: View>: View {
    @Binding var pageIndex: Int
    @Binding var pageList: [Page]
    @Binding var isVisible: Bool

    var body: some View {
        if isVisible == false {
            EmptyView()
        } else {
            Text("\(pageIndex + 1)/\(pageList.count)")
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 2)
                .overlay {
                    Color.cyan
                        .opacity(0.25)
                        .clipShape(.rect(cornerRadius: 18))
                }
        }
    }
}



#Preview {
    PromotionPageView(
        pageList: [
            Image(systemName: "1.square.fill"),
            Image(systemName: "2.square.fill"),
            Image(systemName: "3.square.fill"),
            Image(systemName: "4.square.fill")

        ],
        height: 100
    )
}
