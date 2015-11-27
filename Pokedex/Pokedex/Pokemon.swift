//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dulio Denis on 11/27/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexId = pokedexID
    }
}