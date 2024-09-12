//
//  Header.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import SwiftUI

struct Header: View {
    var firstTitle: String
    var secondTitle: String
    var body: some View {
        VStack {
            Text("\(firstTitle)")
                .italic()
                .font(.custom("", size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            
            Text("\(secondTitle)")
                .font(.title)
                .frame(maxWidth: .infinity ,alignment: .leading)
        }
    }
}

#Preview {
    Header(firstTitle: "TRANSACTIONS", secondTitle: "Balance and movements")
}
