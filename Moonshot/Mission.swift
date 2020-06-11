//
//  Mission.swift
//  Moonshot
//
//  Created by Barry Martin on 6/9/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import Foundation



struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var showCrewNames: String {
        var crewNames = [String]()
        
        for person in crew {
            crewNames.append(person.name.capitalized)
        }
        return crewNames.joined(separator: ", ")
    }
}
