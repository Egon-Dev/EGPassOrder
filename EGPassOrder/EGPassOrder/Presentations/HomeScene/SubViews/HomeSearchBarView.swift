//
//  HomeSearchBarView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import SwiftUI

struct HomeSearchBarView: View {
    @Binding var isDropdownVisible: Bool

    var body: some View {
        VStack {
            HStack {
                ShopSearchButton()

                Spacer()

                LocationDropDownButton(isDropdownVisible: $isDropdownVisible)
            }
        }
    }
}


fileprivate struct ShopSearchButton: View {
    var body: some View {
        Button(
            action: {

            }, label: {
                Image.searchIcon
                Text("매장 검색")
                    .tint(Color.homeSceneGray)
            }
        )
    }
}


fileprivate struct LocationDropDownButton: View {
    @Binding var isDropdownVisible: Bool
    @State private var options: [(Image, Text)] = [
        (Image.locationIcon, Text("현재 위치")),
        (Image.settingIcon, Text("위치 설정하기"))
    ]

    var body: some View {
        Button(
            action: {
                withAnimation {
                    isDropdownVisible.toggle()
                }
            }, label: {
                HStack {
                    Text("현재 위치")
                        .fontWeight(.bold)
                    Image.arrowDownIcon
                        .rotationEffect(.degrees(isDropdownVisible ? 180 : 0))
                }
                .tint(Color.homeSceneWhite)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.homeSceneOrange))
            }
        )
        .overlayIf(
            isDropdownVisible,
            LocationDropDownView(isDropdownVisible: $isDropdownVisible, options: $options)
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
                                    .renderingMode(.template)
                                    .colorMultiply(Color.homeSceneGray)
                                options[index].1
                            }
                        }
                    )
                    .tint(Color.homeSceneGray)
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


// MARK: - Colors {
fileprivate extension Color {
    static let homeSceneWhite = Color.white
    static let homeSceneGray = Color.gray
    static let homeSceneOrange = Color("HomeScene/orange")
}


// MARK: - Images {
fileprivate extension Image {
    static let arrowDownIcon = Image("HomeScene/arrowDownIcon")
    static let locationIcon = Image("HomeScene/locationIcon")
    static let settingIcon = Image("HomeScene/settingIcon")
    static let searchIcon = Image("HomeScene/searchIcon")
}


//#Preview {
//    HomeSearchBarView(isDropdownVisible: false)
//}
