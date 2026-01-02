import SwiftUI

final class UserSession: ObservableObject {
    @Published var username: String = "Guest"
}



struct EnvironmentVsEnvironmentObjectView: View {

    @StateObject private var session = UserSession()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Text("Environment vs EnvironmentObject")
                    .font(.title2)
                    .fontWeight(.semibold)

                NavigationLink("Go to Detail View") {
                    DetailView()
                }

                explanationText

                Spacer()
            }
            .padding()
        }
        // ✅ Injected ONCE at root
        .environmentObject(session)
    }
}


private struct DetailView: View {

    // ✅ Reference-based shared state
    @EnvironmentObject private var session: UserSession

    // ✅ Value-based system environment
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 20) {

            Text("Detail View")
                .font(.title2)
                .bold()

            Text("Username: \(session.username)")
                .font(.headline)

            Button("Change Username") {
                session.username = "Deepak"
            }
            .buttonStyle(.borderedProminent)

            Text("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")")
                .font(.footnote)
                .foregroundColor(.secondary)

            explanationText

            Spacer()
        }
        .padding()
    }
}



