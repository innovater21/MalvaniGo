//
//  PokedexViewController.swift
//  MalvaniGo
//
//  Created by admin on 06/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var caughtPokemon : [Pokemon] = []
    var uncaughtPokemon : [Pokemon] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backtoMapButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return caughtPokemon.count
        }
        else{
            return uncaughtPokemon.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var pokemon : Pokemon
        
        if indexPath.section == 0 {
            pokemon = self.caughtPokemon[indexPath.row]
            }
        else{
            pokemon = self.uncaughtPokemon[indexPath.row]
        }
        
        cell.textLabel?.text = pokemon.hello
        cell.imageView?.image = UIImage(named: pokemon.imageFileName!)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Caught Pokemon"
        }
        else{
            return "Uncaught Pokemon"
        }
    }
        //TO hide the status bar
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caughtPokemon = getAllCaughtPokemon() //Store the values in array
        uncaughtPokemon = getAllUncaughtPokemon()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
