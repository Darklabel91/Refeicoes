//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Daniel Fillol on 14/03/20.
//  Copyright © 2020 Entendendo Direito. All rights reserved.
//

import UIKit
protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate{
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var itensTableView: UITableView!
    
    // MARK: - Atributos
    
    var delegate : AdicionaRefeicaoDelegate?
    var itens: [Item] = [Item("Molho de tomate", 40),
                         Item("Queijo", 40),
                         Item("Molho Apimentado", 40),
                         Item("Manjericão", 40)]
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidade: UITextField?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self , action: Selector(("adicionarItem")))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
    }
    
    @objc func adicionarItem(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
    }
    
    // MARK: - UItableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        celula.textLabel?.text = item.nome
        return celula
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else {return}
        if celula.accessoryType == .none{
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        }else{
            celula.accessoryType = .none
            let item = itens[indexPath.row]
            if let posicao = itensSelecionados.index(of: item){
                itensSelecionados.remove(at: posicao)
//              teste para checar se estamos deletando todos os itens, idex está sendo deprecado pela Apple :-(
//              for itensSelecionado in itensSelecionados {
//                  print(itensSelecionado.nome)
//              }
            }
        }
    }
    
    // MARK: IBA Actions
      
    @IBAction func adicionar(_ sender: UIButton) {
        
        if let nomeDaRefeicao = nomeTextField?.text , let felicidadeDaRefeicao = felicidade?.text {
            let nome   = nomeDaRefeicao
            if let felicidade = Int(felicidadeDaRefeicao){
                let refeicao = Refeicao(nome, felicidade, itensSelecionados)
                print("Alimento \(refeicao.nome) e nível de satisfação \(refeicao.felicidade) adicionado com sucesso!")
                delegate?.add(refeicao)
            }
        }else{
            print("Erro ao criar refeição")
        }
        navigationController?.popViewController(animated: true)
    }
}

