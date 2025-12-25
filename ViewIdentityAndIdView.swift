import SwiftUI

struct ViewIdentityAndIdView: View {

    @State private var counter: Int = 0
    @State private var useDifferentId: Bool = false

    var body: some View {
        VStack(spacing: 24) {

            Text("View Identity & .id()")
                .font(.title2)
                .fontWeight(.semibold)

            Toggle("Change View Identity", isOn: $useDifferentId)
                .padding(.horizontal)

            counterView
                .id(useDifferentId ? UUID() : "stable-id")

            Button("Increment Counter") {
                counter += 1
            }
            .buttonStyle(.borderedProminent)

            explanationText

            Spacer()
        }
        .padding()
    }
}
