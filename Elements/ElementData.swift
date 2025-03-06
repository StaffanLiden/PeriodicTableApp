// ElementData.swift
import Foundation
import SwiftUI

final class ElementData: ObservableObject {
    @Published var grundämnen: [Grundämne] = []
    @Published var isLoading = false
    @Published var error: Error?

    init() {
        loadData()
    }

    func loadData() {
        isLoading = true
        error = nil

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }

            if let url = Bundle.main.url(forResource: "elements", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Grundämne].self, from: data)

                    DispatchQueue.main.async {
                        self.grundämnen = jsonData
                        self.isLoading = false
                    }

                } catch {
                    DispatchQueue.main.async {
                        print("Error loading or decoding JSON: \(error)")
                        self.error = error
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "LoadingError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not find elements.json"])
                    self.isLoading = false
                }
            }
        }
    }
}
