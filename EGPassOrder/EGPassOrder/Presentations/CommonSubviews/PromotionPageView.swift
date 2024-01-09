//
//  PromotionPageView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/9/24.
//

import SwiftUI

struct PromotionPageView: View {
    @State var imageList: [Image]
    let height: CGFloat
    private var isVisible: Bool { 0 < imageList.count }

    @State private var imageIndex: Int = 0
    private let timerInterval: TimeInterval = 2.0

    var body: some View {
        if isVisible == false {
            EmptyView()
        } else {
            TabView(selection: $imageIndex) {
                ForEach(imageList.indices, id: \.self) { index in
                    let page = imageList[index]
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

                        if isVisible == true {
                            Text("\(imageIndex + 1)/\(imageList.count)")
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

        _ = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                imageIndex = (imageIndex + 1) % imageList.count
            }
        }
    }
}


#Preview {
    PromotionPageView(
        imageList: [
            Image(systemName: "1.square.fill"),
            Image(systemName: "2.square.fill"),
            Image(systemName: "3.square.fill"),
            Image(systemName: "4.square.fill")

        ],
        height: 100
    )
}
