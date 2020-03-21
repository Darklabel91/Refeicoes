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
    
    @IBOutlet weak var itensTableView: UITableView?
    
    // MARK: - Atributos
    
    var delegate : AdicionaRefeicaoDelegate?
    var itens: [Item] = [Item(nome: "Molho de tomate", calorias: 40.0),
                         Item(nome: "Queijo", calorias: 40.0),
                         Item(nome: "Molho apimentado", calorias: 40.0),
                         Item(nome: "Manjericao", calorias: 40.0)]
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var felicidade: UITextField?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self , action:  #selector((adicionarItem)))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        
        do {
            guard let diretorio = recuperaDiretorio() else { return }
            let dados = try Data(contentsOf: diretorio)
            let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! Array<Item>
            itens = itensSalvos
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func adicionarItem(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        if let tableView = itensTableView{
            tableView.reloadData()
        }else{
            Alerta(controler: self).exibe(titulo: "Desculpe", mensagem: "Não foi possível atualizar a tabela")
        }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let caminho = recuperaDiretorio() else {return}
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appendingPathComponent("itens")
        return caminho
    }

    // MARK: - UITableViewDataSource
    
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
    
    // MARK: - UITableViewDelegate
    
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
        
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else{
            return nil
        }
        guard let felicidadeDaRefeicao = felicidade?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        return refeicao
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionar(_ sender: UIButton) {
        guard let refeicao = recuperaRefeicaoDoFormulario() else {
            Alerta(controler: self).exibe(mensagem: "Erro ao Adicionar Refeição")
            return
        }
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
}
