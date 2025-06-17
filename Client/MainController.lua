local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules

local ViewModelControllerModule = require(Modules.ViewModelController)
local ItemControllerModule = require(Modules.ItemController)
local InputControllerModule = require(Modules.InputController)

print("Módulos carregados com sucesso.")

-- Garante que o jogo esteja em primeira pessoa
game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

local viewModelController = ViewModelControllerModule.new()

local itemController = ItemControllerModule.new(viewModelController)

local inputController = InputControllerModule.new(itemController)

print("Framework de Survival Horror inicializado no Cliente!")