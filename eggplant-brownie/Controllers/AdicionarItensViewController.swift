//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 18/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit

class AdicionarItensViewController: UIViewController {

    // MARK: -IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        // navegar para proxima tela: navigationController.push()
        // voltar para tela anterior: navigationController.pop()
        
        guard let nome = nomeTextField.text, let calorias = caloriasTextField.text else {return}
        
        if let numeroDeCalorias = Double(calorias){
            let _ = Item(nome,numeroDeCalorias)
            navigationController?.popViewController(animated: true)           
        }
    }
}
