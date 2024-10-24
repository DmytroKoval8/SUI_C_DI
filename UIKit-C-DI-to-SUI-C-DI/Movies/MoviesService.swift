//
//  MoviesService.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import Foundation

protocol MoviesServicing {
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void)
}

class MoviesService: MoviesServicing {
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let decoded = try jsonDecoder.decode(MovieResponse.self, from: data!)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

class MoviesMockService: MoviesServicing {
    func getMovies(_ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let response = MovieResponse(results: [
            Movie(id: 1, title: "Movie 1", overview: "Overview 1", posterPath: "/path1.jpg"),
            Movie(id: 2, title: "Movie 2", overview: "Overview 2", posterPath: "/path2.jpg"),
            Movie(id: 3, title: "Movie 3", overview: "Overview 3", posterPath: "/path3.jpg")
        ])
        completion(.success(response))
    }
}
