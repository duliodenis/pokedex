//
//  ViewController.swift
//  Pokedex
//
//  Created by Dulio Denis on 11/26/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var music: AVAudioPlayer!
    var inSearchMode = false

    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        initAudio()
        music.play()
        parsePokemonCSV()
    }

    
    // MARK: Utility Functions
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSVParser(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name   = row["identifier"]!
                let poke   = Pokemon(name: name, pokedexID: pokeID)
                pokemon.append(poke)
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    
    func initAudio() {
        do {
            try music = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!))
            music.numberOfLoops = -1
            music.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    
    @IBAction func musicToggle(sender: UIButton) {
        if music.playing {
            music.stop()
            sender.alpha = 0.4
            sender.setImage(UIImage(named: "volume-off"), forState: .Normal)
        } else {
            music.play()
            sender.alpha = 1.0
            sender.setImage(UIImage(named: "volume-on"), forState: .Normal)
        }
    }
    
    
    // MARK: Collection View Delegates
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    
    // MARK: Search Bar Delegates
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
 
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            // let lower = searchText!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil})
            collection.reloadData()
        }
    }
    
}

