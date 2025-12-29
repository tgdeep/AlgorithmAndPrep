import SwiftUI

struct NavigationStackIdentityResetView: View {

    @State private var path: [Int] = []
    @State private var counter: Int = 0

    var body: some View {
        NavigationStack(path: $path) {

            VStack(spacing: 24) {

                Text("NavigationStack Identity Reset")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Root Counter: \(counter)")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Button("Increment Root Counter") {
                    counter += 1
                }
                .buttonStyle(.borderedProminent)

                Button("Push Detail View") {
                    path.append(counter)
                }

                explanationText

                Spacer()
            }
            .padding()
            .navigationDestination(for: Int.self) { value in
                DetailView(value: value)
            }
        }
    }
}
