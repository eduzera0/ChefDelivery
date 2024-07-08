//
//  StoresContainerView.swift
//  ChefDelivery
//
//  Created by Eduardo Moretto on 04/07/24.
//

import SwiftUI

struct StoresContainerView: View {
    
    let title = "Lojas"
    var stores: [StoreType]
    @State private var ratingFilter = 0
    @State private var distanceFilterMin: Double = 0
    @State private var distanceFilterMax: Double = 100
    
    var filteredStores: [StoreType] {
        return stores.filter { store in
            store.stars >= ratingFilter && (store.distance >= distanceFilterMin && store.distance <= distanceFilterMax)
        }
    }
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Menu("Distância") {
                    Button(action: {
                        distanceFilterMin = 0
                        distanceFilterMax = 100
                    }, label: {
                        Text("Limpar filtro")
                    })
                    
                    Divider()
                    
                    ForEach(Array(stride(from: 0, through: 15, by: 5)), id: \.self) { value in
                        Button {
                            distanceFilterMin = Double(value)
                            distanceFilterMax = Double(value + 5)
                        } label: {
                                Text("De \(value)km a \(value + 5)km")
                        }
                    }
                }
                .foregroundColor(.black)
                
                Menu("Filtrar") {
                    
                    Button(action: {
                        ratingFilter = 0
                    }, label: {
                        Text("Limpar filtro")
                    })
                    
                    Divider()
                    
                    ForEach(1...5, id: \.self) { rating in
                        Button {
                            ratingFilter = rating
                        } label: {
                            if rating > 1 {
                                Text("\(rating) estrelas ou mais")
                            } else {
                                Text("\(rating) estrela ou mais")
                            }
                        }
                    }
                }
                .foregroundColor(.black)
            }
            
            VStack(alignment: .leading, spacing: 30) {
                
                if filteredStores.isEmpty {
                    Text("Nenhum resultado encontrado.")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.colorRed)
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity)
                } else {
                    ForEach(filteredStores) { mock in
                        NavigationLink {
                            StoreDetailView(store: mock)
                        } label: {
                            StoreItemView(store: mock)
                        }
                    }
                }
             
            }
            .foregroundColor(.black)
        }
        .padding(20)
    }
}

#Preview {
    StoresContainerView(stores: storesMock).previewLayout(.sizeThatFits)
}
