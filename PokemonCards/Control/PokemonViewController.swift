//
//  ViewController.swift
//  PokemonCards
//
//  Created by a.a.mitrofanova on 14/09/2020.
//  Copyright © 2020 mngey. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    var pokey: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémon List"
        tableView.dataSource = self
        getPokemon()
    }

    func getPokemon(){
        let url = URL(string: "https://api.pokemontcg.io/v1/cards")!
        
        NetworkController.performRequest(for: url, httpMethod: .Get){
            (data, error) in
            if let error = error {
                print("error from url \(url.absoluteString), err: \(error.localizedDescription)")
            }
        
      if let data = data{
                do {
                    let card = try JSONDecoder().decode(Card.self, from: data)
                    self.pokey = card.cards
                }catch{
                    print("failed to decode from pokey data \(error.localizedDescription). Data: \(data)")
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                    print("data is nil!")
                }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPokemonShow",
            let showView = segue.destination as? PokemonShowViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            showView.pokemon = pokey[row]
        }
    }
}


    extension PokemonViewController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokey.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokeyCell", for: indexPath)
    cell.textLabel?.text = pokey[indexPath.row].name
    cell.detailTextLabel?.text = pokey[indexPath.row].pokemonSet
    return cell
}
}

