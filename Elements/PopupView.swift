import SwiftUI

struct PopupView: View {
    let grundämne: Grundämne
    let språk: String
    @Binding var visadetaljvy: Bool // Use binding to toggle visibility

    var body: some View {
        VStack {
            Detaljvy(grundämne: grundämne, språk: språk)
                .padding()

            Button(action: {
                visadetaljvy = false // Close only the pop-up, not navigate back
            }) {
                Text("Stäng")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground).opacity(0.95))
        .cornerRadius(15)
        .frame(maxWidth: 300, maxHeight: 300)
        .shadow(radius: 10)
    }
}
