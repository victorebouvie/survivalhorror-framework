# Roblox Survival Horror Framework (Lua)

![Roblox](https://img.shields.io/badge/Platform-Roblox-red?style=for-the-badge&logo=roblox)
![Language](https://img.shields.io/badge/Language-Luau-blue?style=for-the-badge)

A modular and lightweight first-person equipment framework for survival horror and FPS games built on Roblox. This system handles viewmodels, item equipping, and input handling with a clean, extensible, and easy-to-configure architecture.

---

![Preview](https://github.com/victorebouvie/survivalhorror-framework/blob/main/ProjectdemoGIF.gif?raw=true)

---

## 📋 Table of Contents

*   [About The Project](#-about-the-project)
*   [Key Features](#-key-features)
*   [Architecture](#️-architecture-how-it-works)
*   [Getting Started](#-getting-started)
    *   [File Structure](#file-structure)
    *   [Installation](#installation)
*   [Usage & Configuration](#️-usage--configuration)
    *   [Adding a New Item](#adding-a-new-item)
    *   [Configuring Keybinds](#configuring-keybinds)
*   [Roadmap](#️-roadmap)

---

## 📖 About The Project

This framework was built to provide a solid and reusable foundation for first-person item systems. Instead of rewriting the same ViewModel and equipment logic for every new project, this framework offers a clean, modular, and performance-oriented solution, allowing developers to focus on building unique gameplay mechanics.

The core philosophy is **modularity**, allowing each part of the system (Input, Item Logic, Visuals) to be modified or replaced without breaking the entire codebase.

---

## ✨ Key Features

*   ✅ **Dynamic ViewModel System**: Supports items for the left hand, right hand, and items that require both hands.
*   ✅ **Centralized Item Configuration**: Easily add or modify items through a single configuration file.
*   ✅ **Clean OOP Architecture**: Written in pure Luau with a focus on readable, decoupled, and maintainable code.
*   ✅ **Easily Extendable**: Designed to be the base for more complex systems like animations, ammo, and interaction.
*   ✅ **Customizable Keybinds**: Map keyboard inputs to item actions in a simple and intuitive way.

---

## ⚙️ Architecture (How It Works)

The framework is divided into four main modules that work together to create a clear separation of concerns.

1.  **`InputController`**: Captures player keyboard inputs. It doesn't know what an item does; it simply tells the `ItemController` that the player wants to equip a specific item.
2.  **`ItemController`**: The "brain" of the system. It manages the inventory, knows what is equipped in each hand, and handles the logic for equipping/unequipping items (e.g., unequipping a pistol to equip a two-handed rifle).
3.  **`ViewModelController`**: The presentation layer. It is responsible for loading, positioning, and destroying the 3D item models (ViewModels) that the player sees. It has no game logic and only follows commands from the `ItemController`.
4.  **`ItemConfig`**: A configuration module that acts as a database for all items, defining their properties (3D model, required hand, etc.).

The data flow is simple and efficient:
**`Input`** → **`ItemController`** (Logic) → **`ViewModelController`** (Visuals)

---

## 🚀 Getting Started

Follow these steps to integrate the framework into your Roblox project.

### File Structure

For the framework to work correctly, your files should follow this structure inside `ReplicatedStorage`:

```
ReplicatedStorage
├── Assets
│   └── ViewModels
│       ├── FlashlightViewModel
│       ├── M9A3ViewModel
│       └── Other Items/ViewModels
└── Modules
    ├── Configs
    │   └── ItemConfig.lua
    ├── InputController
    ├── ItemController
    └── ViewModelController
```

### Installation

1.  Clone this repository or copy the files into your project, following the structure above.
2.  Create a `LocalScript` inside `StarterPlayer > StarterPlayerScripts`.
3.  Paste the following code into this `LocalScript`. This will be the entry point to initialize the framework on the client.

```lua
-- LocalScript in StarterPlayer.StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage.Modules

-- Load the framework modules
local ViewModelControllerModule = require(Modules.ViewModelController)
local ItemControllerModule = require(Modules.ItemController)
local InputControllerModule = require(Modules.InputController)

-- Ensure the player's camera is locked to first-person
game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

-- Initialize the controllers in the correct order
local viewModelController = ViewModelControllerModule.new()
local itemController = ItemControllerModule.new(viewModelController)
local inputController = InputControllerModule.new(itemController)

print("Survival Horror Framework Initialized on Client!")
```

## 🛠️ Usage & Configuration
Customizing the framework is designed to be quick and easy.

### Adding a New Item
Place your item's Model (the ViewModel) into the ReplicatedStorage/Assets/ViewModels/ folder.
Open the ReplicatedStorage/Modules/Configs/ItemConfig.lua file.
Add a new entry to the itemConfig table, following the format:

```lua
-- Inside ItemConfig.lua
local itemConfig = {
    -- ... other items
    
    ["YourItemName"] = {
        asset = assets.ViewModels.YourItemModelName, -- Path to your Model
        hand = "Right", -- Can be "Left", "Right", or "TwoHanded"
        -- Add other properties here in the future (damage, type, etc.)
    },
}
```

### Configuring Keybinds
Open the ReplicatedStorage/Modules/InputController.lua file.
Add or modify an entry in the self.keybinds table to link a key to an ItemName (the same name you used in ItemConfig).

```lua
-- Inside InputController.lua's new() function
self.keybinds = {
    [Enum.KeyCode.F] = "Flashlight",
    [Enum.KeyCode.One] = "M9A3",
    [Enum.KeyCode.G] = "YourItemName", -- Example for 'G' key
}
```

## 🗺️ Roadmap
This project is under active development. See the open issues for a full list of proposed features (and known issues).
Animation System: Implement the playAnimation function to handle equip, attack, and reload animations.
Interaction System: Develop the logic for the interaction key (E) to allow picking up items or interacting with objects.
Ammo & Reloading: Add logic for firearms.
Aim Down Sights (ADS): Implement an aiming system for weapons.
Sound Effects: Integrate sounds for equipping, using, and storing items.
