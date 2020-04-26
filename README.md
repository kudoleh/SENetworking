# SENetworking

**S**uper **E**asy **Networking** is  simple and convenient wrapper around NSURLSession that supports common needs. A framework that is small enough to read in one go but useful enough to include in any project. It is fully tested framework for iOS, tvOS, watchOS and OS X.

- Super Minimal and Light implementation
- Easy network configuration
- Works with Decodable for responses and Encodable for Requests
- Friendly API which makes declarations of Endpoints super easy
- Easy use of Data Trasfer Objects and Mappings
- No Singletons
- No external dependencies
- Simple request cancellation
- Optimized for unit testing
- Fully tested
- Ideal for code challenges

## Example

**Endpoint definitions**:

```swift
struct APIEndpoints {
    static func getMovies(with moviesRequestDTO: MoviesRequest) -> Endpoint<MoviesResponse> {
        return Endpoint(path: "search/movie/",
                        method: .get,
                        queryParametersEncodable: moviesRequestDTO)
    }
}
```

**API Data (Data Transfer Objects)**:

```swift
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
        let posterPath: String
    }

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    let movies: [Movie]
}
```
**API Networking Configuration**:

```swift
struct AppConfiguration {
    var apiKey: String = "xxxxxxxxxxxxxxxxxxxxxxxxx"
    var apiBaseURL: String = "http://api.themoviedb.org"
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
}
```

**Making API call**:

```swift
let endpoint = APIEndpoints.getMovies(with: MoviesRequest(query: "Batman Begins", page: 1))
dataTransferService.request(with: endpoint) { result in

    guard case let .success(response) = result, let movies = response.movies else { return }

    self.show(movies)
}
```


## Installation

### [CocoaPods](https://cocoapods.org): To install it with CocoaPods, simply add the following line to your Podfile:

```ruby
pod 'SENetworking'
```
Then **pod install** and **import SFNetworking** in files where needed

### [Carthage](https://github.com/Carthage/Carthage): To install it with Carthage, simply add the following line to your Cartfile:

```ruby
github "kudoleh/SENetworking"
```
Then **carthage update** and **import SFNetworking_iOS** in files where needed (for iOS platform)

### [Swift Package Manager](https://swift.org/package-manager/): To install it with Package Manager:
```ruby
Xcode tab: File -> Swift Packages -> Add Package Dependency 
Enter package repository URL: https://github.com/kudoleh/SENetworking
```
And then **import SFNetworking** in files where needed

### Manual installation: To manually install it:
```ruby
Copy folder SENetworking into your project
```

## Author

Oleh Kudinov, kudoleh@hotmail.com

## License

MIL License, Open Source License
