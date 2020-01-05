//
//  TableViewController.swift
//  AMov1920P2ios1
//
//  Created by Alvaro Santos on 06/12/2019.
//  Copyright © 2019 DEIS-ISEC. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ActualizaReceita {
    var flagSortNome = 0
    var flagSortTempo = 0
    let app = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    func trocaFlagTempo(){
        if(flagSortTempo == 0){flagSortTempo = 1}
        else{flagSortTempo = 0}
    }
    func trocaFlagNome(){
        if(flagSortNome == 0){flagSortNome = 1}
        else{flagSortNome = 0}
    }
    //Ordena por tempo
    @IBAction func btOrdenaTempo(_ sender: Any) {
        if(flagSortTempo == 0){
            app.lstReceitas = app.lstReceitas.sorted(){$0.tempo > $1.tempo}
            trocaFlagTempo()
        }
        else{
            app.lstReceitas = app.lstReceitas.sorted(){$0.tempo < $1.tempo}
            trocaFlagTempo()
        }
        //app.lstReceitas.reverse()WORKS
        tableView.reloadData()
    }
    //Ordena por nome de receita
    @IBAction func btOrdenaNome(_ sender: Any) {
        if(flagSortNome == 0){
            app.lstReceitas = app.lstReceitas.sorted(){$0.nome > $1.nome}
            trocaFlagNome()
        }
        else{
            app.lstReceitas = app.lstReceitas.sorted(){$0.nome < $1.nome}
            trocaFlagNome()
        }
        //app.lstReceitas.reverse()WORKS
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return app.lstReceitas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let receita = app.lstReceitas[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "receita", for: indexPath)

        cell.textLabel?.text = receita.nome
        cell.detailTextLabel?.text = receita.categoria

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            app.lstReceitas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let receita = app.lstReceitas.remove(at: fromIndexPath.row)
        app.lstReceitas.insert(receita, at: to.row)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receita = app.lstReceitas[indexPath.row]

        performSegue(withIdentifier: "segueReceita", sender: receita)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueReceita" {
            let vc  = segue.destination as! ViewController
            vc.delegate = self
            if let receita = sender as? Receita {
                vc.receita = receita
            }
        }
    }
    

    func novaReceita(receita: Receita) {
        app.lstReceitas.append(receita)
        tableView.reloadData()
    }
    
    func actualizaReceita(receita: Receita) {
        tableView.reloadData()
    }
    

}
