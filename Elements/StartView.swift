import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Välkommen till Periodiska Systemet!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                NavigationLink(destination: ContentView().navigationBarHidden(true)) { // Hide NavBar
                    Text("Visa Periodiska Systemet")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: MultipleChoiceQuizView().navigationBarHidden(true)) {  // Hide NavBar
                    Text("Flervalsfrågor")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: WritingQuizView().navigationBarHidden(true)) {  //Hide NavBar
                    Text("Skrivövning")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Huvudmeny")
        }
    }
}

#Preview {
    StartView()
}
