//
//  FeedbackView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/22/24.
//

import SwiftUI

struct FeedbackView: View {
    var body: some View {
        VStack(spacing: .zero) {
            TopDividerView()
            PassOrderFeedbackView()
            Divider()
            ReferralView()
        }
    }
}


// MARK: - Subview: DividerView
private struct TopDividerView: View {
    var body: some View {
        Color.gray.frame(height: 8)
    }
}


// MARK: - Subview: PassOrderFeedbackView
private struct PassOrderFeedbackView: View {
    var body: some View {
        NavigationLink(
            // TODO; Add Destination View
            destination: { EmptyView() },
            label: {
                HStack(spacing: 16) {
                    Image.magnifier

                    VStack(alignment: .leading) {
                        HStack {
                            Text.passOrderFeedbackTitle
                            Image.chevronRightGray
                        }

                        Text.passOrderFeedbackDescription
                    }

                    Spacer()
                }
                .padding()
            }
        )
    }
}


// MARK: - Subview: ReferralView
private struct ReferralView: View {
    var body: some View {
        NavigationLink(
            // TODO; Add Destination View
            destination: { EmptyView() },
            label: {
                HStack(spacing: 16) {
                    Image.referralMail

                    VStack(alignment: .leading) {
                        HStack {
                            Text.referralTitle
                            Image.chevronRightGray
                        }

                        Text.referralDescription
                    }

                    Spacer()
                }
                .padding()
            }
        )
    }
}


// MARK: - Extension: Color
fileprivate extension Color {
    static let titleBlack = Color.black
    static let descriptionGray = Color.gray
}


// MARK: - Extension: Image
fileprivate extension Image {
    // Icons
    static let chevronRightGray = Image("HomeScene/Subviews/FeedbackView/chevronRightGray")
    static let magnifier = Image("HomeScene/Subviews/FeedbackView/magnifierIcon")
    static let referralMail = Image("HomeScene/Subviews/FeedbackView/mailIcon")
}


// MARK: - Extension: Text
fileprivate extension Text {
    static let passOrderFeedbackTitle = Text("패스오더와 더 친해지기").font(.title3).foregroundStyle(Color.titleBlack)
    static let passOrderFeedbackDescription = Text("패써님이 궁금하신 점 전부 답변해 드릴게요!").foregroundStyle(Color.descriptionGray)
    static let referralTitle = Text("친구에게 패스오더 알려주기").font(.title3).foregroundStyle(Color.titleBlack)
    static let referralDescription = Text("친구와 똑똑한 주문하고, 혜택도 챙겨가세요").foregroundStyle(Color.descriptionGray)
}


#Preview {
    FeedbackView()
}
