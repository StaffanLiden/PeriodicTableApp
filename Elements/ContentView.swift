import SwiftUI

struct ContentView: View {
    @ObservedObject var elementData = ElementData()
    @State private var valdSpråk = "sv"
    @State private var searchText = ""
    @State private var visadetaljvy = false
    @State private var valtGrundämne: Grundämne? = nil

    let columns: [GridItem] = Array(repeating: .init(.fixed(37)), count: 18)

    var body: some View {
        VStack { // No NavigationView
           
//            Picker("Språk", selection: $valdSpråk) {
  //              Text("Svenska").tag("sv")
    //            Text("Engelska").tag("en")
//            }
  //          .pickerStyle(SegmentedPickerStyle())
    //        .padding(.horizontal)

            TextField("Sök grundämne", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            if elementData.isLoading {
                ProgressView()
            } else if let error = elementData.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                ScrollView(.horizontal) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 1) {
                            ForEach(1...118, id: \.self) { atomicNumber in
                                if let grundämne = elementData.grundämnen.first(where: { $0.atomnummer == atomicNumber }) {
                                    if (57...70).contains(grundämne.atomnummer) || (89...102).contains(grundämne.atomnummer) {
                                        EmptyView()
                                    } else {
                                        // ... (rest of your element rendering logic) ...
                                        if grundämne.atomnummer == 1 { // Hydrogen (H)
                                            GrundämneCell(grundämne: grundämne, språk: valdSpråk)
                                                .frame(width: 37, height: 37)
                                                .onTapGesture {
                                                    valtGrundämne = grundämne
                                                    visadetaljvy = true
                                                }
                                        } else if grundämne.atomnummer == 2 { // Helium (He)
                                            ForEach(0..<16, id: \.self) { _ in
                                                Color.clear.frame(width: 37, height: 37)
                                            }
                                            GrundämneCell(grundämne: grundämne, språk: valdSpråk)
                                                .frame(width: 37, height: 37)
                                                .onTapGesture {
                                                    valtGrundämne = grundämne
                                                    visadetaljvy = true
                                                }
                                        } else if grundämne.atomnummer == 5 || grundämne.atomnummer == 13 { // B/Al
                                            ForEach(0..<10, id: \.self) { _ in
                                                Color.clear.frame(width: 37, height: 37)
                                            }
                                            GrundämneCell(grundämne: grundämne, språk: valdSpråk)
                                                .frame(width: 37, height: 37)
                                                .onTapGesture {
                                                    valtGrundämne = grundämne
                                                    visadetaljvy = true
                                                }
                                        } else { // All other elements
                                            GrundämneCell(grundämne: grundämne, språk: valdSpråk)
                                                .frame(width: 37, height: 37)
                                                .onTapGesture {
                                                    valtGrundämne = grundämne
                                                    visadetaljvy = true
                                                }
                                        }
                                    }
                                } else {
                                    Color.clear.frame(width: 37, height: 37)
                                }
                            }
                        }
                        .padding(.horizontal, 2)
                        .padding(.vertical, 2)

                        LazyVGrid(columns: Array(repeating: .init(.fixed(37)), count: 14), spacing: 1) {
                            ForEach(elementData.grundämnen.filter { (57...70).contains($0.atomnummer) }) { grundämne in
                                GrundämneCell(grundämne: grundämne, språk: valdSpråk)
                                    .frame(width: 37, height: 37)
                                    .onTapGesture {
                                        valtGrundämne = grundämne
                                        visadetaljvy = true
                                    }
                            }
                        }
                        .padding(.top, 10)

                        LazyVGrid(columns: Array(repeating: .init(.fixed(37)), count: 14), spacing: 1) {
                            ForEach(elementData.grundämnen.filter { (89...102).contains($0.atomnummer) }) { grundämne in
                                GrundämneCell(grundämne: grundämne, språk: valdSpråk)
                                    .frame(width: 37, height: 37)
                                    .onTapGesture {
                                        valtGrundämne = grundämne
                                        visadetaljvy = true
                                    }
                            }
                        }
                        .padding(.top, 5)
                    }
                }
            }
           // .padding(.bottom, 20)
           // .navigationTitle("Grundämnen") // Keep navigationTitle here, but it won't be used
        }
        // Use .sheet with a custom view for the pop-up
        .overlay(
            visadetaljvy ? AnyView(
                PopupView(grundämne: valtGrundämne!, språk: valdSpråk, visadetaljvy: $visadetaljvy) // Pass the binding
            ) : AnyView(EmptyView())
        )

    }
}
