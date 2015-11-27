//
//  PokeCell.swift
//  Pokedex
//
//  Created by Dulio Denis on 11/27/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbnail.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
