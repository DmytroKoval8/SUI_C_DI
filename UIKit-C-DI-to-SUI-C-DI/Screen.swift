//
//  Screen.swift
//  SwiftUI+C+DI
//
//  Created by Admin on 24/10/2024.
//

import Foundation

enum Screen: Hashable {
    case movies
    case movieDetails(movie: Movie)
}
