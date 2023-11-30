
import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    @State private var progress: Double = 0.0

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
                    Text("Hang tight!")
                        .padding()

                    ProgressBar(progress: $progress)
                        .frame(width: 200, height: 10)
                        .padding()

                    // show progress update
                    Button("Refresh") {
                        simulateProgress()
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Simulate background task
            isLoading = true
            simulateProgress()
        }
    }

    private func simulateProgress() {
        progress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation {
                progress += 0.01
                if progress >= 1.0 {
                    isLoading = false
                    timer.invalidate()
                }
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(1)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.yellow)
            }
            .cornerRadius(5.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

