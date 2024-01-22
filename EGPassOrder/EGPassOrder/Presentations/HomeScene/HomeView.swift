//
//  HomeView.swift
//  EGPassOrder
//
//  Created by changmuk.im@phoenixdarts.com on 1/15/24.
//

import NMapsMap
import SwiftUI

struct HomeView: View {
    @Binding var isMainTabBarVisible: Bool
    @State var selectedTabIndex: Int = .zero

    var body: some View {
        NavigationStack {
            VStack {
                HomeTopTabBarView(
                    selectedTabIndex: $selectedTabIndex,
                    spacing: CGFloat.topTabBarSpacing,
                    height: CGFloat.topTabBarHeight
                )

                if selectedTabIndex == .zero {
                    OrderByListView()
                        .onAppear {
                            isMainTabBarVisible = true
                        }
                } else {
                    OrderByMapView()
                        .onAppear {
                            isMainTabBarVisible = false
                        }
                        .ignoresSafeArea(edges: .bottom)
                }

                Spacer()
            }
        }
    }
}


// MARK: - Subview: OrderByListView
fileprivate struct OrderByListView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: CGFloat.subviewVerticalSpacing) {
                PromotionPageTabView(
                    pageList: Image.dummyImageList
                        .enumerated()
                        .map { index, image in
                            // FIXME: - Remove Dummy
                            PromotionPage(
                                pageImage: image,
                                destinationView: Text("ImageIndex: \(index)")
                            )
                    },
                    height: CGFloat.promotionPageTabViewHeight

                )
                .padding()

                NearbyCafeListView()

                PointCafeListView()

                AutoChangeAdvertiseView(
                    pageList: [Text("1"), Text("2"), Text("3")],
                    height: 120,
                    timerInterval: 2.0
                )
                .padding()

                StoryCafeListView()

                DineInCafeListView()

                NewCafeListView()

                FeedbackView()

                TermsOfServiceView()
            }
        }
    }
}


