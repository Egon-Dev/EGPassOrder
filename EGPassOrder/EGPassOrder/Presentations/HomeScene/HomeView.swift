//
//  HomeView.swift
//  EGPassOrder
//
//  Created by lymchgmk on 1/1/24.
//

import NMapsMap
import SwiftUI

struct HomeView: View {
    @State var selectedTabIndex: Int = 1
    @State var isDropdownVisible = false

    var body: some View {
        VStack {
            HomeSearchBarView(isDropdownVisible: $isDropdownVisible)
                .zIndex(1)
                .padding(.horizontal)
            HomeTabBarView(selectedTabIndex: $selectedTabIndex, spacing: 20, height: 40)
                .padding(.horizontal)
            
            if selectedTabIndex == .zero {
                OrderByListView()
            } else {
                OrderByMapView()
            }

            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            withAnimation {
                isDropdownVisible = false
            }
        }
    }
}


fileprivate struct OrderByListView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HomePromotionPageView()
                .frame(height: 100)
                .padding()
            HomeNearbyShopListView()
            HomePointShopListView()
            HomePassOrderAdView()
                .frame(width: .infinity, height: 100)
                .padding()
            HomeStoryShopListView()
            HomeDrinkAndGoShopListView()
            HomeNewShopListView()
        }
    }
}

fileprivate struct OrderByMapView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                NaverMapView()
                ShopListTapView()
                    .frame(height: 150)
            }
            .onAppear {
                NaverMapCoordinator.shared.checkIfLocationServiceIsEnabled()
            }
        }
        
    }

    struct NaverMapView: UIViewRepresentable {
        func makeCoordinator() -> NaverMapCoordinator {
            NaverMapCoordinator.shared
        }

        func makeUIView(context: Context) -> NMFNaverMapView {
            let naverMapCoordinator = context.coordinator
            let naverMapView = naverMapCoordinator.getNaverMapView()

            return naverMapView
        }

        func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
    }

    final class NaverMapCoordinator: NSObject,
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

            view.mapView.zoomLevel = 15 // 기본 맵이 표시될때 줌 레벨
            view.mapView.minZoomLevel = 1 // 최소 줌 레벨
            view.mapView.maxZoomLevel = 17 // 최대 줌 레벨

            view.showLocationButton = false // 현위치 버튼: 위치 추적 모드를 표현합니다. 탭하면 모드가 변경됩니다.
            view.showZoomControls = false // 줌 버튼: 탭하면 지도의 줌 레벨을 1씩 증가 또는 감소합니다.
            view.showCompass = false //  나침반 : 카메라의 회전 및 틸트 상태를 표현합니다. 탭하면 카메라의 헤딩과 틸트가 0으로 초기화됩니다. 헤딩과 틸트가 0이 되면 자동으로 사라집니다
            view.showScaleBar = false // 스케일 바 : 지도의 축척을 표현합니다. 지도를 조작하는 기능은 없습니다.

            view.mapView.addCameraDelegate(delegate: self)
            view.mapView.touchDelegate = self
        }

        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
            // 카메라 이동이 시작되기 전 호출되는 함수
        }

        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
            // 카메라의 위치가 변경되면 호출되는 함수
        }

        // MARK: - 위치 정보 동의 확인

        /*
         ContetView 에서 .onAppear 에서 위치 정보 제공을 동의 했는지 확인하는 함수를 호출한다.
         위치 정보 제공 동의 순서
         1. MapView에서 .onAppear에서 checkIfLocationServiceIsEnabled() 호출
         2. checkIfLocationServiceIsEnabled() 함수 안에서 locationServicesEnabled() 값이 true인지 체크
         3. true일 경우(동의한 경우), checkLocationAuthorization() 호출
         4. case .authorizedAlways(항상 허용), .authorizedWhenInUse(앱 사용중에만 허용) 일 경우에만 fetchUserLocation() 호출
         */

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

        // MARK: - NMFMapView에서 제공하는 locationOverlay를 현재 위치로 설정
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

        // 마커 부분의 lat lng를 init 부분에 호출해서 사용하면 바로 사용가능하지만
        // 파이어베이스 연동의 문제를 생각해서 받아오도록 만들었습니다.

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

#Preview {
    HomeView()
}
