//
//  OnBoardingPage.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/28/23.
//

import SwiftUI

struct OnBoardingPage: View {
    var isLast: Bool = false
    var backgroundImage: Image

    var body: some View {
        VStack {
            backgroundImage.resizable().scaledToFit()
            Button(action: {

            }, label: {
                Text("패스오더 시작할게요!")
                    .font(.system(size: 16))
                    .padding()
                    .tint(Color.onBoardingOrange)
                    .fontWeight(.bold)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.onBoardingOrange, lineWidth: 1.5)
                    )
                }
            )
            .padding()
            .disabled(isLast == false)
            .opacity(isLast ? 1 : 0)
        }
    }
}

#Preview {
    OnBoardingPage(backgroundImage: Image("OnBoardingView/page_4"))
}


// MARK: - Colors
fileprivate extension Color {
    static let onBoardingOrange = Color("OnBoardingView/orange")

    var uiColor: UIColor {
        return UIColor(self)
    }
}
