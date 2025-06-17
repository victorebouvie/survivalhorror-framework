local replicatedStorage = game:GetService("ReplicatedStorage")
local assets = replicatedStorage.Assets

local itemConfig = {
	["Flashlight"] = {
		asset = assets.ViewModels.FlashlightViewModel,
		hand = "Left", -- Mão esquerda
		-- Outras propriedades: Tipo, dano, etc
	},
	["M9A3"] = {
		asset = assets.ViewModels.M9A3Viewmodel,
		hand = "Right", -- Mão direita
		-- Outras propriedades: Tipo, dano, etc
	},
	["Remington870"] = {
		asset = assets.ViewModels.M9A3Viewmodel,
		hand = "TwoHanded", -- Ocupa as duas mãos
		-- Outras propriedades: Tipo, dano, etc
	}
}

return itemConfig