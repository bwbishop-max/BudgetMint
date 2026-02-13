import Foundation
import FirebaseFunctions

class PlaidService {
    private let functions = Functions.functions()

    func createLinkToken() async throws -> String {
        let result = try await functions.httpsCallable("createLinkToken").call()
        guard let data = result.data as? [String: Any],
              let linkToken = data["link_token"] as? String else {
            throw PlaidServiceError.invalidResponse
        }
        return linkToken
    }

    func exchangePublicToken(_ publicToken: String) async throws -> String {
        let result = try await functions.httpsCallable("exchangePublicToken").call(["publicToken": publicToken])
        guard let data = result.data as? [String: Any],
              let itemId = data["itemId"] as? String else {
            throw PlaidServiceError.invalidResponse
        }
        return itemId
    }

    func syncTransactions(itemId: String) async throws -> (added: Int, modified: Int, removed: Int) {
        let result = try await functions.httpsCallable("syncTransactions").call(["itemId": itemId])
        guard let data = result.data as? [String: Any] else {
            throw PlaidServiceError.invalidResponse
        }
        return (
            added: data["added"] as? Int ?? 0,
            modified: data["modified"] as? Int ?? 0,
            removed: data["removed"] as? Int ?? 0
        )
    }

    func refreshBalances(itemId: String) async throws -> Int {
        let result = try await functions.httpsCallable("refreshBalances").call(["itemId": itemId])
        guard let data = result.data as? [String: Any],
              let count = data["accounts"] as? Int else {
            throw PlaidServiceError.invalidResponse
        }
        return count
    }
}

enum PlaidServiceError: LocalizedError {
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        }
    }
}
