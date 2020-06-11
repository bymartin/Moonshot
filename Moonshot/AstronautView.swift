//
//  AstronautView.swift
//  Moonshot
//
//  Created by Barry Martin on 6/10/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missionsFlown: [String]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions Flown:")
                    
                    ForEach(self.missionsFlown, id: \.self) { mission in
                        VStack {
                            Text("\(mission)")
                                .font(.headline)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        var matchedFlights = [String]()
        
        for mission in missions {
            for _ in mission.crew {
                if mission.crew.contains(where: {$0.name == astronaut.id}) {
                    matchedFlights.append(mission.displayName)
                    break
                }
            }
        }
        self.missionsFlown = matchedFlights
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
