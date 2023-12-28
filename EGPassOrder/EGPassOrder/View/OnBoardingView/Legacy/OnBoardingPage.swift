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
        if isLast == false {
            backgroundImage.resizable().scaledToFit()
        } else {
            ZStack {
                backgroundImage.resizable().scaledToFit()

                HStack {
                    Button(action: {

                    }, label: {
                        Text("패스오더 시작할게요!")
                            .font(.system(size: 20))
                            .tint(.black)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 1)
                                )
                    })
                    .background(.white)
                    .offset(x: 32, y: -10)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OnBoardingPage(backgroundImage: Image("OnBoardingView/page_4"))
}
