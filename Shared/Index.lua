---@class NanosWorldVehicles
NanosWorldVehicles = {}
Package.Export("NanosWorldVehicles", NanosWorldVehicles)

---@class Offroad : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): Offroad
NanosWorldVehicles.Offroad = VehicleWheeled.Inherit("Offroad", {
	name = "Offroad",
	image = "assets://nanos-world/Thumbnails/SK_Offroad.jpg",
	category = "wheeled",

	-- Cached tables
	torque_curve = {
		[   0.0] = 0.5,
		[ 800.0] = 0.9,
		[2000.0] = 1.0,
		[4000.0] = 0.9,
		[5000.0] = 0.0,
	},
	forward_gears = { 4.25, 2.52, 1.66, 1.22, 1 },
	reverse_gears = { 4.04 },
})

function NanosWorldVehicles.Offroad:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Offroad", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_15", "nanos-world::A_Vehicle_Horn_Toyota", "nanos-world::A_Vehicle_Skid", "nanos-world::A_Car_Engine_Start", "nanos-world::A_Vehicle_Door", true, "nanos-world::ABP_Offroad")

	self:AddStaticMeshAttached("body", "nanos-world::SM_Offroad_Body")
	self:AddStaticMeshAttached("wheel_FL", "nanos-world::SM_Offroad_Tire", "VisWheel_FL")
	self:AddStaticMeshAttached("wheel_FR", "nanos-world::SM_Offroad_Tire", "VisWheel_FR", Vector(), Rotator(0, 180, 0))
	self:AddStaticMeshAttached("wheel_BL", "nanos-world::SM_Offroad_Tire", "VisWheel_BL")
	self:AddStaticMeshAttached("wheel_BR", "nanos-world::SM_Offroad_Tire", "VisWheel_BR", Vector(), Rotator(0, 180, 0))
	self:AddStaticMeshAttached("steering_wheel", "nanos-world::SM_Steering_Wheel_01", "", Vector(50, -30, 115), Rotator(0, 90, 0))

	self:SetCameraOffset(Vector(0, 0, 100))

	self:SetEngineSetup(400, 4000, 900, 0.2, 5, 600, self.torque_curve)
	self:SetAerodynamicsSetup(1500, 0.1, 180, 160, 0.1, Vector(10, 0, 40))
	self:SetSteeringWheelSetup(Vector(43, -30, 115), 23, Rotator(-5, 0, 0))
	self:SetTransmissionSetup(2.81, 3500, 2000, 0.2, 0.9, self.forward_gears, self.reverse_gears)
	self:SetSteeringSetup(SteeringType.Ackermann)
	self:SetDifferentialSetup(DifferentialType.AllWheelDrive)

	self:SetWheel(0, "PhysWheel_FL", 50, 20, 40, Vector(), true, true, false, false, false, 3000, 6000, 1000, 1, 4, 20, 20, 100, 100, 20, 20, 0, 0.5, 0.7, Vector(0, 0, -1), Vector(), SuspensionSweepShape.Shapecast)
	self:SetWheel(1, "PhysWheel_FR", 50, 20, 40, Vector(), true, true, false, false, false, 3000, 6000, 1000, 1, 4, 20, 20, 100, 100, 20, 20, 0, 0.5, 0.7, Vector(0, 0, -1), Vector(), SuspensionSweepShape.Shapecast)
	self:SetWheel(2, "PhysWheel_BL", 50, 20,  0, Vector(), true, true, true,  false, false, 3000, 6000, 1000, 1, 4, 20, 20, 100, 100, 20, 20, 0, 0.5, 0.7, Vector(0, 0, -1), Vector(), SuspensionSweepShape.Shapecast)
	self:SetWheel(3, "PhysWheel_BR", 50, 20,  0, Vector(), true, true, true,  false, false, 3000, 6000, 1000, 1, 4, 20, 20, 100, 100, 20, 20, 0, 0.5, 0.7, Vector(0, 0, -1), Vector(), SuspensionSweepShape.Shapecast)

	self:SetDoor(0, Vector(0, -80, 100), Vector(12, -30, 90), Rotator(0, 0,   0), 75, -150)
	self:SetDoor(1, Vector(0,  80, 100), Vector(40,  32, 90), Rotator(0, 0, -15), 75,  150)

	self:RecreatePhysics()
end

