//
//  HomeService.swift
//  ChefDelivery
//
//  Created by Eduardo Moretto on 06/07/24.
//

import Foundation

enum RequestError: Error {
    case invalidUrl
    case errorRequest(error: String)
}

struct HomeService {
    func fetchData() async throws -> Result<[StoreType], RequestError>{
        guard let url = URL(string: "https://private-6e5445-chefdelivery16.apiary-mock.com/home") else {
            return .failure(.invalidUrl)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let storesObject = try JSONDecoder().decode([StoreType].self, from: data)
        
        return .success(storesObject)

    } 
    
    func confirmOrder(product: ProductType) async throws -> Result<[String: Any]?, RequestError> {
        guard let url = URL(string: "https://private-6e5445-chefdelivery16.apiary-mock.com/home") else {
            return .failure(.invalidUrl)
        }
        
        let encodedObject = try JSONEncoder().encode(product)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encodedObject
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let message = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        return .success(message)
        
    }
    
//    func fetchDataWithAlomofire(completion: @escaping ([StoreType]?, Error?) -> Void) {
//        AF.request("https://private-6e5445-chefdelivery16.apiary-mock.com/home").responseDecodable(of: [StoreType].self) {
//            response in
//            switch response.result {
//            case .success(let stores):
//                completion(stores, nil)
//            default: break
//            }
//        }
//    }
}


//            URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            else if let data = data {
//                let storesObject = try? JSONDecoder().decode([StoreType].self, from: data)
//                print(storesObject)
//            }
//        }
//        .resume()
