local userInputService = game:GetService("UserInputService")

local InputController = {}
InputController.__index = InputController

function InputController.new(itemController)
	local self = setmetatable({}, InputController)
	
	self.itemController = itemController
	self:setupInput()
	
	self.keybinds = {
		[Enum.KeyCode.F] = "Flashlight",
		[Enum.KeyCode.One] = "M9A3",
		-- Adicione outros inputItens aqui
	}
	
	return self
end

function InputController:setupInput()
	userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if gameProcessedEvent then return end
		
		local itemName = self.keybinds[input.KeyCode]
		if itemName then
			print("Tecla mapeada pressionada:", input.KeyCode.Name)
			self.itemController:equipItem(itemName)
		end
		if input.KeyCode == Enum.KeyCode.E then
			print("Tecla E (Interação) pressionada")
			-- Adicionar lógica de interação aqui, no futuro
		end
	end)
end

return InputController