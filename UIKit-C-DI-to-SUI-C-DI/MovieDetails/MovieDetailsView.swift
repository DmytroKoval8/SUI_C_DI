//
//  MovieDetailsView.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let poster = viewModel.poster {
                    Image(uiImage: poster)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .overlay(
                            ProgressView()
                        )
                }

                Text(viewModel.movie.overview)
                    .padding()

                Text("Cast")
                    .font(.title2)
                    .bold()
                    .padding([.leading, .top])

                ForEach(viewModel.cast) { castMember in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(castMember.name)
                            .font(.headline)
                        Text(castMember.character)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(viewModel.movie.title)
        .onAppear {
            if viewModel.cast.isEmpty || viewModel.poster == nil {
                viewModel.fetchData()
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
        }
    }
}
