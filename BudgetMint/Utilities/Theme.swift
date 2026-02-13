import SwiftUI

enum BMTheme {
    // MARK: - Brand Colors
    static let brandGreen = Color("BrandGreen")
    static let brandGreenGradient = LinearGradient(
        colors: [Color(hex: 0x059669), Color(hex: 0x34D399)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Semantic Colors
    static let income = Color.green
    static let expense = Color.red
    static let transfer = Color.blue
    static let pending = Color.orange

    // MARK: - Spacing
    static let spacingXS: CGFloat = 4
    static let spacingSM: CGFloat = 8
    static let spacingMD: CGFloat = 12
    static let spacingLG: CGFloat = 16
    static let spacingXL: CGFloat = 20
    static let spacingXXL: CGFloat = 24

    // MARK: - Corner Radii
    static let cornerSM: CGFloat = 8
    static let cornerMD: CGFloat = 12
    static let cornerLG: CGFloat = 16

    // MARK: - Shadows
    static let cardShadowRadius: CGFloat = 4
    static let cardShadowY: CGFloat = 2
    static let cardShadowOpacity: Double = 0.08

    // MARK: - Animation
    static let standardAnimation: Animation = .easeInOut(duration: 0.25)
    static let springAnimation: Animation = .spring(response: 0.5, dampingFraction: 0.7)

    // MARK: - Account Type Helpers
    static func iconForAccountType(_ type: String) -> String {
        switch type {
        case "depository": return "banknote.fill"
        case "credit": return "creditcard.fill"
        case "loan": return "percent"
        case "investment": return "chart.line.uptrend.xyaxis"
        default: return "building.columns.fill"
        }
    }

    static func colorForAccountType(_ type: String) -> Color {
        switch type {
        case "depository": return .green
        case "credit": return .orange
        case "loan": return .red
        case "investment": return .blue
        default: return .gray
        }
    }
}
