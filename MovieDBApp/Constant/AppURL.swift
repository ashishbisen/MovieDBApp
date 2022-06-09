//
//  AppURL.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//

import UIKit


struct Domain {
    static let dev = "http://api.themoviedb.org/"
    static let assest = "https://image.tmdb.org/t/p/w500"

}

extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

struct APIEndpoint {
    static let popularMovies         = "3/movie/popular?api_key=1a5ac0e3d3792ed0a5f3b9293f104204&language=en-US"
    static let upcomingMovies         = "3/movie/upcoming?api_key=1a5ac0e3d3792ed0a5f3b9293f104204&language=en-US&page=1"
}

enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

enum UploadType: String {
    case avatar
    case file
}
