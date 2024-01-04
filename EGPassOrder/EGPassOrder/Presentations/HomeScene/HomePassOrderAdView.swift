//
//  HomePassOrderAdView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/2/24.
//

import SwiftUI

struct HomePassOrderAdView: View {
    @State private var selectedPageIndex: Int = 0
    @State private var currentOpacity: Double = 1.0
    let pages = ["첫 번째 화면", "두 번째 화면", "세 번째 화면"]
    let timerInterval: TimeInterval = 2.0
    
    var body: some View {
        GeometryReader { proxy in
            Text("Ad \(selectedPageIndex)")
                .font(.title)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                .opacity(currentOpacity)
                .animation(.easeInOut, value: Int.zero)
                .onAppear {
                    // 뷰가 나타날 때 타이머 시작
                    startTimer()
                }
        }
        .background(.cyan)
    }

    private func nextPage() {
        // 다음 페이지로 이동하는 메서드
        withAnimation {
            selectedPageIndex = (selectedPageIndex + 1) % pages.count
            currentOpacity = 1.0 // 페이지 전환 시 투명도를 1로 초기화
        }
    }

    private func startTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                selectedPageIndex = (selectedPageIndex + 1) % 3
            }
        }
    }
}

#Preview {
    HomePassOrderAdView()
}
