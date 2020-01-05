//
//  ViewController.swift
//  AMov1920P2ios1z
//
//  Created by Alvaro Santos on 29/11/2019.
//  Copyright © 2019 DEIS-ISEC. All rights reserved.
//

import UIKit
import MapKit

protocol ActualizaReceita {
    func novaReceita(receita: Receita)
    func actualizaReceita(receita: Receita)
}

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfTelefone: UITextField!
    @IBOutlet weak var pickerCategoria: UIPickerView!
    @IBOutlet weak var tfTempoReceita: UITextField!
    
    @IBOutlet weak var tvDescricao: UITextView!
    @IBOutlet weak var btAddIngrediente: UIButton!
    @IBOutlet weak var tfNomeIngrediente: UITextField!
    @IBOutlet weak var tfQntIngrediente: UITextField!
    @IBOutlet weak var tfUnidadeIngrediente: UITextField!
    
    
    var delegate : ActualizaReceita?
    var receita : Receita?
    var pickerCategoriaData: [String] = [String]()
    var pickerIngredienteData:[String] = [String]()
    var ingredientes:[Ingrediente] = [Ingrediente]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//Esconder teclado
        //fonte: StackOF
        //Fica atento a toques no ecra
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
//FIM esconder teclado
//Mover a view quando abre teclado
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//Fim Mover a view quando abre teclado
        //Ligar os dados
        self.pickerCategoria.delegate = self
        self.pickerCategoria.dataSource = self
        
        //Dados estáticos para o array da picker
        pickerCategoriaData = ["Entrada","Sopa","Carne","Peixe","Sobremesa"]
        pickerIngredienteData = ["Ingrediente1","Ingrediente1","Ingrediente2","Ingrediente3","Ingrediente4"]
        if let receita = receita {//SE FOR EDICAO da receita
            tfNome.text = receita.nome
            tfTempoReceita.text = String(receita.tempo)
            tvDescricao.text = receita.descricao
            //Carrega a categoria presente na receita
            var row : Int = 0
            for cate in pickerCategoriaData{
                if cate == receita.categoria{
                    break
                }
                row += 1
            }
            pickerCategoria.selectRow(row, inComponent: 0, animated: true)
            
        }
        tfNome.becomeFirstResponder()
        
    }
    //funcao para esconder o teclado
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if(!tfNome.isEditing){
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        
    }
    @IBAction func addIngrediente(_ sender: Any) {
        guard let nomeIng = tfNomeIngrediente.text else {return}
        guard let qntIng = tfQntIngrediente.text else {return}
        guard let unidIng = tfUnidadeIngrediente.text else {return}
        
        let ing = Ingrediente(nome: nomeIng, quantidade: Int(qntIng)!, unidade: unidIng)
        ingredientes.append(ing)
        print(ing.description)
        //limpa os campos
        tfNomeIngrediente.text = ""
        tfQntIngrediente.text = ""
        tfUnidadeIngrediente.text = ""
        
    }
//DATA PICKER--------------------------------
    //pede o num de elems q quero mostrar. Neste caso é só 1 de cada X
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //pede o tamanho do array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerCategoriaData.count
        } else {
            return pickerIngredienteData.count
        }
    }
    //pede os titulo para uma row especifica
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return pickerCategoriaData[row]
        } else {
            return pickerIngredienteData[row]
        }
    }
    
    //deteta qual a row seleccionada pelo utilizador(didSelectRow)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dismissKeyboard()//pequeno truque para nao rebentar a interface..
        tfTempoReceita.becomeFirstResponder()
    }
//FIM DATA PICKER----------------------------
    @IBAction func onAdicionar(_ sender: Any) {
        guard let nome = tfNome.text else {
            return
        }
        guard let tempo = tfTempoReceita.text else {
            return
        }
        guard let descricao = tvDescricao.text else {
            return
        }
        let categoria = pickerCategoriaData[pickerCategoria.selectedRow(inComponent: 0)]
        if nome.isEmpty {
            tfNome.becomeFirstResponder()
            return
        }
        
        if let receita = receita {
            receita.nome = nome
            receita.tempo = Int(tempo)!
            receita.categoria = categoria
            receita.ingredientes = ingredientes
            receita.descricao = descricao
            delegate?.actualizaReceita(receita: receita)
        } else {
            let receita = Receita(nome: nome, categoria: categoria, tempo: Int(tempo)!, ingredientes: ingredientes, descricao: descricao)
            print(receita.description)//debug
            delegate?.novaReceita(receita: receita)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    
}

