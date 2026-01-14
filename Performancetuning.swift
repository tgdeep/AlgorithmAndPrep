
🚀 SwiftUI Performance Tuning Tips

SwiftUI is fast by design, but poor mental models can make it slow.
Most performance issues come from unnecessary recomputation, identity misuse, and heavy view trees.

1️⃣ Keep body Pure & Cheap
❌ Anti-Pattern
var body: some View {
    expensiveCalculation()
    return Text("Hello")
}

✅ Correct
var body: some View {
    Text(viewModel.title)
}


Why:
body is recomputed frequently. Any heavy work here multiplies cost.

2️⃣ Use the Right Property Wrapper
Wrapper    Performance Impact
@State    Cheapest
@StateObject    Stable ownership
@ObservedObject    Recreates on redraw
@EnvironmentObject    Wide invalidation
❌ Common Issue
@ObservedObject var vm = ViewModel()

✅ Correct
@StateObject var vm = ViewModel()

3️⃣ Avoid Unstable View Identity
❌ Performance Killer
ForEach(items, id: \.self)


or

.id(UUID())

✅ Correct
ForEach(items, id: \.id)


Why:
Unstable identity causes full view recreation & diffing failure.

4️⃣ Minimize View Tree Depth
❌ Deep Nesting
VStack {
    HStack {
        VStack {
            ZStack {
                Text("Hello")
            }
        }
    }
}

✅ Flatten Where Possible
Text("Hello")


Why:
Every layer participates in diffing and layout.

5️⃣ Break Large Views into Subviews
❌ Large Body
var body: some View {
    VStack {
        // 100+ lines
    }
}

✅ Extract Subviews
var body: some View {
    VStack {
        header
        content
        footer
    }
}


Benefits:

Better diffing

Fewer invalidations

Avoids ViewBuilder explosion

6️⃣ Avoid Overusing AnyView
❌
AnyView(Text("Hello"))

❌ Problems

Dynamic dispatch

Lost compile-time optimizations

Slower diffing

✅ Prefer

Group

@ViewBuilder

Extracted subviews

7️⃣ Use .task Instead of .onAppear for Async Work
❌
.onAppear {
    loadData()
}

✅
.task {
    await loadData()
}


Why:
.task supports cancellation and respects lifecycle.

8️⃣ Control View Invalidations
❌ Broad State
@EnvironmentObject var appState: AppState


Every change triggers mass invalidation.

✅ Narrow State

Pass only what’s needed

Split large state objects

Use bindings carefully

9️⃣ Prefer Lazy Containers for Large Data
❌
VStack {
    ForEach(items) { ... }
}

✅
LazyVStack {
    ForEach(items) { ... }
}


Why:
Lazy containers build views on demand.

🔟 Avoid Heavy Modifiers in Loops
❌
ForEach(items) {
    Text($0)
        .shadow(radius: 10)
        .blur(radius: 5)
}

✅

Reduce visual effects

Apply modifiers conditionally

Cache results where possible

🔥 Performance Debugging Tips

Use Instruments → SwiftUI

Add print("body") to track recompute

Watch for unexpected init calls

Test on older devices

🧠 Interview Power Statement

SwiftUI performance issues usually come from
misunderstanding identity and state invalidation,
not from the framework itself.

⭐ Golden Rules Summary

Keep body cheap

Use stable identity

Own your ViewModels

Avoid AnyView

Break large views

Use lazy containers

Prefer .task
