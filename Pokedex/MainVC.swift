//
//  MainVC.swift
//  Pokedex
//
//  Created by Ravi Tiwari on 3/20/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        //initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: MUSIC_FILE_NAME, ofType: MUSIC_FILE_EXTENTION)!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSABLE_POKE_CELL, for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            if inSearchMode {
               poke = self.filteredPokemon[indexPath.row]
            }
            else {
               poke = self.pokemon[indexPath.row]
            }
            cell.configureCell(pokemon: poke)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        }
        else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: POKEMON_DETAILS_VC_IDENTIFIER, sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: CSV_FILE_NAME, ofType: CSV_FILE_EXTENTION)!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row[POKEDEX_ID_KEY]!)!
                let name = row[POKEMON_NAME_KEY]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            pokeCollectionView.reloadData()
            view.endEditing(true)
        }
        else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({ $0.name.range(of: lower) != nil })
            pokeCollectionView.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonDetailsVC {
            if let poke = sender as? Pokemon {
                destination.pokemon = poke
            }
        }
    }
    
}
