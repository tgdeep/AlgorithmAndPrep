
⚠️ UIKit → SwiftUI Migration Pitfalls

Migrating from UIKit to SwiftUI is not a rewrite — it’s a mental model shift.
Most bugs come from treating SwiftUI like UIKit.

1️⃣ Expecting View Lifecycle Callbacks
❌ UIKit Mindset
override func viewDidLoad() {
    fetchData()
}

❌ SwiftUI Anti-Pattern
var body: some View {
    fetchData() // WRONG
    return Text("Hello")
}

✅ Correct SwiftUI
.task {
    await fetchData()
}


Why:
body is recomputed frequently. Side effects here cause repeated work.

2️⃣ Assuming Views Are Persistent Objects
❌ UIKit Thinking

“This view controller lives in memory.”

❌ SwiftUI Mistake
struct MyView: View {
    var counter = 0 // resets
}

✅ Correct
@State private var counter = 0


Why:
SwiftUI views are value types, not objects.

3️⃣ Misusing @ObservedObject Instead of @StateObject
❌ Common Migration Bug
@ObservedObject var viewModel = MyViewModel()

✅ Correct Ownership
@StateObject var viewModel = MyViewModel()


Why:
SwiftUI recreates views — ObservedObject does not preserve ownership.

4️⃣ Expecting Navigation to Preserve State
❌ UIKit Assumption

“Popping and pushing keeps my screen state.”

❌ SwiftUI Reality

NavigationStack recreates views

State resets unless identity is preserved

✅ Solution

Move state up

Use stable path values

Store data in ViewModels

5️⃣ Using .id(UUID()) to “Fix” UI Issues
❌ Anti-Pattern
.someView()
.id(UUID())

💥 Result

View recreated every render

State resets

Animations break

✅ Use .id() only when you want a reset
6️⃣ Overusing AnyView
❌ UIKit-style Thinking
var view: AnyView {
    if condition {
        return AnyView(Text("A"))
    } else {
        return AnyView(Image(systemName: "xmark"))
    }
}

❌ Problems

Performance hit

Lost type safety

Hides architectural issues

✅ Correct Approach

Use Group

Extract subviews

Align concrete return types

7️⃣ Treating SwiftUI Like Auto Layout
❌ UIKit Habit

“Where are my constraints?”

❌ SwiftUI Misuse
.frame(width: 200, height: 50)

✅ SwiftUI Thinking

Let layout flow naturally

Use stacks & alignment

Avoid hard-coded sizes

8️⃣ Forgetting EnvironmentObject Injection
❌ Crash
@EnvironmentObject var session: UserSession


Error:

No ObservableObject of type UserSession found

✅ Correct
.environmentObject(UserSession())


Injected once at root.

9️⃣ Assuming onAppear == UIKit Lifecycle
❌ UIKit Expectation

“onAppear runs once”

❌ Reality

Runs multiple times

Not cancellation-aware

✅ Use .task {} for async work
🔥 Biggest Migration Lesson

SwiftUI is not UIKit with better syntax.
It is a different programming model.

🧠 Interview Power Answer

If asked:

“What was the hardest part migrating to SwiftUI?”

Answer:

“Letting go of lifecycle thinking and learning to reason in terms of state, identity, and data flow.”

⭐ Migration Strategy (Best Practice)

Start with leaf views

Use UIHostingController

Share ViewModels

Avoid full rewrites

Learn SwiftUI internals early
