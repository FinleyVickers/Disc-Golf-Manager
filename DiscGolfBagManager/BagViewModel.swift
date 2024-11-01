//
//  BagViewModel.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//

import Foundation
import SwiftUI
import CoreData

class BagViewModel: ObservableObject {
    @Published var discs: [Disc] = []
    private let viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchDiscs()
    }

    func fetchDiscs() {
        let request: NSFetchRequest<DiscEntity> = DiscEntity.fetchRequest()
        do {
            let results = try viewContext.fetch(request)
            discs = results.map { Disc(entity: $0) }
        } catch {
            print("Error fetching discs: \(error)")
        }
    }

    func addDisc(name: String, type: DiscType, speed: Int, glide: Int, turn: Int, fade: Int) {
        let newDisc = DiscEntity(context: viewContext)
        newDisc.name = name
        newDisc.type = type.rawValue
        newDisc.speed = Int16(speed)
        newDisc.glide = Int16(glide)
        newDisc.turn = Int16(turn)
        newDisc.fade = Int16(fade)

        saveContext()
        fetchDiscs()
    }

    func removeDisc(at offsets: IndexSet) {
        offsets.map { discs[$0] }.forEach { disc in
            let object = viewContext.object(with: disc.id)
            viewContext.delete(object)
        }

        saveContext()
        fetchDiscs()
    }

    func suggestDisc() -> (name: String, type: DiscType, speed: Int, glide: Int, turn: Int, fade: Int)? {
        let missingTypes = DiscType.allCases.filter { type in
            !discs.contains { $0.type == type }
        }

        guard let suggestedType = missingTypes.first else {
            return nil
        }

        return (
            name: "Suggested \(suggestedType.rawValue.capitalized)",
            type: suggestedType,
            speed: 5,
            glide: 5,
            turn: 0,
            fade: 0
        )
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
