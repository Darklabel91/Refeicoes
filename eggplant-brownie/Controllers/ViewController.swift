//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit
protocol ViewControllerDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController {
    
    var delegate : ViewControllerDelegate?
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidade: UITextField?
    
    @IBAction func adicionar(_ sender: UIButton) {
        
        if let nomeDaRefeicao = nomeTextField?.text , let felicidadeDaRefeicao = felicidade?.text {
            let nome   = nomeDaRefeicao
            
            if let felicidade = Int(felicidadeDaRefeicao){
            
                let refeicao = Refeicao(nome, felicidade)
                
                print("Alimento \(refeicao.nome) e nível de satisfação \(refeicao.felicidade) adicionado com sucesso!")
                delegate?.add(refeicao)
            }
        }else{
            print("Erro ao criar refeição")
        }
        navigationController?.popViewController(animated: true)
    }
}

