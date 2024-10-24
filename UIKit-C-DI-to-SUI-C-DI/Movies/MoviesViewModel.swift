//
//  MoviesViewModel.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import Combine
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var error: Error?

    private let service: MoviesServicing

    init(service: MoviesServicing) {
        self.service = service
    }

    func fetchData() {
        service.getMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieResponse):
                    self?.movies = movieResponse.results
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
