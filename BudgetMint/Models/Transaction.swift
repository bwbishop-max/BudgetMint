import Foundation
import FirebaseFirestore

struct Transaction: Codable, Identifiable {
    @DocumentID var id: String?
    let userId: String
    let accountId: String
    let transactionId: String
    let amount: Double        // positive = debit, negative = credit
    let date: String          // YYYY-MM-DD from Plaid
    let merchantName: String
    let name: String          // Raw Plaid description
    let category: String      // Plaid PFC primary category
    let categoryDetailed: String
    let categoryConfidence: String
    let categoryIconUrl: String
    let paymentChannel: String // online, in store, other
    let pending: Bool
    let logoUrl: String
    let website: String
    let isoCurrencyCode: String
    // User override fields
    var userCategory: String?
    var tags: [String]
    var notes: String

    /// The display category - user override takes precedence
    var displayCategory: String {
        userCategory ?? category
    }

    /// Parsed date for sorting/grouping
    var parsedDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date) ?? Date()
    }
}
