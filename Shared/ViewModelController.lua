local runService = game:GetService("RunService")
local ViewModelController = {}
ViewModelController.__index = ViewModelController

local camera = workspace.CurrentCamera

function ViewModelController.new()
	local self = setmetatable({}, ViewModelController)
	
	self.activeViewModels = {
		Left = nil,
		Right = nil,
	}
	
	self.handOffsets = {
		Left = CFrame.new(-0.8, -0.8, -0.5),
		Right = CFrame.new(-0.8, -0.8, -0.5),
		TwoHanded = CFrame.new(-0.8, -0.8, -0.5),
	}
	
	runService.RenderStepped:Connect(function()
		self:update()
	end)
	return self
end

function ViewModelController:setHandViewModel(hand, viewModelAsset)
	self:destroyHandViewModel(hand)
	
	if viewModelAsset then
		local viewModel = viewModelAsset:Clone()
		viewModel.Parent = camera
		self.activeViewModels[hand] = viewModel
	end
end

function ViewModelController:destroyHandViewModel(hand)
	if self.activeViewModels[hand] then
		self.activeViewModels[hand]:Destroy()
		self.activeViewModels[hand] = nil
	end
end

function ViewModelController:update()
	for hand, viewModel in pairs(self.activeViewModels) do
		if viewModel then
			local isTwoHanded = viewModel:GetAttribute("IsTwoHanded")
			local offset = isTwoHanded and self.handOffsets.TwoHanded or self.handOffsets[hand]
			viewModel:SetPrimaryPartCFrame(camera.CFrame * offset)
		end
	end
end

function ViewModelController:playAnimation(animationId)
	-- Por logica para animação quando estiver com vontade de fazer
end

return ViewModelController