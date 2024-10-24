//
//  MovieDetailsViewModel.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import Combine
import UIKit

struct IdentifiableError: Identifiable {
    let id = UUID()  // Unique ID for SwiftUI
    var error: Error  // Your error object
}


class MovieDetailsViewModel: ObservableObject {
    let movie: Movie

    @Published var poster: UIImage?
    @Published var cast: [MovieCastMember] = []
    @Published var error: IdentifiableError?

    private let service: MovieDetailsServicing

    init(movie: Movie, service: MovieDetailsServicing) {
        self.movie = movie
        self.service = service
    }

    func fetchData() {
        service.getPoster(for: movie) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let poster):
                    self?.poster = poster
                case .failure(let error):
                    self?.error?.error = error
                }
            }
        }

        service.getCredits(for: movie) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let creditsResponse):
                    self?.cast = creditsResponse.cast
                case .failure(let error):
                    self?.error?.error = error
                }
            }
        }
    }
}
