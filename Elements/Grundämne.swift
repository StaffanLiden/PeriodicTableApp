// Grundämne.swift
import Foundation
import SwiftUI

struct Grundämne: Codable, Identifiable {
    let id = UUID()
    let atomnummer: Int
    let symbol: String
    let namnSvenska: String
    let namnEngelska: String
    let atomvikt: Double
    let svårighetsgrad: String
    let grupp: String
    let period: Int

    func namn(påSpråk språk: String) -> String {
        switch språk {
        case "sv":
            return namnSvenska
        case "en":
            return namnEngelska
        default:
            return namnSvenska
        }
    }

    var gruppFärg: Color {
        switch grupp {
        case "Alkalimetall":
            return .red.opacity(0.7) // Slightly transparent
        case "Alkaliska jordartsmetaller":
            return .orange.opacity(0.7)
        case "Övergångsmetall":
            return .yellow.opacity(0.7)
        case "Metall":
            return .gray.opacity(0.7)
        case "Halvmetall":
            return .green.opacity(0.7)
        case "Ickemetall":
            return .blue.opacity(0.7)
        case "Halogen":
            return .purple.opacity(0.7)
        case "Ädelgas":
            return .teal.opacity(0.7)
        case "Lantanoid":
            return .pink.opacity(0.7)
        case "Aktinoid":
            return .mint.opacity(0.7)
        default:
            return .secondary.opacity(0.7)
        }
    }


    static var example: Grundämne {
        Grundämne(atomnummer: 1, symbol: "H", namnSvenska: "Väte", namnEngelska: "Hydrogen", atomvikt: 1.008, svårighetsgrad: "lätt", grupp: "Ickemetall", period: 1)
    }
}
