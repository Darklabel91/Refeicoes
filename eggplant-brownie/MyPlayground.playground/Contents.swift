import UIKit

class Refeicao  {
    var nome: String
    var felicidade: String
    var itens: Array <Item> = []
    
    init(_ alimento: String, _ qualidade: String){
        self.nome = alimento
        self.felicidade = qualidade
    }
    func totalDeCalorias () -> Double{
        var total: Double = 0
        for item in itens {
            total += item.calorias
        }
        return total
    }
}

class Item {
    var nome: String
    var calorias: Double
    
    init(_ alimento: String, _ cal: Double) {
        self.nome = alimento
        self.calorias = cal
    }
}

let arroz = Item ("arroz", 51.0)
let feijao = Item ("feijão", 90.0)
let contraFile = Item("Contra Filé", 287.0)

let refeicao = Refeicao("Almoço", "3")
refeicao.itens.append(arroz)
refeicao.itens.append(feijao)
refeicao.itens.append(contraFile)

print (refeicao.nome)
if let primeiroItemDaLista = refeicao.itens.first {
    print (primeiroItemDaLista.nome)
}
print (refeicao.totalDeCalorias())


