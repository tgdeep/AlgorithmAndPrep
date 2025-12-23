import SwiftUI

// MARK: - Preference Key
struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

// MARK: - Content View
struct ChildToParentPreferenceKeyView: View {

    @State private var childHeight: CGFloat = 0

    var body: some View {
        VStack(spacing: 24) {

            Text("Parent reacting to child size")
                .font(.headline)

            Text("Child Height: \(Int(childHeight)) pts")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ChildView()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(
                                key: HeightPreferenceKey.self,
                                value: proxy.size.height
                            )
                    }
                )
                .onPreferenceChange(HeightPreferenceKey.self) { value in
                    childHeight = value
                }

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: childHeight)
    }
}

// MARK: - Child View
struct ChildView: View {

    @State private var expanded = false

    var body: some View {
        VStack(spacing: 12) {
            Text("I am the Child View")
                .font(.title3)
                .bold()

            if expanded {
                Text("""
                This extra content appears only when expanded.
                The parent automatically updates its layout
                without any direct communication.
                """)
                .font(.body)
            }

            Button(expanded ? "Collapse" : "Expand") {
                expanded.toggle()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.blue.opacity(0.15))
        .cornerRadius(12)
    }
}

#Preview {
    ChildToParentPreferenceKeyView()
}
