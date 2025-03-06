import SwiftUI

    struct Detaljvy: View {
        let grundämne: Grundämne
        let språk: String
        @Environment(\.dismiss) var dismiss // Add dismiss environment

        var body: some View {
            // No more ScrollView here
                VStack(alignment: .leading) {
                    HStack {
                        Text(grundämne.namn(påSpråk: språk))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()

                    }
                    Text(grundämne.namnEngelska)
                        .font(.title)
                        .foregroundColor(.secondary)

                    Divider()

                    HStack {
                        Text("Symbol:")
                            .fontWeight(.bold)
                        Text(grundämne.symbol)
                    }
                    // ... (rest of your detail view content) ...
                    HStack {
                        Text("Atomnummer:")
                            .fontWeight(.bold)
                        Text("\(grundämne.atomnummer)")
                    }
                    HStack {
                        Text("Atomvikt:")
                            .fontWeight(.bold)
                        Text("\(grundämne.atomvikt)")
                    }
                    HStack {
                        Text("Grupp:")
                            .fontWeight(.bold)
                        Text(grundämne.grupp)
                    }
                    HStack {
                        Text("Period:")
                            .fontWeight(.bold)
                        Text("\(grundämne.period)")
                    }
                    HStack{
                        Text("Svårighetsgrad")
                            .fontWeight(.bold)
                        Text(grundämne.svårighetsgrad)
                    }
                }
                .padding()
            
            // No navigationTitle or navigationBarTitleDisplayMode here!
        }
    }
