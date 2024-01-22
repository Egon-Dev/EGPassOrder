//
//  CafeListCellConfigurable.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/15/24.
//

import SwiftUI

protocol CafeListCellConfigurable {
    var cafeOperationStatus: CafeOperationStatus { get }
    var cafeImage: Image? { get set }
    var imageWidth: CGFloat { get }
    static var imageAspectRatio: CGFloat { get }
}
