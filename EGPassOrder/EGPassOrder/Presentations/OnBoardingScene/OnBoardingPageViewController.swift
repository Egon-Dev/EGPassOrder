//
//  OnBoardingPageViewController.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/28/23.
//

import SwiftUI
import UIKit

struct OnBoardingPageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPageIndex: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageVC = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageVC.dataSource = context.coordinator
        pageVC.delegate = context.coordinator

        return pageVC
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers(
            [context.coordinator.controllers[currentPageIndex]],
            direction: .forward,
            animated: true
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension OnBoardingPageViewController {
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: OnBoardingPageViewController
        var controllers: [UIViewController] = []

        init(_ pageVC: OnBoardingPageViewController) {
            parent = pageVC
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }

            if index == 0 {
                return nil
            } else {
                return controllers[index - 1]
            }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }

            if index == controllers.count - 1 {
                return nil
            } else {
                return controllers[index + 1]
            }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPageIndex = index
            }
        }
    }
}
