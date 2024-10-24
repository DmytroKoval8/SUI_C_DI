//
//  MovieDetailsService.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import UIKit

protocol MovieDetailsServicing {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage, Error>) -> Void)
    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void)
}

enum ImageError: Error {
    case couldNotDecode
}

class MovieDetailsService: MovieDetailsServicing {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: movie.posterURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ImageError.couldNotDecode))
                return
            }

            completion(.success(image))
        }.resume()
    }

    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let decoded = try jsonDecoder.decode(MovieCreditsResponse.self, from: data!)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

class MovieDetailsMockService: MovieDetailsServicing {
    func getPoster(for movie: Movie, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        let poster = UIImage(named: "mock_poster")!
        completion(.success(poster))
    }

    func getCredits(for movie: Movie, _ completion: @escaping (Result<MovieCreditsResponse, Error>) -> Void) {
        let response = MovieCreditsResponse(cast: [
            MovieCastMember(id: 1, name: "Actor 1", character: "Character 1"),
            MovieCastMember(id: 2, name: "Actor 2", character: "Character 2"),
            MovieCastMember(id: 3, name: "Actor 3", character: "Character 3")
        ])
        completion(.success(response))
    }
}
