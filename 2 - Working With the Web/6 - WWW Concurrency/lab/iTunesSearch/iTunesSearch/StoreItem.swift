//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Jestin Dorius on 4/28/25.
//

import Foundation


struct StoreItem: Codable {
    var name: String = ""
    var artist: String = ""
    var kind: String = ""
    var artworkUrl: String = "" // Really a URL
//    var description: String?
//    var longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        //
        case name = "trackName"
        //
        case kind = ""
        //
        case artist = "artistName"
        //
        case artworkUrl = "artworkUrl100"
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print(values)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        artist = try values.decodeIfPresent(String.self, forKey: .artist) ?? ""
        kind = try values.decodeIfPresent(String.self, forKey: .kind) ?? ""
        artworkUrl = try values.decodeIfPresent(String.self, forKey: .artworkUrl) ?? ""
    }
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}

enum StoreItemError: Error, LocalizedError {
    case itemsNotFound
    case invalidResponse
}
