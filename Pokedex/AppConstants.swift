//
//  Constants.swift
//  Pokedex
//
//  Created by Ravi Tiwari on 3/21/17.
//  Copyright © 2017 SelfStudy. All rights reserved.
//

import Foundation

let REUSABLE_POKE_CELL = "pokeCell"
let CSV_FILE_NAME = "pokemon"
let CSV_FILE_EXTENTION = "csv"
let POKEDEX_ID_KEY = "id"
let POKEMON_NAME_KEY = "identifier"
let MUSIC_FILE_NAME = "music"
let MUSIC_FILE_EXTENTION = "mp3"
let POKEMON_DETAILS_VC_IDENTIFIER = "PokemonDetailsVC"

let POKEMON_BASE_URL = "http://pokeapi.co"
let POKEMON_VERSION_URL = "/api/v1/pokemon/"

let WEIGHT_KEY = "weight"
let HEIGHT_KEY = "height"
let ATTACK_KEY = "attack"
let DEFENSE_KEY = "defense"
let POKEDEXID_KEY = "pkdx_id"
let NAME_KEY = "name"
let TYPES_KEY = "types"
let DESCRIPTIONS_KEY = "descriptions"
let DESCRIPTION_KEY = "description"
let RESOURCE_URI_KEY = "resource_uri"
let EVOLUTIONS_KEY = "evolutions"
let TO_KEY = "to"
let MEGA_KEY = "mega"
let LEVEL_KEY = "level"

//Closure for download complete
typealias DownloadComplete = () -> ()
