//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Jestin Dorius on 4/28/25.
//
import Foundation
import UIKit

class StoreItemController {
    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value)}
            //this limit is broken? 3 pulls 3, 4 pulls 5, 20 pulls 24
    //    guard let url = urlComponents.url else { return [] }
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else { throw StoreItemError.itemsNotFound }
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        
        return searchResponse.results
    }
    
    func fetchItemPic(url: String) async -> UIImage {
        do {
            let url = URL(string: url)!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let StoreItemImage = UIImage(data: data) else { return UIImage() }
            return StoreItemImage
        } catch {
            print(error)
        }
        return UIImage()
    }
}
