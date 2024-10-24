//
//  MoviesView.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

// MoviesView.swift

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel: MoviesViewModel
    @EnvironmentObject var navigator: FlowNavigator<Screen>

    var body: some View {
        List(viewModel.movies) { movie in
            Button(action: {
                navigator.push(.movieDetails(movie: movie))
            }) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Movies")
        .onAppear {
            if viewModel.movies.isEmpty {
                viewModel.fetchData()
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error.error.localizedDescription), dismissButton: .default(Text("OK")))
        }
    }
}

