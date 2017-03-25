//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Ravi Tiwari on 3/24/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDescLbl: UILabel!
    @IBOutlet weak var currentEvolPokemonImage: UIImageView!
    @IBOutlet weak var pokemonNextEvolImage: UIImageView!
    @IBOutlet weak var pokemonTypeLbl: UILabel!
    @IBOutlet weak var pokemonDefenseLbl: UILabel!
    @IBOutlet weak var pokemonHeightLbl: UILabel!
    @IBOutlet weak var pokemonPokedexIdLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonBaseAttackLbl: UILabel!
    @IBOutlet weak var pokemonEvolLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    func updateUI() {
        pokemonHeightLbl.text = pokemon.height
        pokemonWeightLbl.text = pokemon.weight
        pokemonDefenseLbl.text = pokemon.defense
        pokemonImage.image = pokemon.image
        currentEvolPokemonImage.image = pokemon.image
        pokemonBaseAttackLbl.text = pokemon.attack
        pokemonPokedexIdLbl.text = pokemon.pokedexId
        pokemonNameLbl.text = pokemon.name
        pokemonTypeLbl.text = pokemon.type
        pokemonDescLbl.text = pokemon.description
        pokemonNextEvolImage.isHidden = pokemon.isNextImageEvolutionImageHidden
        pokemonNextEvolImage.image = pokemon.nextEvolutionImage
        pokemonEvolLbl.text = pokemon.nextEvolutionDescription
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
