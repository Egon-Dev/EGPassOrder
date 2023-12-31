//
//  ColorExtension.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/29/23.
//

import SwiftUI

extension Color {
    static let onBoardingIndigo = Color("OnBoardingView/indigo")
    static let onBoardingOrange = Color("OnBoardingView/orange")

    var uiColor: UIColor {
        return UIColor(self)
    }
}
