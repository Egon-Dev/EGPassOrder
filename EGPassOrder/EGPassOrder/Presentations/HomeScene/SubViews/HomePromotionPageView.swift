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


#Preview {
    HomePromotionPageView()
}
