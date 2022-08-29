Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(Config.NPCTraffic)
	    SetPedDensityMultiplierThisFrame(Config.NPCCitizens)
	    SetRandomVehicleDensityMultiplierThisFrame(Config.NPCTraffic)
	    SetParkedVehicleDensityMultiplierThisFrame(Config.ParkedCars)
	    SetScenarioPedDensityMultiplierThisFrame(Config.NPCTraffic, Config.NPCTraffic)
	end
end)

-- disable Cops from spawning
Citizen.CreateThread(function()
	if Config.disableCops == true then 
		SetCreateRandomCops(false) -- disable Cops from spawning
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios()
	end
end)

-- Prevent Driving NPC Vehicle Theft
Citizen.CreateThread(function()
	if Config.StealDrivingVehicle == false then
	while true do
		Citizen.Wait(800)
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsTryingToEnter(playerPed)


			if vehicle and DoesEntityExist(vehicle) then
				
			local driverPed = GetPedInVehicleSeat(vehicle, -1)

			if GetVehicleDoorLockStatus(vehicle) == 7 then 
				SetVehicleDoorsLocked(vehicle, 2)
			end

			if driverPed and DoesEntityExist(driverPed) then 
			SetPedCanBeDraggedOut(driverPed, false)
			end
		end
		end
	end
end)

-- deactivate Medics
Citizen.CreateThread(function()
	if Config.DispatchService == false then
    for dispatchService=1, 15 do
        EnableDispatchService(dispatchService, false)
        Citizen.Wait(1)
		end
    end
end)

-- Makes so that npc gangs wont attack you. Especally useful for making the bike gang & purple gang not constantly angry
local relationshipTypes = {GetHashKey('PLAYER'), GetHashKey('CIVMALE'), GetHashKey('CIVFEMALE'), GetHashKey('GANG_1'), GetHashKey('GANG_2'), GetHashKey('GANG_9'), GetHashKey('GANG_10'), GetHashKey('AMBIENT_GANG_LOST'), GetHashKey('AMBIENT_GANG_MEXICAN'), GetHashKey('AMBIENT_GANG_FAMILY'), GetHashKey('AMBIENT_GANG_BALLAS'), GetHashKey('AMBIENT_GANG_MARABUNTE'), GetHashKey('AMBIENT_GANG_CULT'), GetHashKey('AMBIENT_GANG_SALVA'), GetHashKey('AMBIENT_GANG_WEICHENG'), GetHashKey('AMBIENT_GANG_HILLBILLY'), GetHashKey('DEALER'), GetHashKey('COP'), GetHashKey('PRIVATE_SECURITY'), GetHashKey('SECURITY_GUARD'), GetHashKey('ARMY'), GetHashKey('MEDIC'), GetHashKey('FIREMAN'), GetHashKey('HATES_PLAYER'), GetHashKey('NO_RELATIONSHIP'), GetHashKey('SPECIAL'), GetHashKey('MISSION2'), GetHashKey('MISSION3'), GetHashKey('MISSION4'), GetHashKey('MISSION5'), GetHashKey('MISSION6'), GetHashKey('MISSION7'), GetHashKey('MISSION8')}

Citizen.CreateThread(function()
	if Config.NPCGangsAttack == true then
        local playerHash = GetHashKey('PLAYER')

        for k,groupHash in ipairs(relationshipTypes) do
            SetRelationshipBetweenGroups(1, playerHash, groupHash)
            SetRelationshipBetweenGroups(1, groupHash, playerHash)
	end
    end
end)

-- Get Free weapons when entering vehicle
Citizen.CreateThread(function()
	if Config.GetFreeWeaponsWhenEnteringVehicle == false then
    while true do
        Citizen.Wait(10)
        DisablePlayerVehicleRewards(PlayerId())
   		end
	end
end)

-- AntiNPCDrop
Citizen.CreateThread(function()
	if Config.NPCDrop == false then 
    while true do
      Citizen.Wait(1)
      RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
      RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
      RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
		end
      end
  end)