---@class CamperVan : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): CamperVan
NanosWorldVehicles.CamperVan = VehicleWheeled.Inherit("CamperVan", {
	name = "CamperVan",
	image = "assets://nanos-world/Thumbnails/SK_CamperVan.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.CamperVan:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_CamperVan", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_08")

	self:SetEngineSetup(550, 5200)
	self:SetAerodynamicsSetup(2700, 0.6, 600, 220, 0.3, Vector(10, 0, 39))
	self:SetSteeringWheelSetup(Vector(219, -59, 165), 23, Rotator(-35, 0, 0))
	self:SetHeadlightsSetup(Vector(400, 0, 70))
	self:SetTaillightsSetup(Vector(-350, 0, 70))
	self:SetExplosionSettings(Vector(), {}, { 6 })

	self:SetWheel(0, "Wheel_Front_Left",  39, 24, 55, Vector(), false, true, false, false, false, 3000, 6000, 1000, 1, 2, 20, 20, 150, 30, 2, 10, 0, 0.5, 0.3)
	self:SetWheel(1, "Wheel_Front_Right", 39, 24, 55, Vector(), false, true, false, false, false, 3000, 6000, 1000, 1, 2, 20, 20, 150, 30, 2, 10, 0, 0.5, 0.3)
	self:SetWheel(2, "Wheel_Rear_Left",   39, 41,  0, Vector(),  true, true,  true, false, false, 3000, 6000, 1000, 1, 5, 20, 20, 150, 30, 2, 10, 0, 0.5, 0.3)
	self:SetWheel(3, "Wheel_Rear_Right",  39, 41,  0, Vector(),  true, true,  true, false, false, 3000, 6000, 1000, 1, 5, 20, 20, 150, 30, 2, 10, 0, 0.5, 0.3)

	self:SetDoor(0, Vector(180, -120, 140), Vector( 155, -58, 150), Rotator(0, 0, 15), 75, -150)
	self:SetDoor(1, Vector(180,  120, 140), Vector( 160,  55, 145), Rotator(0, 0,  5), 60,  150)
	self:SetDoor(2, Vector(50,   120, 140), Vector(-125,   0, 140), Rotator(0, 0,  5), 60,  150)

	self:RecreatePhysics()
end

---@class Van : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): Van
NanosWorldVehicles.Van = VehicleWheeled.Inherit("Van", {
	name = "Van",
	image = "assets://nanos-world/Thumbnails/SK_Van.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.Van:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Van", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_08")

	self:SetEngineSetup(540, 4400)
	self:SetAerodynamicsSetup(3200, 0.6, 550, 230, 0.3, Vector(0, 0, 44))
	self:SetSteeringWheelSetup(Vector(134, -73, 176), 28, Rotator(-45, 0, 0))
	self:SetHeadlightsSetup(Vector(270, 0, 106))
	self:SetTaillightsSetup(Vector(-273, 0, 63))
	self:SetExplosionSettings(Vector(), {}, { 4 })

	self:SetWheel(0, "Wheel_Front_Left",  44, 24, 45, Vector(), false, true, false, false, false, 3000, 6000, 1200, 1, 4, 20, 20, 250, 50, 2, 10, 0, 0.5, 0.2)
	self:SetWheel(1, "Wheel_Front_Right", 44, 24, 45, Vector(), false, true, false, false, false, 3000, 6000, 1200, 1, 4, 20, 20, 250, 50, 2, 10, 0, 0.5, 0.2)
	self:SetWheel(2, "Wheel_Rear_Left",   44, 41,  0, Vector(), true,  true, true,  false, false, 3000, 6000, 1200, 1, 4, 20, 20, 250, 50, 2, 10, 0, 0.5, 0.2)
	self:SetWheel(3, "Wheel_Rear_Right",  44, 41,  0, Vector(), true,  true, true,  false, false, 3000, 6000, 1200, 1, 4, 20, 20, 250, 50, 2, 10, 0, 0.5, 0.2)

	self:SetDoor(0, Vector(70, -120, 140), Vector( 70, -73, 162), Rotator(0, 0, 15), 75, -150)

	self:RecreatePhysics()
end

---@class Wagon : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): Wagon
NanosWorldVehicles.Wagon = VehicleWheeled.Inherit("Wagon", {
	name = "Wagon",
	image = "assets://nanos-world/Thumbnails/SK_Wagon.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.Wagon:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Wagon", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_14")

	self:SetEngineSetup(650, 4600)
	self:SetAerodynamicsSetup(1900, 0.3, 505, 190, 0.3, Vector(10, 0, 36))
	self:SetSteeringWheelSetup(Vector(32, -37, 107), 23, Rotator(-20, 0, 0))
	self:SetHeadlightsSetup(Vector(250, 0, 75))
	self:SetTaillightsSetup(Vector(-250, 0, 95))
	self:SetExplosionSettings(Vector(), {}, { 2 })

	self:SetWheel(0, "Wheel_Front_Left",  36, 19, 45, Vector(), false, true, false, false, false, 3000, 6000, 1200, 1, 4, 20, 20, 150, 30, 6, 10, 0, 0.5, 0.2)
	self:SetWheel(1, "Wheel_Front_Right", 36, 19, 45, Vector(), false, true, false, false, false, 3000, 6000, 1200, 1, 4, 20, 20, 150, 30, 6, 10, 0, 0.5, 0.2)
	self:SetWheel(2, "Wheel_Rear_Left",   36, 19, 0,  Vector(), true,  true, true,  false, false, 3000, 6000, 1200, 1, 4, 20, 20, 150, 30, 6, 10, 0, 0.5, 0.2)
	self:SetWheel(3, "Wheel_Rear_Right",  36, 19, 0,  Vector(), true,  true, true,  false, false, 3000, 6000, 1200, 1, 4, 20, 20, 150, 30, 6, 10, 0, 0.5, 0.2)

	self:SetDoor(0, Vector( 22, -80, 100), Vector(-20, -37, 90), Rotator(0, 0, 10), 75, -150)
	self:SetDoor(1, Vector( 22,  80, 100), Vector(-10,  39, 90), Rotator(0, 0,  0), 60,  150)
	self:SetDoor(2, Vector(-80, -80, 100), Vector(-95, -40, 97), Rotator(0, 0,  0), 60, -150)
	self:SetDoor(3, Vector(-80,  80, 100), Vector(-95,  40, 97), Rotator(0, 0,  0), 60,  150)

	self:RecreatePhysics()
end

---@class Sedan : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): Sedan
NanosWorldVehicles.Sedan = VehicleWheeled.Inherit("Sedan", {
	name = "Sedan",
	image = "assets://nanos-world/Thumbnails/SK_Sedan.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.Sedan:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Sedan", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_01")

	self:SetEngineSetup(700, 5700, 1200, 0.05, 3, 600)
	self:SetAerodynamicsSetup(1400, 0.3, 480, 190, 0.4, Vector(10, 0, 30))
	self:SetSteeringWheelSetup(Vector(50, -46, 108), 28, Rotator(-30, 0, 0))
	self:SetHeadlightsSetup(Vector(300, 0, 64))
	self:SetTaillightsSetup(Vector(-300, 0, 80))
	self:SetExplosionSettings(Vector(), {}, { 1 })

	self:SetWheel(0, "Wheel_Front_Left",  30, 20, 45, Vector(), false, true, false, false, false, 1900, 3000, 2000, 1, 5, 20, 20, 150, 30, 7, 7, 0, 0.5, 0.57)
	self:SetWheel(1, "Wheel_Front_Right", 30, 20, 45, Vector(), false, true, false, false, false, 1900, 3000, 2000, 1, 5, 20, 20, 150, 30, 7, 7, 0, 0.5, 0.57)
	self:SetWheel(2, "Wheel_Rear_Left",   30, 20,  0, Vector(), true,  true,  true, false, false, 1900, 3000, 2000, 1, 5, 20, 20, 150, 30, 7, 7, 0, 0.5, 0.57)
	self:SetWheel(3, "Wheel_Rear_Right",  30, 20,  0, Vector(), true,  true,  true, false, false, 1900, 3000, 2000, 1, 5, 20, 20, 150, 30, 7, 7, 0, 0.5, 0.57)

	self:SetDoor(0, Vector(31, -110, 90), Vector(10, -47, 80), Rotator(0, 0, 0), 60, -150)
	self:SetDoor(1, Vector(31,  110, 90), Vector(5, 40, 85), Rotator(0, 0, 0), 60,  150)
	self:SetDoor(2, Vector(-80, -110, 90), Vector(-105, -40, 95), Rotator(0, 0, 0), 60, -150)
	self:SetDoor(3, Vector(-80,  110, 90), Vector(-105,  40, 95), Rotator(0, 0, 0), 60,  150)

	self:RecreatePhysics()
end

---@class SUV : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): SUV
NanosWorldVehicles.SUV = VehicleWheeled.Inherit("SUV", {
	name = "SUV",
	image = "assets://nanos-world/Thumbnails/SK_SUV.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.SUV:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_SUV", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_14")

	self:SetEngineSetup(400, 5000, 1200, 0.1, 6, 800)
	self:SetTransmissionSetup(2.5, 4000)
	self:SetAerodynamicsSetup(1800, 0.4, 200, 190, 3.5, Vector(10, 0, 34))
	self:SetSteeringWheelSetup(Vector(46, -47, 131), 27, Rotator(-20, 0, 0))
	self:SetExplosionSettings(Vector(), {}, { 1 })

	self:SetWheel(0, "Wheel_Front_Left",  34, 20, 38, Vector(), true, true, false, false, true, 4000, 6000, 2500, 1, 4, 20, 12, 200, 60, 10, 10, 0, 0.5, 0.1)
	self:SetWheel(1, "Wheel_Front_Right", 34, 20, 38, Vector(), true, true, false, false, true, 4000, 6000, 2500, 1, 4, 20, 12, 200, 60, 10, 10, 0, 0.5, 0.1)
	self:SetWheel(2, "Wheel_Rear_Left",   34, 20,  0, Vector(), true, true,  true, false, true, 4000, 6000, 2500, 1, 4, 20, 12, 200, 60, 10, 10, 0, 0.5, 0.1)
	self:SetWheel(3, "Wheel_Rear_Right",  34, 20,  0, Vector(), true, true,  true, false, true, 4000, 6000, 2500, 1, 4, 20, 12, 200, 60, 10, 10, 0, 0.5, 0.1)

	self:SetDoor(0, Vector( 22, -80, 120), Vector(-18, -47, 110), Rotator(0, 0, 15), 75, -150)
	self:SetDoor(1, Vector( 22,  80, 120), Vector( 5,   47, 105), Rotator(0, 0,  0), 60,  150)
	self:SetDoor(2, Vector(-80, -80, 120), Vector(-60, -39,  90), Rotator(0, 0,  0), 60, -150)
	self:SetDoor(3, Vector(-80,  80, 120), Vector(-60,  39,  90), Rotator(0, 0,  0), 60,  150)

	self:RecreatePhysics()
end

---@class Hatchback : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): Hatchback
NanosWorldVehicles.Hatchback = VehicleWheeled.Inherit("Hatchback", {
	name = "Hatchback",
	image = "assets://nanos-world/Thumbnails/SK_Hatchback.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.Hatchback:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Hatchback", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_01")

	self:SetEngineSetup(300, 4500, 1200, 0.03, 3, 600)
	self:SetAerodynamicsSetup(1000, 0.3, 500, 200, 0.3, Vector(10, 0, 26))
	self:SetTransmissionSetup(3.08, 4000)
	self:SetSteeringWheelSetup(Vector(58, -47, 105), 25, Rotator(-30, 0, 0))
	self:SetHeadlightsSetup(Vector(270, 0, 70))
	self:SetExplosionSettings(Vector(), {}, { 3 })

	self:SetWheel(0, "Wheel_Front_Left",  26, 17, 42, Vector(), false, true, false, false, false, 3000, 4000, 1000, 1, 4, 20, 20, 100, 25, 4, 4, 0, 0.5, 0.1)
	self:SetWheel(1, "Wheel_Front_Right", 26, 17, 42, Vector(), false, true, false, false, false, 3000, 4000, 1000, 1, 4, 20, 20, 100, 25, 4, 4, 0, 0.5, 0.1)
	self:SetWheel(2, "Wheel_Rear_Left",   26, 17,  0, Vector(), true,  true, true,  false, false, 3000, 4000, 1000, 1, 4, 20, 20, 100, 25, 4, 4, 0, 0.5, 0.1)
	self:SetWheel(3, "Wheel_Rear_Right",  26, 17,  0, Vector(), true,  true, true,  false, false, 3000, 4000, 1000, 1, 4, 20, 20, 100, 25, 4, 4, 0, 0.5, 0.1)

	self:SetDoor(0, Vector(25, -80, 100), Vector( 0, -47, 80), Rotator(0, 0, 10), 60, -150)
	self:SetDoor(1, Vector(25,  80, 100), Vector(12,  47, 80), Rotator(0, 0,  0), 60,  150)

	self:RecreatePhysics()
end

---@class Pickup : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): Pickup
NanosWorldVehicles.Pickup = VehicleWheeled.Inherit("Pickup", {
	name = "Pickup",
	image = "assets://nanos-world/Thumbnails/SK_Pickup.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.Pickup:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Pickup", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_10")

	self:SetEngineSetup(550, 5000)
	self:SetAerodynamicsSetup(2000, 0.4, 500, 200, 0.4, Vector(10, 0, 30))
	self:SetSteeringWheelSetup(Vector(0, 27, 122), 18)
	self:SetHeadlightsSetup(Vector(270, 0, 65))

	self:SetWheel(0, "Wheel_Front_Left",  30, 18, 55, Vector(), true, true, false, false, false, 5000, 3000, 1500, 1, 4, 20, 20, 350, 60, 6, 10, 0, 0.4, 0.1)
	self:SetWheel(1, "Wheel_Front_Right", 30, 18, 55, Vector(), true, true, false, false, false, 5000, 3000, 1500, 1, 4, 20, 20, 350, 60, 6, 10, 0, 0.4, 0.1)
	self:SetWheel(2, "Wheel_Rear_Left",   30, 18,  0, Vector(), true, true,  true, false, false, 5000, 3000, 1500, 1, 3, 20, 20, 350, 60, 6, 10, 0, 0.4, 0.1)
	self:SetWheel(3, "Wheel_Rear_Right",  30, 18,  0, Vector(), true, true,  true, false, false, 5000, 3000, 1500, 1, 3, 20, 20, 350, 60, 6, 10, 0, 0.4, 0.1)

	self:SetDoor(0, Vector(  50, -75, 105), Vector(   8, -32.5,  95), Rotator(0,  0,  10), 70, -150)
	self:SetDoor(1, Vector(  50,  75, 105), Vector(  25,    50,  90), Rotator(0,  0,   0), 70,  150)
	self:SetDoor(2, Vector( -90, -75, 130), Vector( -90,  -115, 155), Rotator(0,  90, 20), 60, -150)
	self:SetDoor(3, Vector( -90,  75, 130), Vector( -90,   115, 155), Rotator(0, -90, 20), 60,  150)
	self:SetDoor(4, Vector(-195, -75, 130), Vector(-195,  -115, 155), Rotator(0,  90, 20), 60, -150)
	self:SetDoor(5, Vector(-195,  75, 130), Vector(-195,   115, 155), Rotator(0, -90, 20), 60,  150)

	self:RecreatePhysics()
end

---@class SportsCar : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): SportsCar
NanosWorldVehicles.SportsCar = VehicleWheeled.Inherit("SportsCar", {
	name = "SportsCar",
	image = "assets://nanos-world/Thumbnails/SK_SportsCar.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.SportsCar:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_SportsCar", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_05")

	self:SetEngineSetup(1000, 8000, 1000, 0.1, 5, 800)
	self:SetAerodynamicsSetup(1600, 0.3, 190, 130, 6, Vector(10, 0, 31))
	self:SetTransmissionSetup(3.8, 7500, 3200, 0.1, 0.95)
	self:SetSteeringWheelSetup(Vector(60, -42, 83), 19, Rotator())
	self:SetExplosionSettings(Vector(), {}, { 1 })

	self:SetWheel(0, "Wheel_Front_Left",  31, 27, 50, Vector(), true, true, false, false, true, 5000,    0, 2000, 1, 5, 20, 20, 200, 60, 10, 10, 0, 0.4, 0)
	self:SetWheel(1, "Wheel_Front_Right", 31, 27, 50, Vector(), true, true, false, false, true, 5000,    0, 2000, 1, 5, 20, 20, 200, 60, 10, 10, 0, 0.4, 0)
	self:SetWheel(2, "Wheel_Rear_Left",   35, 37,  0, Vector(), true, true,  true, false, true, 5000, 6000, 2000, 1, 5, 20, 20, 200, 60, 10, 10, 0, 0.4, 0)
	self:SetWheel(3, "Wheel_Rear_Right",  35, 37,  0, Vector(), true, true,  true, false, true, 5000, 6000, 2000, 1, 5, 20, 20, 200, 60, 10, 10, 0, 0.4, 0)

	self:SetDoor(0, Vector(25, -95, 100), Vector(40, -42, 55), Rotator(0, 0, -10), 75, -150)
	self:SetDoor(1, Vector(25,  95, 100), Vector(35,  42, 60), Rotator(0, 0, -15), 75,  150)

	self:RecreatePhysics()
end

---@class TruckBox : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): TruckBox
NanosWorldVehicles.TruckBox = VehicleWheeled.Inherit("TruckBox", {
	name = "Truck Box",
	image = "assets://nanos-world/Thumbnails/SK_Truck_Box.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.TruckBox:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Truck_Box", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_08")

	self:SetEngineSetup(1000, 4800, 1000, 0.12, 10, 650)
	self:SetAerodynamicsSetup(5000, 0.6, 250, 350, 4.0, Vector(0, 0, 43))
	self:SetSteeringWheelSetup(Vector(304, -56, 157), 27, Rotator(-60, 0, 0))
	self:SetHeadlightsSetup(Vector(360, 0, 100))
	self:SetExplosionSettings(Vector(), {}, { 2 })

	self:SetWheel(0, "Wheel_Front_Left",  43, 20, 35, Vector(), true, true, false, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)
	self:SetWheel(1, "Wheel_Front_Right", 43, 20, 35, Vector(), true, true, false, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)
	self:SetWheel(2, "Wheel_Rear_Left",   43, 40,  0, Vector(), true, true,  true, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)
	self:SetWheel(3, "Wheel_Rear_Right",  43, 40,  0, Vector(), true, true,  true, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)

	self:SetDoor(0, Vector(235, -100, 132), Vector(225, -56, 145), Rotator(0, 0, 20), 100, -150)
	self:SetDoor(1, Vector(235,  100, 132), Vector(225,  60, 147), Rotator(0, 0, 10), 100,  150)

	self:RecreatePhysics()
end

---@class TruckChassis : VehicleWheeled
---@overload fun(location: Vector, rotation: Rotator): TruckChassis
NanosWorldVehicles.TruckChassis = VehicleWheeled.Inherit("TruckChassis", {
	name = "Truck Chassis",
	image = "assets://nanos-world/Thumbnails/SK_Truck_Chassis.jpg",
	category = "wheeled",
})

function NanosWorldVehicles.TruckChassis:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Truck_Chassis", CollisionType.Normal, true, false, true, "nanos-world::A_Vehicle_Engine_08")

	self:SetEngineSetup(1000, 4800, 1000, 0.12, 10, 650)
	self:SetAerodynamicsSetup(3000, 0.6, 250, 350, 4.0, Vector(100, 0, 43))
	self:SetSteeringWheelSetup(Vector(304, -56, 157), 27, Rotator(-60, 0, 0))
	self:SetHeadlightsSetup(Vector(360, 0, 100))
	self:SetExplosionSettings(Vector(), {}, { 2 })

	self:SetWheel(0, "Wheel_Front_Left",  43, 20, 35, Vector(), true, true, false, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)
	self:SetWheel(1, "Wheel_Front_Right", 43, 20, 35, Vector(), true, true, false, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)
	self:SetWheel(2, "Wheel_Rear_Left",   43, 40,  0, Vector(), true, true,  true, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)
	self:SetWheel(3, "Wheel_Rear_Right",  43, 40,  0, Vector(), true, true,  true, true, true, 7000, 10000, 1000, 1, 4, 20, 15, 600, 150, 20, 20, 0, 0.8, 0.5)

	self:SetDoor(0, Vector(235, -100, 132), Vector(225, -56, 145), Rotator(0, 0, 20), 100, -150)
	self:SetDoor(1, Vector(235,  100, 132), Vector(225,  60, 147), Rotator(0, 0, 10), 100,  150)

	self:RecreatePhysics()
end

---@class Boat : VehicleWater
---@overload fun(location: Vector, rotation: Rotator): Boat
NanosWorldVehicles.Boat = VehicleWater.Inherit("Boat", {
	name = "Boat",
	image = "assets://nanos-world/Thumbnails/SK_Motorboat.jpg",
	category = "water",
})

function NanosWorldVehicles.Boat:Constructor(location, rotation)
	self.Super:Constructor(location or Vector(), rotation or Rotator(), "nanos-world::SK_Motorboat")

	self:SetDoor(0, Vector(0, 0, 0), Vector(-120, 0, 55), Rotator(-10, 0, 0), 200, -100)
end