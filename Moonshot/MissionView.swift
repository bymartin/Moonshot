//
//  MissionView.swift
//  Moonshot
//
//  Created by Barry Martin on 6/10/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                    .resizable()
                    .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                    .padding()
                    
                    Text(self.mission.description)
                    .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                .resizable()
                                    .frame(width: 83, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule()
                                    .stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
            
        }
        .navigationBarTitle(Text(mission.displayName),
                            displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {

        MissionView(mission: missions[0], astronauts: astronauts)
    }
}

//struct Mission: Codable, Identifiable {
//struct CrewRole: Codable {
//    let name: String
//    let role: String
//}
//
//let id: Int
//let launchDate: Date?
//let crew: [CrewRole]
//let description: String
//
//var displayName: String {
//    "Apollo \(id)"
//}
//
//var image: String {
//    "apollo\(id)"
//}
//
//var formattedLaunchDate: String {
//    if let launchDate = launchDate {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        return formatter.string(from: launchDate)
//    } else {
//        return "N/A"
//    }
//}

//"id": 1,
//"crew": [
//    {
//        "name": "grissom",
//        "role": "Command Pilot"
//    },
//    {
//        "name": "white",
//        "role": "Senior Pilot"
//    },
//    {
//        "name": "chaffee",
//        "role": "Pilot"
//    }
//],
//"description": "Apo
