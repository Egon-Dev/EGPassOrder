//
//  ShopListCellConfigurable.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/4/24.
//

import Foundation

protocol ShopListCellConfigurable {
    var imageWidth: CGFloat { get }
    static var imageAspectRatio: CGFloat { get }
}
