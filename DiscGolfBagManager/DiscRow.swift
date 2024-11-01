//
//  DiscRow.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//

import Foundation
import SwiftUI

struct DiscRow: View {
    let disc: Disc

    var body: some View {
        VStack(alignment: .leading) {
            Text(disc.name)
                .font(.headline)
            Text(disc.type.rawValue.capitalized)
                .font(.subheadline)
            Text("Speed: \(disc.speed), Glide: \(disc.glide), Turn: \(disc.turn), Fade: \(disc.fade)")
                .font(.caption)
        }
    }
}
