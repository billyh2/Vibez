//
//  File.swift
//  Vibez
//
//  Created by Billy Huang on 2022-04-23.
//

import SwiftUI

struct Block: Identifiable {
    let id = UUID()
    var color: Color
    var instrument: String
    var image: String
    var stems: [String]
}

extension Block {

    static var data: [Block] {
        [
            Block(color: .blue, instrument: "Keys", image: "p1", stems:["Blues","Campfire","Hazard","Urgency"] ),
            Block(color: .purple, instrument: "Strings", image: "p2", stems: ["Horizon", "Vacation", "Orchestral", "Driller"]),
            Block(color: .cyan, instrument: "Woodwinds", image: "p3", stems: ["Home", "Spirit", "Scream", "Mountain"]),
            Block(color: .pink, instrument: "Brass", image: "p4", stems: ["Vibe", "Soldier"]),
            Block(color: .orange, instrument: "Melodic Percusion", image: "p5", stems: ["Stars", "Sky"]),
            Block(color: .green, instrument: "Drums", image: "p6", stems: ["Party", "Player", "Tammy", "Bounce", "Boombap"]),
        ]
    }
}




