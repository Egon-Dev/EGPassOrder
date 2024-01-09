//
//  FavoriteCafeView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/9/24.
//

import SwiftUI

struct FavoriteCafeView: View {
    @State var protomotionImages: [Image]

    var body: some View {
        VStack {
            Text("자주가요")
                .font(.title)
        }
    }
}


#Preview {
    FavoriteCafeView(protomotionImages: [])
}
