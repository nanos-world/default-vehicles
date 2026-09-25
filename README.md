# Default Vehicles

A collection of ready-to-drive vehicles built with the meshes already included in the nanos world Default Asset Pack. No extra downloads needed.

Every vehicle is a class you can spawn with a single line, and they all show up automatically in the [Sandbox](https://github.com/nanos-world/nanos-world-sandbox) Spawn Menu.


## Available Vehicles

| Class | Name | Type |
|---|---|---|
| `SUV` | SUV | Wheeled |
| `Hatchback` | Hatchback | Wheeled |
| `Sedan` | Sedan | Wheeled |
| `Wagon` | Wagon | Wheeled |
| `SportsCar` | SportsCar | Wheeled |
| `Pickup` | Pickup | Wheeled |
| `Offroad` | Offroad | Wheeled |
| `Van` | Van | Wheeled |
| `CamperVan` | CamperVan | Wheeled |
| `TruckBox` | Truck Box | Wheeled |
| `TruckChassis` | Truck Chassis | Wheeled |
| `Boat` | Boat | Water |


## Installation

Add it to the `packages_requirements` of your game-mode or package `Package.toml`:

```toml
packages_requirements = [
    "default-vehicles",
]
```


## Usage

Every vehicle is a global class that takes a location and a rotation (they are also available in the exported `NanosWorldVehicles` table):

```lua
-- Server side
local suv = SUV(Vector(0, 0, 100), Rotator(0, 90, 0))
```


## Examples

Spawn a vehicle for a player and put them in the driver seat:

```lua
Player.Subscribe("Spawn", function(player)
	local character = Character(Vector(0, 0, 100), Rotator(), "nanos-world::SK_Mannequin")
	player:Possess(character)

	local car = SportsCar(Vector(300, 0, 100), Rotator())
	character:EnterVehicle(car, 0)
end)
```

Spawn a random vehicle:

```lua
local vehicles = { "SUV", "Hatchback", "Sedan", "Pickup", "SportsCar", "Van" }
local random_vehicle = _G[vehicles[math.random(#vehicles)]](Vector(0, 0, 100), Rotator())
```

Since they are regular classes, you can tweak them after spawning or inherit from them:

```lua
-- A red SUV
local suv = SUV(Vector(0, 0, 100), Rotator())
suv:SetMaterialColorParameter("Tint", Color.RED)

-- Or create your own class based on one of them
MyPoliceCar = Sedan.Inherit("MyPoliceCar", {
	name = "Police Car",
	category = "wheeled",
})
```
