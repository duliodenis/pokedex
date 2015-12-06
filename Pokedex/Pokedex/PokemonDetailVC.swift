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
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    
    @IBOutlet weak var evolutionLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
        let image = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = image
        currentEvolutionImage.image = image
        
        pokemon.downloadPokemonDetails { () -> () in
            // to be done after the download completes
            self.updateUI()
        }
    }
    
    
    // MARK: UI Function
    
    func updateUI() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        IDLabel.text = "\(pokemon.pokedexID)"
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        
        if pokemon.nextEvolutionID == "" {
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImage.hidden = true
        } else {
            var evolutionString = "Next Evolution: \(pokemon.nextEvolutionText)"
            if pokemon.nextEvolutionLevel != "" { evolutionString += " Level \(pokemon.nextEvolutionLevel)" }
            evolutionLabel.text = evolutionString
            nextEvolutionImage.hidden = false
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionID)
        }
    }
    
    
    // MARK: Navigation
    
    @IBAction func backAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
