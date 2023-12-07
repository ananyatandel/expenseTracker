import SwiftUI

struct ContentView: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            HomeView()

            // Loading screen
            if isLoading {
                Color(.systemBackground)
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Loading...")
                        .padding()
                }
            }
        }
        .onAppear {
            // Simulate background task
            isLoading = true
            simulateLoading()
        }
    }

    private func simulateLoading() {
        let durationThreshold = 1.5
        let startTime = Date()

        DispatchQueue.main.asyncAfter(deadline: .now() + durationThreshold) {
            isLoading = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

