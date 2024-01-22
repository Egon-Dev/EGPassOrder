//
//  AutoChangeAdvertiseView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/18/24.
//

import SwiftUI

struct AutoChangeAdvertiseView<Page: View>: View {
    @State private var pageList: [Page]
    @State private var pageIndex = Int.defaultPageIndex
    @State private var pageOpacity: Double = CGFloat.pageVisibleOpacity
    @State var isVisible: Bool = true
    private let height: CGFloat
    private let timerInterval: TimeInterval

    init(
        pageList: [Page],
        height: CGFloat,
        timerInterval: TimeInterval = CGFloat.defaultTimeInterval
    ) {
        self.pageList = pageList
        self.height = height
        self.timerInterval = timerInterval
    }

    var body: some View {
        GeometryReader { proxy in
            pageList[pageIndex]
                .frame(width: proxy.size.width, height: height)
                .opacity(pageOpacity)
                .animation(.easeInOut, value: Int.zero)
                .onAppear {
                    Timer.scheduledTimer(
                        withTimeInterval: self.timerInterval,
                        repeats: true
                    ) { timer in
                        animatePageOutIn()
                    }
                }
        }
        .frame(height: height)
        // FIXME: Remove BG
        .background(.cyan)
    }

    private func animatePageOutIn() {
        withAnimation {
            pageOpacity = CGFloat.pageInvisibleOpacity

            DispatchQueue.main.asyncAfter(
                deadline: .now() + CGFloat.pageOpacityTimeInterval
            ) {
                pageIndex = (pageIndex + 1) % pageList.count
                withAnimation {
                    pageOpacity = CGFloat.pageVisibleOpacity
                }
            }
        }
    }
}


// MARK: - Extension: Int
fileprivate extension Int {
    static let defaultPageIndex = Int.zero
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let pageInvisibleOpacity = CGFloat.zero
    static let pageVisibleOpacity = CGFloat(1.0)
    static let defaultTimeInterval = CGFloat(1.0)
    static let pageOpacityTimeInterval = CGFloat(0.5)
}


#Preview {
    AutoChangeAdvertiseView(
        pageList: [Text("1"), Text("2"), Text("3")],
        height: 200,
        timerInterval: 2.0
    )
}
