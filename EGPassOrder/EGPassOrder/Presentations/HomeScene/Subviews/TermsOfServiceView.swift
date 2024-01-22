//
//  TermsOfServiceView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/22/24.
//

import SwiftUI

struct TermsOfServiceView: View {
    @State private var isInformationVisible: Bool = false

    var body: some View {
        ZStack {
            Color.backgroundGray

            VStack(alignment: .leading, spacing: .zero) {
                InformationDropDownView(isInformationVisible: $isInformationVisible)

                if isInformationVisible == true {
                    InformationDescriptionView()
                }

                ToSNavigationListView()
                DescriptionView()
            }
            .padding()
        }
    }
}


// MARK: - Subview: InformationDropDownView
private struct InformationDropDownView: View {
    @Binding var isInformationVisible: Bool

    var body: some View {
        HStack {
            Image.passOrderLogo

            Spacer()

            Button(
                action: {
                    withAnimation(.easeInOut) {
                        isInformationVisible.toggle()
                    }
                }, label: {
                    Image.chevronDownGray
                        .renderingMode(.template)
                        .foregroundStyle(Color.chevronIndigo)
                        .rotationEffect(.degrees(isInformationVisible ? 180 : 0))
                }
            )
        }
    }
}


// MARK: - Subview: InformationDescriptionView
private struct InformationDescriptionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text.informationAddress
            Text.informationCEO + Text.informationSeparator + Text.informationCompanyRegistrationNumber
            Text.informationMailOrderNumber
            Text.informationServiceCompanyName
            Text.informationPhoneNumber + Text.informationSeparator + Text.informationEmail
            Text.informationOperationTime
        }
        .padding(.top)
    }
}


// MARK: - Subview: ToSNavigationListView
private struct ToSNavigationListView: View {
    enum NavigationItem: CaseIterable, Hashable {
        case termsOfUsage
        case termsOfPrivacy
        case businessInformation
        case termsOfPrivacyToThirdParties

        var text: Text {
            switch self {
            case .termsOfUsage:
                return Text.termsOfUsageText
            case .termsOfPrivacy:
                return Text.termsOfPrivacyText
            case .businessInformation:
                return Text.businessInformationText
            case .termsOfPrivacyToThirdParties:
                return Text.termsOfPrivacyToThirdPartiesText
            }
        }
        
        @ViewBuilder
        var destinationView: some View {
            // TODO: - Add Views
            switch self {
            case .termsOfUsage:
                Text("termsOfUsage")
            case .termsOfPrivacy:
                Text("termsOfPrivacy")
            case .businessInformation:
                Text("businessInformation")
            case .termsOfPrivacyToThirdParties:
                Text("termsOfPrivacyToThirdParties")
            }
        }
    }

    var body: some View {
        HStack {
            ForEach(NavigationItem.allCases, id: \.self) { item in
                NavigationLink(
                    destination: item.destinationView,
                    label: {
                        item.text
                            .lineLimit(Int.tosLabelLineLimit)
                    })

                if item != NavigationItem.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.vertical, CGFloat.tosVerticalPadding)
    }
}


// MARK: - Subview: DescriptionView
private struct DescriptionView: View {
    var body: some View {
        HStack {
            Text.passOrderToSDescription
                .lineSpacing(.zero)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }
}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let tosVerticalPadding = CGFloat(6)
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let backgroundGray = Color("HomeScene/Subviews/TermsOfServiceView/backgroundGray")
    static let chevronIndigo = Color("HomeScene/Subviews/TermsOfServiceView/chevronIndigo")
    static let descriptionIndigo = Color("HomeScene/Subviews/TermsOfServiceView/descriptionIndigo")
    static let informationIndigo = Color("HomeScene/Subviews/TermsOfServiceView/descriptionIndigo")
    static let informationGray = Color("HomeScene/Subviews/TermsOfServiceView/tosButtonGray")
    static let tosButtonGray = Color("HomeScene/Subviews/TermsOfServiceView/tosButtonGray")
}


// MARK: - Extension: Image
fileprivate extension Image {
    static let chevronDownGray = Image("HomeScene/Subviews/TermsOfServiceView/chevronDownGray")
    static let passOrderLogo = Image("HomeScene/Subviews/TermsOfServiceView/passOrderLogo")
}


// MARK: - Extension: Int
fileprivate extension Int {
    static let tosLabelLineLimit = Int(1)
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let passOrderToSDescription =
    Text("패스오더는 통신판매중개자이며, 통신판매의 당사자가 아닙니다.\n").font(.caption).foregroundStyle(Color.descriptionIndigo)
    + Text("따라서 패스오더는 상품거래 정보 및 거래에 대한 책임을 지지않습니다.").font(.caption).foregroundStyle(Color.descriptionIndigo)
    static let termsOfUsageText = Text("이용약관").font(.caption2).foregroundStyle(Color.tosButtonGray)
    static let termsOfPrivacyText = Text("개인정보 처리방침").font(.caption2).foregroundStyle(Color.tosButtonGray)
    static let businessInformationText = Text("사업자 정보확인").font(.caption2).foregroundStyle(Color.tosButtonGray)
    static let termsOfPrivacyToThirdPartiesText = Text("개인정보 제 3자 제공동의").font(.caption2).foregroundStyle(Color.tosButtonGray)

    // Informations
    static let informationAddress = Text("주소 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("부산광역시 부산진구 서면로 39, KT&G 상상마당 6층").font(.caption).foregroundStyle(Color.informationGray)
    static let informationCEO = Text("대표 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("곽수용").font(.caption).foregroundStyle(Color.informationGray)
    static let informationSeparator = Text(" | ").font(.caption).foregroundStyle(Color.informationIndigo)
    static let informationCompanyRegistrationNumber = Text("사업자등록번호 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("452-87-01123").font(.caption).foregroundStyle(Color.informationGray)
    static let informationMailOrderNumber = Text("통신판매번호 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("2018-부산해운대-0457").font(.caption).foregroundStyle(Color.informationGray)
    static let informationServiceCompanyName = Text("호스팅서비스제공자의 상호표시 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("(주) 페이타랩").font(.caption).foregroundStyle(Color.informationGray)
    static let informationPhoneNumber = Text("전화번호 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("1644-8725").font(.caption).foregroundStyle(Color.informationGray)
    static let informationEmail = Text("이메일 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("help@passorder.co.kr").font(.caption).foregroundStyle(Color.informationGray)
    static let informationOperationTime = Text("운영시간 : ").font(.caption).foregroundStyle(Color.informationIndigo)
    + Text("08:00 ~ 16:30").font(.caption).foregroundStyle(Color.informationGray)

}


#Preview {
    TermsOfServiceView()
}
