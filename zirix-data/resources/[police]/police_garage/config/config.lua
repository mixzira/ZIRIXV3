Config = {}

Config.AbertoAll = false
Config.TotalGaragem = 3
Config.Veiculos = {

    {
        categoria = {title="Carros", id="carros"},
        veiculos = {
			{title = "Adder", model="adder", mala=100, preco=1, estoque = 25},
			{title = "Policia 2", model="voltic", mala=100, preco=1, estoque = 25},
			{title = "Policia 3", model="police3", mala=30, preco=1, estoque = 25},
			{title = "Policia 4", model="police4", mala=30, preco=1, estoque = 25},
		
        }
    },
    {
        categoria = {title="Motos", id="motos"},
        veiculos = {         
            {title = "Akuma", model="akuma", mala=10, preco=16000, estoque = 25}, 			
        }
    },
}

function getVeiculo(modelo)
    for i, cat in pairs(Config.Veiculos) do
        for i2, carro in pairs(cat.veiculos) do 
            if carro.model == modelo then
                return carro
            end
        end
    end
end


function getVeiculos()
    local veiculos = {}
    for i, cat in pairs(Config.Veiculos) do
        for i2, carro in pairs(cat.veiculos) do 
            veiculos[carro.model] = carro
        end
    end

    return veiculos
end