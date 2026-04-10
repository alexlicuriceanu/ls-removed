-- function that calls RemoveIpl for each ipl in a list
-- @param ipls list of ipl names to remove
-- @return none
local function RemoveIpls(ipls) 
    for _, ipl in ipairs(ipls) do
        RemoveIpl(ipl)
    end
end

local function DisableBasegameScenarios()
    local scenarios = {
        'WORLD_VEHICLE_ATTRACTOR',
        'WORLD_VEHICLE_AMBULANCE',
        'WORLD_VEHICLE_BICYCLE_BMX',
        'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
        'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
        'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
        'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
        'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
        'WORLD_VEHICLE_BICYCLE_ROAD',
        'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
        'WORLD_VEHICLE_BIKER',
        'WORLD_VEHICLE_BOAT_IDLE',
        'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
        'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
        'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
        'WORLD_VEHICLE_BROKEN_DOWN',
        'WORLD_VEHICLE_BUSINESSMEN',
        'WORLD_VEHICLE_HELI_LIFEGUARD',
        'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
        'WORLD_VEHICLE_CONSTRUCTION_SOLO',
        'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
        'WORLD_VEHICLE_DRIVE_SOLO',
        'WORLD_VEHICLE_FARM_WORKER',
        'WORLD_VEHICLE_FIRE_TRUCK',
        'WORLD_VEHICLE_EMPTY',
        'WORLD_VEHICLE_MARIACHI',
        'WORLD_VEHICLE_MECHANIC',
        'WORLD_VEHICLE_MILITARY_PLANES_BIG',
        'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
        'WORLD_VEHICLE_PARK_PARALLEL',
        'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
        'WORLD_VEHICLE_PASSENGER_EXIT',
        'WORLD_VEHICLE_POLICE_BIKE',
        'WORLD_VEHICLE_POLICE_CAR',
        'WORLD_VEHICLE_POLICE',
        'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
        'WORLD_VEHICLE_QUARRY',
        'WORLD_VEHICLE_SALTON',
        'WORLD_VEHICLE_SALTON_DIRT_BIKE',
        'WORLD_VEHICLE_SECURITY_CAR',
        'WORLD_VEHICLE_STREETRACE',
        'WORLD_VEHICLE_TOURBUS',
        'WORLD_VEHICLE_TOURIST',
        'WORLD_VEHICLE_TANDL',
        'WORLD_VEHICLE_TRACTOR',
        'WORLD_VEHICLE_TRACTOR_BEACH',
        'WORLD_VEHICLE_TRUCK_LOGS',
        'WORLD_VEHICLE_TRUCKS_TRAILERS',
        'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
    }

    for i, v in ipairs(scenarios) do
        SetScenarioTypeEnabled(v, false)
    end
end


Citizen.CreateThread(function()
    SetFogVolumeRenderDisabled(true)    -- remove light pollution effects
    DisableVehicleDistantlights(true)   -- remove vehicle lod lights
    DisableWorldhorizonRendering(true)   -- disable farlods rendering
    
    -- ### Audio ###
    if config.disable_ambient_sounds then
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
    end

    -- ### Scenarios ###
    DisableBasegameScenarios()

    -- ### WATER ###
    if config.custom_water_name and config.custom_water then
        local custom_water_name = config.custom_water_name
        local custom_water = config.custom_water[custom_water_name]
        
        LoadWaterFromPath(custom_water.resource_name, custom_water.path)

        if custom_water.global_water_type then
            LoadGlobalWaterType(custom_water.global_water_type)
        end
        if custom_water.deep_ocean_scaler then
            SetDeepOceanScaler(custom_water.deep_ocean_scaler * 1.0)
        end
    end

    -- wait until player is active before removing ipls
    local id = PlayerId()

    while not NetworkIsPlayerActive(id) do
        Citizen.Wait(100)
    end

    -- ### MAIN MAP REMOVAL ###
    for i = 1, config.passes do        
        RemoveIpls(_ipls)
        Citizen.Wait(config.pass_delay)
    end
end)


-- handle water fog textures
Citizen.CreateThread(function()
    local id = PlayerId()

    while not NetworkIsPlayerActive(id) do
        Citizen.Wait(0)
    end

    RequestStreamedTextureDict("waterfog-0")
    while not HasStreamedTextureDictLoaded("waterfog-0") do
        Citizen.Wait(0)
    end

    AddReplaceTexture("platform:/textures/graphics", "waterfog", "waterfog-0", "waterfog-0")
    SetStreamedTextureDictAsNoLongerNeeded("waterfog-0")
end)
