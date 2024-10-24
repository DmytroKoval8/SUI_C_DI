//
//  AppCoordinator.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var routes: [Route<Screen>] = []
    let moviesService: MoviesServicing
    let movieDetailsService: MovieDetailsServicing

    init() {
        switch appConfiguration {
        case .live:
            self.moviesService = MoviesService()
            self.movieDetailsService = MovieDetailsService()
        case .mock:
            self.moviesService = MoviesMockService()
            self.movieDetailsService = MovieDetailsMockService()
        }

        // Start with the movies screen
        routes = [.root(.movies)]
    }

    func view() -> some View {
        FlowStack($routes) { screen in
            switch screen {
            case .movies:
                MoviesView(viewModel: MoviesViewModel(service: moviesService))
                    .environmentObject(self.navigator)
            case .movieDetails(let movie):
                MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie, service: movieDetailsService))
            }
        }
    }

    var navigator: FlowNavigator<Screen> {
        FlowNavigator(routes: $routes)
    }
}
