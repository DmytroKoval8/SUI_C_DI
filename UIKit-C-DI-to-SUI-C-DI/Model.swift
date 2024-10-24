//
//  Model.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import Foundation

let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"
let baseImageURL = "https://image.tmdb.org/t/p/w400/"

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String

    var posterURL: URL {
        URL(string: "\(baseImageURL)\(posterPath)")!
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct MovieCastMember: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let character: String
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCastMember]
}
