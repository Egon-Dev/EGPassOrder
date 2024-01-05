//
//  OrderDetailView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/5/24.
//

import SwiftUI
import UIKit


struct OrderDetailView: View {
    @State var promotionImageList: [Image]
    @State private var promotionCurrentPageIndex: Int = .zero
    @State private var pointByShopDate: Date = Date()
    @State private var isDatePickerVisible = false

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                TitleView()
                DatePickerButton(
                    pointByShopDate: $pointByShopDate,
                    isDatePickerVisible: $isDatePickerVisible
                )
                PromotionView<Image>(
                    pageList: $promotionImageList,
                    currentPageIndex: $promotionCurrentPageIndex
                )
                .frame(height: 120)
                PointByShopView()
                DescriptionView()
            }
        }
        .sheet(isPresented: $isDatePickerVisible) {
            DatePickerView(pickedDate: $pointByShopDate)
        }
    }
}


private struct TitleView: View {
    var body: some View {
        HStack {
            Text("주문내역")
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()
        }
    }
}


private struct DatePickerButton: View {
    @Binding var pointByShopDate: Date
    @Binding var isDatePickerVisible: Bool

    var body: some View {
        HStack {
            Button(action: {
                isDatePickerVisible.toggle()
            }, label: {
                HStack {
                    Text("\(pointByShopDate.formattedString(format: "yyyy년 MM월"))")
                        .font(.title3)
                        .tint(.black)
                    Image(systemName: "42.circle")
                }
            })

            Spacer()
        }
    }
}


private struct DatePickerView: View {
    @Binding var pickedDate: Date
    @State private var selectedYearIndex = 0
    @State private var selectedMonthIndex = 0

    let years = Array(2000...2030)
    let months = Array(1...12)

    var body: some View {
        VStack {
            Text("")

            HStack {
                Picker(selection: $selectedYearIndex, label: Text("Year")) {
                    ForEach(years.indices) {
                        let yearString = NumberFormatter.localizedString(from: NSNumber(value: years[$0]), number: .none)
                        Text("\(yearString)년")
                    }
                }
                .onChange(of: selectedYearIndex) { _, index in
                    pickedDate = pickedDate.update(with: .year, value: years[index])
                    pickedDate = pickedDate.update(with: .month, value: months[selectedMonthIndex])
                }
                .pickerStyle(.wheel)
                .padding(.leading)

                Picker(selection: $selectedMonthIndex, label: Text("Month")) {
                    ForEach(months.indices) {
                        Text("\(months[$0])월")
                    }
                }
                .onChange(of: selectedMonthIndex) { _, index in
                    pickedDate = pickedDate.update(with: .year, value: years[selectedYearIndex])
                    pickedDate = pickedDate.update(with: .month, value: index + 1)
                }
                .pickerStyle(.wheel)
                .padding(.trailing)
            }
         }
        .presentationDetents([.fraction(0.3)])
    }
}


private struct PromotionView<Page: View>: View {
    @Binding var pageList: [Page]
    @Binding var currentPageIndex: Int

    var body: some View {
        VStack(alignment: .leading) {
            PromotionPageViewController<Page>(
                pageList: $pageList,
                currentPageIndex: $currentPageIndex
            )
            PromotionPageControl(
                numberOfPages: pageList.count,
                currentPageIndex: $currentPageIndex
            )
        }
    }

    struct PromotionPage: View {
        var image: Image
        var body: some View {
            GroupBox(
                content: {
                    image
                }, label: {

                }
            )
        }
    }

    struct PromotionPageViewController<_Page: View>: UIViewControllerRepresentable {
        @Binding var pageList: [_Page]
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

        func updateUIViewController(
            _ uiViewController: UIPageViewController,
            context: Context
        ) {
            uiViewController.setViewControllers(
                [context.coordinator.controllers[currentPageIndex]],
                direction: .forward,
                animated: true
            )
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, 
                           UIPageViewControllerDataSource,
                           UIPageViewControllerDelegate {
            var parent: PromotionPageViewController
            var controllers: [UIViewController] = []

            init(_ pageVC: PromotionPageViewController) {
                parent = pageVC
                controllers = parent.pageList.map { UIHostingController(rootView: $0)
                }
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

                if index == controllers.count - 1{
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

    struct PromotionPageControl: UIViewRepresentable {
        var numberOfPages: Int
        @Binding var currentPageIndex: Int

        func makeUIView(context: Context) -> UIPageControl {
            let pageControl = UIPageControl()
            pageControl.pageIndicatorTintColor = Color.orderDetailGray.uiColor
            pageControl.currentPageIndicatorTintColor = Color.orderDetailOrange.uiColor
            pageControl.numberOfPages = numberOfPages
            pageControl.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)

            return pageControl
        }

        func updateUIView(_ uiView: UIPageControl, context: Context) {
            uiView.currentPage = currentPageIndex
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(control: self)
        }

        final class Coordinator: NSObject {
            var control: PromotionPageControl

            init(control: PromotionPageControl) {
                self.control = control
            }

            @objc
            func updateCurrentPage(sender: UIPageControl) {
                control.currentPageIndex = sender.currentPage
            }
        }
    }
}


private struct PointByShopView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {

            }, label: {
                HStack {
                    Text("매장별 적립 내역")
                        .font(.title3)
                        .tint(.black)
                    Image(systemName: "42.circle")

                    Spacer()
                }
            })
        }
    }
}


private struct DescriptionView: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}


// MARK: - Colors
fileprivate extension Color {
    static let orderDetailOrange = Color("OnBoardingScene/orange")
    static let orderDetailGray = Color.gray

    var uiColor: UIColor {
        return UIColor(self)
    }
}


// MARK: - Date Extension
fileprivate extension Date {
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    func update(with dateComponent: Calendar.Component, value: Int) -> Date {
        var components = Calendar.current.dateComponents([dateComponent], from: self)
        components.setValue(1, for: .day)
        components.setValue(value, for: dateComponent)
        return Calendar.current.date(from: components) ?? self
    }

    func formattedString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


// MARK: - Images
fileprivate extension Image {
    
}


#Preview {
    OrderDetailView(
        promotionImageList: [
            Image("OnBoardingScene/page_1"),
            Image("OnBoardingScene/page_2"),
            Image("OnBoardingScene/page_3"),
            Image("OnBoardingScene/page_4")
        ]
    )
}
