import SwiftUI

@MainActor
final class TaskDemoViewModel: ObservableObject {

    @Published var log: [String] = []

    func simulateApiCall(source: String) async {
        log.append("▶️ Started from \(source)")

        try? await Task.sleep(nanoseconds: 2_000_000_000)

        if Task.isCancelled {
            log.append("⛔️ Cancelled from \(source)")
            return
        }

        log.append("✅ Finished from \(source)")
    }

    func clearLogs() {
        log.removeAll()
    }
}
