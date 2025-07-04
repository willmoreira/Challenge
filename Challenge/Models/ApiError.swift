import Foundation

enum ApiError: Error {

    case couldNotConnectToServer
    case noInternet
    case decode
    case invalidURL
    case noResponse
    case unathorized
    case unexpectedStatusCode(statusCode: Int, errorMessage: String?)
    case unknown
}
