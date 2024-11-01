//
//  DIsc.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//

import Foundation
import CoreData

struct Disc: Identifiable {
    let id: NSManagedObjectID
    var name: String
    var type: DiscType
    var speed: Int
    var glide: Int
    var turn: Int
    var fade: Int

    init(entity: DiscEntity) {
        id = entity.objectID
        name = entity.name ?? ""
        type = DiscType(rawValue: entity.type ?? "") ?? .driver
        speed = Int(entity.speed)
        glide = Int(entity.glide)
        turn = Int(entity.turn)
        fade = Int(entity.fade)
    }

    init(id: NSManagedObjectID, name: String, type: DiscType, speed: Int, glide: Int, turn: Int, fade: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.speed = speed
        self.glide = glide
        self.turn = turn
        self.fade = fade
    }
}

enum DiscType: String, Codable, CaseIterable {
    case driver, fairwayDriver, midrange, putter
}

extension DiscEntity {
    func update(from disc: Disc) {
        self.name = disc.name
        self.type = disc.type.rawValue
        self.speed = Int16(disc.speed)
        self.glide = Int16(disc.glide)
        self.turn = Int16(disc.turn)
        self.fade = Int16(disc.fade)
    }
}
