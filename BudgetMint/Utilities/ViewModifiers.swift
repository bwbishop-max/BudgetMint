import SwiftUI

struct BMCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(BMTheme.spacingLG)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: BMTheme.cornerLG))
            .shadow(
                color: .black.opacity(BMTheme.cardShadowOpacity),
                radius: BMTheme.cardShadowRadius,
                y: BMTheme.cardShadowY
            )
    }
}

extension View {
    func bmCard() -> some View {
        modifier(BMCardModifier())
    }
}
