//
//  Transaction.swift
//  LearnActors
//
//  Created by Diegoe012 on 6/09/24.
//

import Foundation

struct Transaction: Hashable, Identifiable {
    let id : UUID
    let date : String
    let value : Double
    let description : String
}
