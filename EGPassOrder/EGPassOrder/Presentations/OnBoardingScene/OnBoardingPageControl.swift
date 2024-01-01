//
//  OnBoardingPageControl.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/28/23.
//

import SwiftUI
import UIKit

struct OnBoardingPageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPageIndex: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(control: self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.pageIndicatorTintColor = Color.onBoardingIndigo.uiColor
        control.currentPageIndicatorTintColor = Color.onBoardingOrange.uiColor
        control.numberOfPages = numberOfPages
        control.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}

extension OnBoardingPageControl {
    class Coordinator: NSObject {
        var control: OnBoardingPageControl

        init(control: OnBoardingPageControl) {
            self.control = control
        }

        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPageIndex = sender.currentPage
        }
    }
}


// MARK: - Colors
fileprivate extension Color {
    static let onBoardingIndigo = Color("OnBoardingView/indigo")
    static let onBoardingOrange = Color("OnBoardingView/orange")

    var uiColor: UIColor {
        return UIColor(self)
    }
}
