//
//  HomePromotionPageView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct HomePromotionPageView: View {
    @State private var selectedPageIndex: Int = 0
    let timerInterval: TimeInterval = 2.0
    // var height: CGFloat

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    TabView(selection: $selectedPageIndex) {
                        Text("Page 1")
                            .tag(0)
                        
                        Text("Page 2")
                            .tag(1)
                        
                        Text("Page 3")
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onAppear {
                        startTimer()
                    }
                    .background(.red)
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("\(selectedPageIndex + 1) / 3")
                            .padding()
                    }
                }
            }
            .background(.cyan)
        }
    }
    
    private func startTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                selectedPageIndex = (selectedPageIndex + 1) % 3
            }
        }
    }
}


//extension HomePromotionPageView {
//    struct PageViewController<Page: View>: UIViewControllerRepresentable {
//        var pages: [Page]
//        @Binding var selectedPageIndex: Int
//        
//        func makeUIViewController(context: Context) -> UIPageViewController {
//            let pageVC = UIPageViewController(
//                transitionStyle: .scroll,
//                navigationOrientation: .horizontal
//            )
//            pageVC.dataSource = context.coordinator
//            pageVC.delegate = context.coordinator
//
//            return pageVC
//        }
//        
//        func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
//            uiViewController.setViewControllers(
//                [context.coordinator.controllers[currentPageIndex]],
//                direction: .forward,
//                animated: true
//            )
//        }
//
//        func makeCoordinator() -> Coordinator {
//            Coordinator(self)
//        }
//    }
//    
//    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//        var parent: OnBoardingPageViewController
//        var controllers = [UIViewController]()
//        
//        init(_ pageVC: OnBoardingPageViewController) {
//            parent = pageVC
//            controllers = parent.pages.map { UIHostingController(rootView: $0) }
//        }
//        
//        func pageViewController(
//            _ pageViewController: UIPageViewController,
//            viewControllerBefore viewController: UIViewController
//        ) -> UIViewController? {
//            guard let index = controllers.firstIndex(of: viewController) else {
//                return nil
//            }
//            
//            if index == 0 {
//                return nil
//            } else {
//                return controllers[index - 1]
//            }
//        }
//        
//        func pageViewController(
//            _ pageViewController: UIPageViewController,
//            viewControllerAfter viewController: UIViewController
//        ) -> UIViewController? {
//            guard let index = controllers.firstIndex(of: viewController) else {
//                return nil
//            }
//            
//            if index == controllers.count - 1{
//                return nil
//            } else {
//                return controllers[index + 1]
//            }
//        }
//        
//        func pageViewController(
//            _ pageViewController: UIPageViewController,
//            didFinishAnimating finished: Bool,
//            previousViewControllers: [UIViewController],
//            transitionCompleted completed: Bool) {
//                if completed,
//                   let visibleViewController = pageViewController.viewControllers?.first,
//                   let index = controllers.firstIndex(of: visibleViewController) {
//                    parent.currentPageIndex = index
//                }
//            }
//    }
//}


#Preview {
    HomePromotionPageView()
}
