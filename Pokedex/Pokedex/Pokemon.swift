//
//  Pokemon.swift
//  Pokedex
//
//  Created by Dulio Denis on 11/27/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    
    private var _nextEvolutionText: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonURL: String!
    
    
    // MARK: Getters
    
    var name: String {
        if _name == nil { _name = "" }
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        if _description == nil { _description = "" }
        return _description
    }
    
    var type: String {
        if _type == nil { _type = "" }
        return _type
    }
    
    var defense: String {
        if _defense == nil { _defense = "" }
        return _defense
    }
    
    var height: String {
        if _height == nil { _height = "" }
        return _height
    }
    
    var weight: String {
        if _weight == nil { _weight = "" }
        return _weight
    }
    
    var attack: String {
        if _attack == nil { _attack = "" }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil { _nextEvolutionText = "" }
        return _nextEvolutionText
    }
    
    var nextEvolutionID: String {
        if _nextEvolutionID == nil { _nextEvolutionID = "" }
        return _nextEvolutionID
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil { _nextEvolutionLevel = "" }
        return _nextEvolutionLevel
    }
    
    
    // MARK: Initializer
    
    init(name: String, pokedexID: Int) {
        self._name = name.capitalizedString
        self._pokedexID = pokedexID
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
    }
    
    
    // MARK: Download Closure
    // when the download is complete call the download complete closure
    // that will get all the data from the API by parsing the JSON
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let URL = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, URL).responseJSON { response in
            let result = response.result
            
            if let resultDictionary = result.value as? Dictionary<String, AnyObject> {
                
                // Weight, Height, Attack, & Defense
                
                if let weight = resultDictionary["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = resultDictionary["height"] as? String {
                    self._height = height
                }
                
                if let attack = resultDictionary["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = resultDictionary["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                // Type
                
                if let types = resultDictionary["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                // Description
                if let descriptionArray = resultDictionary["descriptions"] as? [Dictionary<String, String>]
                    where descriptionArray.count > 0 {
                        if let URL = descriptionArray[0]["resource_uri"] {
                            let nsURL = NSURL(string: "\(URL_BASE)\(URL)")!
                            
                            Alamofire.request(.GET, nsURL).responseJSON { response in
                                
                                let descriptionResult = response.result
                                if let descriptionDictionary = descriptionResult.value as? Dictionary<String, AnyObject> {
                                    if let description = descriptionDictionary["description"] as? String {
                                        self._description = description
//                                        print(self._description)
                                    }
                                }
                                completed()
                            }
                        }
                } else {
                    self._description = ""
                }
                
                // Evolutions
                if let evolutions = resultDictionary["evolutions"] as? [Dictionary<String, AnyObject>]
                    where evolutions.count > 0 {
                        if let to = evolutions[0]["to"] as? String {
                            
                            // Only support non-Mega Evolutions in App
                            // API returns Megas
                            if to.rangeOfString("mega") == nil {
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    // take the uri from "/api/v1/pokemon/###/ to ###/
                                    let imageIDString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    // take the string from ###/ to ###
                                    let imageID = imageIDString.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvolutionID = imageID
                                    self._nextEvolutionText = to
                                    
                                    if let level = evolutions[0]["level"] as? Int {
                                        self._nextEvolutionLevel = "\(level)"
                                    }
                                    
//                                    print("Next Evolution ID = \(self._nextEvolutionID)")
//                                    print("Next Evolution Text = \(self._nextEvolutionText)")
//                                    print("Next Evolution Level = \(self._nextEvolutionLevel)")
                                }
                            }
                        }
                } else {
                    self._nextEvolutionText = ""
                }
                
//                print("Name: \(self._name)")
//                print("Type: \(self._type)")
//                print("Defense: \(self._defense)")
//                print("Height: \(self._height)")
//                print("ID: \(self.pokedexID)")
//                print("Weight: \(self._weight)")
//                print("Attack: \(self._attack)")
            }
        }
    }
}