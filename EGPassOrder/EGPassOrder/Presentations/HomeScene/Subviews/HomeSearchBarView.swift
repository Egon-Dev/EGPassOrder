//
//  HomeSearchBarView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/23/24.
//

import SwiftUI

struct HomeSearchBarView: View {
    @Binding var isDropdownVisible: Bool

    var body: some View {
        VStack {
            HStack(
                alignment: .center,
                spacing: CGFloat.searchBarHorizontalSpacing
            ) {
                ShopSearchBarButton()

                Spacer()

                LocationDropDownButton(isDropdownVisible: $isDropdownVisible)
            }
        }
    }
}


fileprivate struct ShopSearchBarButton: View {
    var body: some View {
        Button(
            action: {

            }, label: {
                HStack {
                    Image.searchIcon
                    Text.searchBarPlaceholder

                    Spacer()
                }
                .padding(.horizontal, CGFloat.searchBarHorizontalPadding)
                .padding(.vertical, CGFloat.searchBarVertialPadding)
                .background(Color.searchBarBackgroundGray)
            }
        )
    }
}


fileprivate struct LocationDropDownButton: View {
    @Binding var isDropdownVisible: Bool
    @State private var options: [(Image, Text)] = [
        (Image.currentLocationIcon, Text("현재 위치")),
        (Image.configureLocationIcon, Text("위치 설정하기"))
    ]

    var body: some View {
        Button(
            action: {
                withAnimation {
                    isDropdownVisible.toggle()
                }
            }, label: {
                HStack {
                    Text.dropdownTitle
                    Image.dropdownIcon
                        .rotationEffect(.degrees(isDropdownVisible ? 180 : 0))
                }
                .background(Color.dropdownBackgroundWhite)
            }
        )
        .overlayIf(
            isDropdownVisible == true,
            LocationDropDownView(
                isDropdownVisible: $isDropdownVisible,
                options: $options
            )
            .offset(y: 60),
            alignment: .trailingFirstTextBaseline
        )
    }


    struct LocationDropDownView: View {
        @Binding var isDropdownVisible: Bool
        @Binding var options: [(Image, Text)]

        var body: some View {
            VStack(alignment: .trailing) {
                ForEach(options.indices, id: \.self) { index in
                    Button(
                        action: {
                            withAnimation {
                                isDropdownVisible.toggle()
                            }
                        }, label: {
                            HStack {
                                options[index].0
                                options[index].1
                            }
                        }
                    )
                    .padding(12)
                }
            }
            .frame(width: 160)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 5)
            .padding(.top, 200)
        }
    }
}


// MARK: - View Modifiers
fileprivate extension View {
    @ViewBuilder func overlayIf<T: View>(
        _ condition: Bool,
        _ content: T,
        alignment: Alignment = .center
    ) -> some View {
        if condition == true {
            self.overlay(content, alignment: alignment)
        } else {
            self
        }
    }
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let searchBarHorizontalPadding = CGFloat(12)
    static let searchBarHorizontalSpacing = CGFloat(8)
    static let searchBarVertialPadding = CGFloat(8)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let dropdownBackgroundWhite = Color.white
    static let dropdownTitleGray = Color("HomeScene/Subviews/HomeSearchBarView/dropdownTitleGray")
    static let searchBarBackgroundGray = Color("HomeScene/Subviews/HomeSearchBarView/searchBarBackgroundGray")
    static let searchBarPlaceholderGray = Color("HomeScene/Subviews/HomeSearchBarView/searchBarPlaceholderGray")
}


// MARK: - Extension: Image
fileprivate extension Image {
    static let configureLocationIcon = Image("HomeScene/Subviews/HomeSearchBarView/configureLocationGrayIcon")
    static let currentLocationIcon = Image("HomeScene/Subviews/HomeSearchBarView/currentLocationGrayIcon")
    static let dropdownIcon = Image("HomeScene/Subviews/HomeSearchBarView/chevronDownGrayIcon")
    static let searchIcon = Image("HomeScene/Subviews/HomeSearchBarView/magnifierGrayIcon")
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let dropdownTitle = Text("현재 위치").foregroundStyle(Color.dropdownTitleGray)
    static let searchBarPlaceholder = Text("매장 검색").foregroundStyle(Color.searchBarPlaceholderGray)
}


#Preview {
    HomeSearchBarView(isDropdownVisible: .constant(true))
}
