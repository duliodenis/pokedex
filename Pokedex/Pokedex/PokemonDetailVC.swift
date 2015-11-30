//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Dulio Denis on 11/29/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
    }
}
