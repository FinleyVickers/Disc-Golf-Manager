//
//  AddDiscView.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//

import Foundation
import SwiftUI
import CoreData

struct AddDiscView: View {
    @ObservedObject var viewModel: BagViewModel
    @State private var name = ""
    @State private var type = DiscType.driver
    @State private var speed = 5
    @State private var glide = 5
    @State private var turn = 0
    @State private var fade = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Disc Name", text: $name)
                Picker("Disc Type", selection: $type) {
                    ForEach(DiscType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                Stepper("Speed: \(speed)", value: $speed, in: 1...14)
                Stepper("Glide: \(glide)", value: $glide, in: 1...7)
                Stepper("Turn: \(turn)", value: $turn, in: -5...1)
                Stepper("Fade: \(fade)", value: $fade, in: 0...5)
            }
            .navigationTitle("Add New Disc")
            .navigationBarItems(trailing: Button("Save") {
                viewModel.addDisc(name: name, type: type, speed: speed, glide: glide, turn: turn, fade: fade)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddDiscView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let viewModel = BagViewModel(viewContext: viewContext)
        AddDiscView(viewModel: viewModel)
    }
}
