//
//  ViewController.swift
//  SFNetworkingExample
//
//  Created by Oleh Kudinov on 25/04/2020.
//  Copyright © 2020 Org. All rights reserved.
//

import UIKit

import SENetworking_iOS

// MARK: - API Configuration
struct AppConfiguration {
    var apiKey: String = "2696829a81b1b5827d515ff121700838"
    var apiBaseURL: String = "http://api.themoviedb.org"
    var imagesBaseURL: String = "http://image.tmdb.org"
}

class DIContainer {
    static let shared = DIContainer()

    lazy var appConfiguration = AppConfiguration()

    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                          queryParameters: ["api_key": appConfiguration.apiKey,
                                                            "language": NSLocale.preferredLanguages.first ?? "en"])

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.imagesBaseURL)!)
        let imagesDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
}

// MARK: - Endpoints definitions

struct APIEndpoints {
    static func getMovies(with moviesRequestDTO: MoviesRequest) -> Endpoint<MoviesResponse> {
        return Endpoint(path: "3/search/movie",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }

    static func getMovieImage(path: String) -> Endpoint<Data> {
        return Endpoint(path: "t/p/w500\(path)",
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}

// MARK: - API Data (Data Transfer Objects)
struct MoviesRequest: Encodable {
    let query: String
    let page: Int
}

struct MoviesResponse: Decodable {
    struct Movie: Decodable {
        private enum CodingKeys: String, CodingKey {
            case title
            case overview
            case posterPath = "poster_path"
        }
        let title: String
        let overview: String
        let posterPath: String?
    }

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    let movies: [Movie]
}

// MARK: - Example: downloads movie batman and shows first movie title and image

class ViewController: UIViewController {

    @IBOutlet private weak var overviewTextView: UITextView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    private let mainQueue: DispatchQueue = .main

    private let dataTransferService: DataTransferService = DIContainer.shared.apiDataTransferService
    private let imageTransferService: DataTransferService = DIContainer.shared.imageDataTransferService

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    func loadData() {

        let endpoint = APIEndpoints.getMovies(with: MoviesRequest(query: "Batman Begins", page: 1))
        dataTransferService.request(with: endpoint) { [weak self] result in
            guard let self else { return }
            self.mainQueue.async {
                guard case let .success(response) = result, let movie = response.movies.first else { return }
                self.title = movie.title
                self.overviewTextView.text = movie.overview

                self.loadPosterImage(posterPath: movie.posterPath)
            }
        }
    }
    
    func loadPosterImage(posterPath: String?) {
        guard let posterPath = posterPath else { return }
        self.imageTransferService.request(with: APIEndpoints.getMovieImage(path: posterPath)) { result in
            self.mainQueue.async {
                guard case let .success(imageData) = result else { return }
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}
