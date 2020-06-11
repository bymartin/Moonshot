//
//  ContentView.swift
//  Moonshot
//
//  Created by Barry Martin on 6/9/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showCrew = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination:
                MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                    .resizable()
                        //.aspectRatio(contentMode: .fit)
                    .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        if self.showCrew {
                            Text(mission.showCrewNames)
                        }
                        else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
        .navigationBarTitle("Moonshot")
        .navigationBarItems(trailing:
            Button(self.showCrew ? "Date" : "Crew") {
                self.showCrew.toggle()
            }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
