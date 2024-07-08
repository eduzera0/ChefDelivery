//
//  StoreDetailView.swift
//  ChefDelivery
//
//  Created by Eduardo Moretto on 06/07/24.
//

import SwiftUI

struct StoreDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedProduct: ProductType?
    
    let store: StoreType
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                
                StoreDetailHeaderView(store: store)
                
                StoreDetailProductsView(products: store.products)
                
            }
        }
        .navigationTitle(store.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "cart")
                        
                        Text("Lojas")
                    }
                    .foregroundColor(.colorRed)
                })
            }
        }
    }
}


#Preview {
    StoreDetailView(store: storesMock[0])
}
