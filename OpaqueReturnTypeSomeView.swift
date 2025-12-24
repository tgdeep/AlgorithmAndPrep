import SwiftUI

struct OpaqueReturnTypeSomeView: View {

    @State private var isOn: Bool = false

    var body: some View {
        VStack(spacing: 24) {

            Text("Opaque Return Type: some View")
                .font(.title2)
                .fontWeight(.semibold)

            Toggle("Toggle State", isOn: $isOn)
                .padding(.horizontal)

            opaqueView
                .padding()
                .background(.blue.opacity(0.1))
                .cornerRadius(12)

            explanationText

            Spacer()
        }
        .padding()
    }
}
