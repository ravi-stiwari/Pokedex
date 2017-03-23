//
//  PokeCell.swift
//  Pokedex
//
//  Created by Ravi Tiwari on 3/21/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
    }
    
}
