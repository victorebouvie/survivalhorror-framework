local replicatedStorage = game:GetService("ReplicatedStorage")
local assets = replicatedStorage.Assets

local itemConfig = {
	["Flashlight"] = {
		asset = assets.ViewModels.FlashlightViewModel,
		hand = "Left", -- M�o esquerda
		-- Outras propriedades: Tipo, dano, etc
	},
	["M9A3"] = {
		asset = assets.ViewModels.M9A3Viewmodel,
		hand = "Right", -- M�o direita
		-- Outras propriedades: Tipo, dano, etc
	},
	["Remington870"] = {
		asset = assets.ViewModels.M9A3Viewmodel,
		hand = "TwoHanded", -- Ocupa as duas m�os
		-- Outras propriedades: Tipo, dano, etc
	}
}

return itemConfig