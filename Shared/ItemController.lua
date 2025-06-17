local replicatedStorage = game:GetService("ReplicatedStorage")
local assets = replicatedStorage.Assets
local ItemConfig = require(replicatedStorage.Modules.Configs.ItemConfig)

local ItemController = {}
ItemController.__index = ItemController

function ItemController.new(viewModelController)
	local self = setmetatable({}, ItemController)
	self.viewModelController = viewModelController
	
	self.inventory = {}
	for itemName, _ in pairs(ItemConfig) do
		self.inventory[itemName] = {owned = true}
	end
	
	self.equippedHands = {
		Left = nil,
		Right = nil,
	}
	return self
end

function ItemController:equipItem(itemName)
	local itemData = self.inventory[itemName]
	local itemConfig = ItemConfig[itemName]
	if not itemData or not itemConfig then return end
	
	local requireHand = itemConfig.hand -- Right, Left ou Twohanded
	
	if requireHand == "TwoHanded" then
		if self.equippedHands.Right == itemName then -- Se estiver equipado, desequip�
			print("Desequipando item de duas m�os:", itemName)
			self.viewModelController:destroyHandViewModel("Right")
			self.equippedHands.Left, self.equippedHands.Right = nil, nil
		else -- Se n�o, desequipa tudo e equipa o novo item
			print("Equipando item de duas m�os:", itemName)
			self:unequipHand("Left")
			self:unequipHand("Right")
			
			self.equippedHands.Left, self.equippedHands.Right = itemName, itemName -- Marca as duas m�os para o mesmo item
			self.viewModelController:setHandViewModel("Right", itemConfig.asset) -- Crio o viewmodel no slot right por conven��o
			if self.viewModelController.activeViewModels.Right then
				self.viewModelController.activeViewModels.Right:SetAttribute("IsTwoHanded", true)
			end
		end
	else
		if self.equippedHands[requireHand] == itemName then -- Se ja estiver equipado na m�o correta, desequipa then
			print("Desequipando", itemName, "da m�o", requireHand)
			self:unequipHand(requireHand)
		else
			print("Equipando", itemName, "na m�o", requireHand)
			if self.equippedHands.Left and self.equippedHands.Left == self.equippedHands.Right then
				self:unequipHand("Left")
			end
			self:unequipHand(requireHand)
			
			self.equippedHands[requireHand] = itemName
			self.viewModelController:setHandViewModel(requireHand, itemConfig.asset)
		end
	end
end

function ItemController:unequipHand(hand)
	if not self.equippedHands[hand] then return end
	
	local isTwoHanded = self.equippedHands.Left and (self.equippedHands.Left == self.equippedHands.Right)
	
	if isTwoHanded then
		self.viewModelController:destroyHandViewModel("Right")
		self.equippedHands.Left = nil
		self.equippedHands.Right = nil
	else
		self.viewModelController:destroyHandViewModel(hand)
		self.equippedHands[hand] = nil
	end
end

-- Fun��es para o futuro (pr�-logica)
function ItemController:isHandOccupied(hand)
	return self.equippedHands[hand] ~= nil
end

function ItemController:areBothHandsOccupied()
	return self.equippedHands.Left ~= nil and self.equippedHands.Right ~= nil
end
return ItemController