import SwiftUI

struct ViewBuilderExplosionView: View {

    @State private var showExtraViews = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Text("ViewBuilder Explosion")
                    .font(.title2)
                    .fontWeight(.semibold)

                Toggle("Show Many Views", isOn: $showExtraViews)

                explodedView

                explanationText
            }
            .padding()
        }
    }
}
