//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ravi Tiwari on 3/20/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _image: UIImage!
    private var _description: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: String!
    private var _weight: String!
    private var _attack: Int!
    private var _evolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    var nextEvolutionImage: UIImage {
        if nextEvolutionId == "" {
            return UIImage()
        }
        return UIImage(named: nextEvolutionId)!
    }
    
    var nextEvolutionDescription: String {
        if nextEvolutionId == "" {
            return "No Evolutions"
        }
        return "Next Evolution: \(nextEvolutionName) - LVL \(nextEvolutionLvl)"
    }
    
    var isNextImageEvolutionImageHidden: Bool {
        if nextEvolutionId == "" {
            return true
        }
        return false
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            return ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            return ""
        }
        return _nextEvolutionId
    }

    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            return ""
        }
        return _nextEvolutionLvl
    }

    var name: String {
        return _name
    }
    
    var pokedexId: String {
        if _pokedexId == nil {
            return ""
        }
        return "\(_pokedexId!)"
    }
    
    var image: UIImage {
        return UIImage(named: pokedexId)!
    }
    
    var description: String {
        if _description == nil {
            return ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var height: String {
        if _height == nil {
            return ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    
    var evolutionText: String {
        if _evolutionText == nil {
            return ""
        }
        return _evolutionText
    }
    
    var attack: String {
        if _attack == nil {
            return ""
        }
        return "\(_attack!)"
    }
    
    var defense: String {
        if _defense == nil {
            return ""
        }
        return "\(_defense!)"
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name.capitalized
        self._pokedexId = pokedexId
        
        self._pokemonUrl = "\(POKEMON_BASE_URL)\(POKEMON_VERSION_URL)\(pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        let pokemonURL = URL(string: self._pokemonUrl)!
        
        Alamofire.request(pokemonURL).responseJSON { response in
            if let jsonResponseDict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = jsonResponseDict[WEIGHT_KEY] as? String {
                    self._weight = weight
                }
                if let height = jsonResponseDict[HEIGHT_KEY] as? String {
                    self._height = height
                }
                if let attack = jsonResponseDict[ATTACK_KEY] as? Int {
                    self._attack = attack
                }
                if let defense = jsonResponseDict[DEFENSE_KEY] as? Int {
                    self._defense = defense
                }
                if let types = jsonResponseDict[TYPES_KEY] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    if let name = types[0][NAME_KEY] {
                        self._type = name.capitalized!
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x][NAME_KEY] {
                                self._type! += "/\(name.capitalized!)"
                            }
                        }
                    }
                }
                if let descArr = jsonResponseDict[DESCRIPTIONS_KEY] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let url = descArr[0][RESOURCE_URI_KEY] {
                        let descURL = "\(POKEMON_BASE_URL)\(url)"
                        print(descURL)
                        Alamofire.request(descURL).responseJSON { response in
                            if let descRespDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let desc = descRespDict[DESCRIPTION_KEY] as? String {
                                    let newDescription = desc.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    print(newDescription)
                                    self._description = newDescription
                                }
                            }
                            completed()
                        }
                    }
                }
                if let evolution = jsonResponseDict[EVOLUTIONS_KEY] as? [Dictionary<String, AnyObject>], evolution.count > 0 {
                    if let nextEvol = evolution[0][TO_KEY] as? String {
                        if nextEvol.range(of: MEGA_KEY) == nil {
                            self._nextEvolutionName = nextEvol
                            if let uri = evolution[0][RESOURCE_URI_KEY] as? String {
                                let newStr = uri.replacingOccurrences(of: POKEMON_VERSION_URL, with: "")
                                let nextEvolId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvolId
                                if let lvlExists = evolution[0][LEVEL_KEY] {
                                    if let lvl = lvlExists as? Int {
                                        self._nextEvolutionLvl = "\(lvl)"
                                    }
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
    
}
