//
//  coreDataHelper.swift
//  MalvaniGo
//
//  Created by admin on 06/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import CoreData
import UIKit

func makeAllPokemon(){
  //  makePokemon(params)
    makePokemon(name: "Abra", withThe: "abra")
    makePokemon(name: "bellsprout", withThe: "bellsprout")
    makePokemon(name: "pikachu", withThe: "pikachu")
    makePokemon(name: "Pidgey", withThe: "pidgey")
    makePokemon(name: "Charmander", withThe: "charmander")
        
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
}

func makePokemon(name : String , withThe imageName: String){
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pokemon = Pokemon(context: context)
    pokemon.imageFileName = imageName
    pokemon.hello = name //pokemon name
    
}

func bringAllPokemon() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        if pokemons.count == 0{
            makeAllPokemon()
            return bringAllPokemon()
        }else{
            return pokemons
        }
    }
    catch{
        print("Error")
    }
    return []
}

func getAllCaughtPokemon() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "timesCaught > %d", 0)
    
    do{
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    }
    catch{
        print("Error")
    }
    return[]
}

func getAllUncaughtPokemon() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "timesCaught == %d", 0)
    
    do{
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    }
    catch{
        print("Error")
    }
    return[]
}
