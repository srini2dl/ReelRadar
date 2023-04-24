import SwiftUI

struct TabButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? .primary : .secondary)
            .padding([.leading, .trailing], 20)
            .frame(height: 60)
            .background(
                VStack(alignment: .leading) {
                    Spacer()
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(isSelected ? .yellow : .clear)
                }
            )
    }
}
