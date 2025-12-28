import SwiftUI

struct ViewRecreationBodyRecomputeView: View {

    @State private var counter: Int = 0

    init() {
        print("🆕 View INIT")
    }

    var body: some View {
        print("🔄 body recomputed")

        return VStack(spacing: 24) {

            Text("View Recreation vs Body Recompute")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Counter: \(counter)")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button("Increment Counter") {
                counter += 1
            }
            .buttonStyle(.borderedProminent)

            ChildView()

            explanationText

            Spacer()
        }
        .padding()
    }
}

//child view

private struct ChildView: View {

    init() {
        print("👶 ChildView INIT")
    }

    var body: some View {
        print("🔁 ChildView body recomputed")

        return Text("I am a Child View")
            .padding()
            .background(.green.opacity(0.15))
            .cornerRadius(8)
    }
}



