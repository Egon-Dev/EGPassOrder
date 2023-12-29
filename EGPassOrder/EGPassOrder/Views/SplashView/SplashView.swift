//
//  SplashView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 12/29/23.
//

import Lottie
import SwiftUI

struct SplashView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.splashIndigo.edgesIgnoringSafeArea(.all)

                VStack {
                    SplashLogoView(image: Image.splashLogoImage, proxy: proxy)
                    SplashAnimationView(animation: Lottie.coffee.animation)
                        .frame(
                            width: proxy.size.width * SplashAnimationView.widthRatio,
                            height: proxy.size.height * SplashAnimationView.heightRatio
                        )
                    SplashCIView(image: Image.splashCIImage, proxy: proxy)
                }
            }
        }
    }

    private struct SplashLogoView: View {
        var image: Image
        var proxy: GeometryProxy
        private let widthRatio = 0.7

        var body: some View {
            VStack {
                Spacer()
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width * widthRatio)
                Spacer()
            }
        }
    }

    private struct SplashAnimationView: UIViewRepresentable {
        var animation: LottieAnimation?
        static let widthRatio = 0.4
        static let heightRatio = 0.2

        func makeUIView(context: Context) -> some UIView {
            let view = UIView()
            let animationView = LottieAnimationView()
            animationView.animation = animation
            animationView.animationSpeed = 2.0
            animationView.loopMode = .loop
            animationView.contentMode = .scaleAspectFit
            animationView.play()

            animationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView)
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])

            return view
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }

    private struct SplashCIView: View {
        var image: Image
        var proxy: GeometryProxy
        private let widthRatio = 0.5

        var body: some View {
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: proxy.size.width * widthRatio)
        }
    }
}


#Preview {
    SplashView()
}


// MARK: - Colors
fileprivate extension Color {
    static let splashIndigo = Color("SplashView/indigo")
}


// MARK: - Images
fileprivate extension Image {
    static let splashLogoImage = Image("SplashView/SplashImage")
    static let splashCIImage = Image("SplashView/SplashCI")
}


// MARK: - Lottie
fileprivate enum Lottie {
    case coffee

    var animation: LottieAnimation? {
        return LottieAnimation.named(self.fileName)
    }

    private var fileName: String {
        switch self {
        case .coffee:
            return "LottieCoffeeAnimation"
        }
    }
}
