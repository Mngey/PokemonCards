//
//  PokemonShowViewController.swift
//  PokemonCards
//
//  Created by a.a.mitrofanova on 14/09/2020.
//  Copyright © 2020 mngey. All rights reserved.
//

import UIKit

class PokemonShowViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textlabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let pokemon = pokemon {
            ImageController.getImage(for: pokemon.imageUrl ?? "", completion: { (image) in
               self.imageView.image = image
            })
            //textlabel.text = pokemon.pokemonSet
        }else{
                print("pokemon image is nil")
            }
        }
    }
 


