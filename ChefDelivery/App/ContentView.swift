//
//  ContentView.swift
//  ChefDelivery
//
//  Created by Eduardo Moretto on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    
    private var service = HomeService()
    @State private var storesType: [StoreType] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                } else {
                    NavigationBar()
                        .padding(.horizontal, 15)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            OrderTypeGridView()
                            CarouselTabView()
                            StoresContainerView(stores: storesType)
                        }
                    }
                }
                
            }
        }
        .onAppear {
            Task {
                await getStores()
            }
//            getStoresWithAlomofire()
        }
    }
    
    func getStores() async {
        do {
            let result = try await service.fetchData()
            switch result {
            case .success(let stores):
                self.storesType = stores
                self.isLoading = false
                break
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
            }
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }
    
//    func getStoresWithAlomofire() {
//        service.fetchDataWithAlomofire { stores, error in
//            print(stores)
//        }
//    }
    
}

#Preview {
    ContentView()
}
