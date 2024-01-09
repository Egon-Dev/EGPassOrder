//
//  HomeCelebrationView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/9/24.
//

import SwiftUI

struct HomeCelebrationView: View {
    @State var isPromotionVisible: Bool = false

    var body: some View {
        VStack {
            CelebrationButtonView(isPromotionVisible: $isPromotionVisible)

            if isPromotionVisible == true {
                Divider()

                CelebrationPromotionView()
            }
        }
        .onTapGesture {
            withAnimation {
                isPromotionVisible.toggle()
            }
        }
    }
}


fileprivate struct CelebrationButtonView: View {
    @Binding var isPromotionVisible: Bool

    var body: some View {
        HStack {
            Image(systemName: "1.square.fill")
            Text("생일을 축하해주세요!")

            Spacer()

            Text("?명")
                // .tint(<#T##tint: Color?##Color?#>)
            Image(systemName: "2.square.fill")
                .rotationEffect(.degrees(isPromotionVisible ? 180 : 0))
        }
    }
}


fileprivate struct CelebrationPromotionView: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}


#Preview {
    HomeCelebrationView()
}
