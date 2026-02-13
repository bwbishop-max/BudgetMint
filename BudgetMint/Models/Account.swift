import Foundation
import FirebaseFirestore

struct Account: Codable, Identifiable, Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.plaidAccountId == rhs.plaidAccountId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(plaidAccountId)
    }

    @DocumentID var id: String?
    let userId: String
    let itemId: String
    let plaidAccountId: String
    let name: String
    let officialName: String?
    let type: String          // checking, savings, credit, investment, loan
    let subtype: String?
    var balanceCurrent: Double?
    var balanceAvailable: Double?
    let mask: String?         // Last 4 digits
    let institutionId: String?
    var lastBalanceUpdate: Date?
}
