Config = {}

Config.AbertoAll = false
Config.TotalGaragem = 3
Config.Veiculos = {

    {
        categoria = {title="Carros", id="carros"},
        veiculos = {
			{title = "Youga", model="youga", mala=100, preco=12000, estoque = 25},
			{title = "Youga 2", model="youga2", mala=100, preco=12000, estoque = 25},
			{title = "Huntley", model="huntley", mala=30, preco=9000, estoque = 25},
			{title = "Landstalker", model="landstalker", mala=30, preco=8000, estoque = 25},
		
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