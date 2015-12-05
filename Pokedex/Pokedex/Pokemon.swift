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
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    
    private var _nextEvolutionText: String!
    
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