// MARK: - Subview: OrderByMapView
fileprivate struct OrderByMapView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                NaverMapView()
                ShopListTapView()
                    .frame(height: CGFloat.shopListHeight)
            }
            .onAppear {
                NaverMapCoordinator.shared.checkIfLocationServiceIsEnabled()
            }
        }
    }

    private struct NaverMapView: UIViewRepresentable {
        func makeCoordinator() -> NaverMapCoordinator {
            NaverMapCoordinator.shared
        }

        func makeUIView(context: Context) -> NMFNaverMapView {
            let naverMapCoordinator = context.coordinator
            let naverMapView = naverMapCoordinator.getNaverMapView()

            return naverMapView
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }

    private final class NaverMapCoordinator: NSObject,
                                             ObservableObject,
                                             NMFMapViewCameraDelegate,
                                             NMFMapViewTouchDelegate,
                                             CLLocationManagerDelegate {

            static let shared = NaverMapCoordinator()
            @Published var coord: (Double, Double) = (0.0, 0.0)
            @Published var userLocation: (Double, Double) = (0.0, 0.0)
            var locationManager: CLLocationManager?
            let startInfoWindow = NMFInfoWindow()
            private let view = NMFNaverMapView(frame: .zero)

            private override init() {
                super.init()

                view.mapView.positionMode = .direction
                view.mapView.isNightModeEnabled = true

                view.mapView.zoomLevel = 15
                view.mapView.minZoomLevel = 1
                view.mapView.maxZoomLevel = 17

                view.showLocationButton = false
                view.showZoomControls = false
                view.showCompass = false
                view.showScaleBar = false

                view.mapView.addCameraDelegate(delegate: self)
                view.mapView.touchDelegate = self
            }

            func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {}

            func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {}

            func checkLocationAuthorization() {
                guard let locationManager = locationManager else { return }

                switch locationManager.authorizationStatus {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .restricted:
                    print("위치 정보 접근이 제한되었습니다.")
                case .denied:
                    print("위치 정보 접근을 거절했습니다. 설정에 가서 변경하세요.")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Success")

                    coord = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
                    userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))

                    fetchUserLocation()

                @unknown default:
                    break
                }
            }

            func checkIfLocationServiceIsEnabled() {
                DispatchQueue.global().async {
                    if CLLocationManager.locationServicesEnabled() {
                        DispatchQueue.main.async {
                            self.locationManager = CLLocationManager()
                            self.locationManager!.delegate = self
                            self.checkLocationAuthorization()
                        }
                    } else {
                        print("Show an alert letting them know this is off and to go turn i on")
                    }
                }
            }

            func fetchUserLocation() {
                if let locationManager = locationManager {
                    let lat = locationManager.location?.coordinate.latitude
                    let lng = locationManager.location?.coordinate.longitude
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0), zoomTo: 15)
                    cameraUpdate.animation = .easeIn
                    cameraUpdate.animationDuration = 1

                    let locationOverlay = view.mapView.locationOverlay
                    locationOverlay.location = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
                    locationOverlay.hidden = false

                    locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
                    locationOverlay.iconWidth = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
                    locationOverlay.iconHeight = CGFloat(NMF_LOCATION_OVERLAY_SIZE_AUTO)
                    locationOverlay.anchor = CGPoint(x: 0.5, y: 1)

                    view.mapView.moveCamera(cameraUpdate)
                }
            }

            func getNaverMapView() -> NMFNaverMapView {
                let locationButton = NMFLocationButton()
                view.addSubview(locationButton)
                locationButton.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    locationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                    locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])
                locationButton.mapView = view.mapView

                let phoneOrderShopSwitch = UISwitch()
                phoneOrderShopSwitch.onTintColor = .orange
                let phoneOrderShopLabel = UILabel()
                phoneOrderShopLabel.text = "전화주문 매장 보기"
                phoneOrderShopLabel.font = .systemFont(ofSize: 14)
                let phoneOrderShopStackView = UIStackView(arrangedSubviews: [phoneOrderShopLabel, phoneOrderShopSwitch])
                phoneOrderShopStackView.axis = .horizontal
                phoneOrderShopStackView.alignment = .center
                phoneOrderShopStackView.spacing = 10
                phoneOrderShopStackView.backgroundColor = .white
                phoneOrderShopStackView.layer.borderColor = UIColor.lightGray.cgColor
                phoneOrderShopStackView.layer.borderWidth = 1
                phoneOrderShopStackView.layer.cornerRadius = 6
                view.addSubview(phoneOrderShopStackView)
                phoneOrderShopStackView.isLayoutMarginsRelativeArrangement = true
                phoneOrderShopStackView.layoutMargins = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
                phoneOrderShopStackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    phoneOrderShopStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    phoneOrderShopStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
                ])

                return view
            }

            func setMarker(lat : Double, lng:Double) {
                let marker = NMFMarker()
                marker.iconImage = NMF_MARKER_IMAGE_PINK
                marker.position = NMGLatLng(lat: lat, lng: lng)
                marker.mapView = view.mapView

                let infoWindow = NMFInfoWindow()
                let dataSource = NMFInfoWindowDefaultTextSource.data()
                dataSource.title = "서울특별시청"
                infoWindow.dataSource = dataSource
                infoWindow.open(with: marker)
            }
        }

        struct ShopListTapView: View {
            @State var selectedPageIndex: Int = .zero

            var body: some View {
                GeometryReader { proxy in
                    TabView(selection: $selectedPageIndex) {
                        Text("Page 1")
                            .tag(0)

                        Text("Page 2")
                            .tag(1)

                        Text("Page 3")
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .background(.red)
                }
            }
        }

}


// MARK: - Extension: CGFloat
fileprivate extension CGFloat {
    static let autoChangeAdvertiseViewHeight = CGFloat(120)
    static let promotionPageTabViewHeight = CGFloat(120)
    static let shopListHeight = CGFloat(150)
    static let subviewVerticalSpacing = CGFloat(20)
    static let topTabBarHeight = CGFloat(44)
    static let topTabBarSpacing = CGFloat(20)
}


// MARK: - PREVIEW
#Preview {
    HomeView(isMainTabBarVisible: .constant(true))
}
