// GrundämneCell.swift
import SwiftUI

struct GrundämneCell: View {
    let grundämne: Grundämne
    let språk: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(grundämne.gruppFärg)
                .aspectRatio(1, contentMode: .fit)

            VStack(alignment: .center, spacing: 0) { // <--- spacing: 0
                Text(grundämne.symbol)
                    .font(.system(size: 14)) // <--- Slightly larger font (was 13)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5) // Allow scaling down
                    .lineLimit(1)

                Text("\(grundämne.atomnummer)")
                    .font(.system(size: 8)) // <--- (was 9)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
        }
    }
}
