local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local isPvPEnabled = true

function DisablePvPControls()
    VORPcore.NotifyBottomRight(Config.notificationText.disabled, 4000)
end

function EnablePvPControls()
    local message = Config.notificationText.enabled
    VORPcore.NotifyBottomRight(message, 4000)
    EnableControlAction(0, GetHashKey('INPUT_MELEE_ATTACK'), true)
    EnableControlAction(0, GetHashKey('INPUT_MELEE_GRAPPLE_ATTACK'), true)
    EnableControlAction(0, GetHashKey('INPUT_MELEE_GRAPPLE'), true)
    EnableControlAction(0, GetHashKey('INPUT_MELEE_GRAPPLE_CHOKE'), true)
end

RegisterNetEvent("BGS_PvP:TogglePvP", function()
    SetResourceKvp(PlayerPedId(), "pvpEnabled")
    isPvPEnabled = not isPvPEnabled
    TriggerEvent("vorp:setPVPUi", isPvPEnabled)
    if not isPvPEnabled then
        DisablePvPControls()
    else
        EnablePvPControls()
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if not isPvPEnabled then
            DisableControlAction(0, GetHashKey('INPUT_MELEE_ATTACK'), true)
            DisableControlAction(0, GetHashKey('INPUT_MELEE_GRAPPLE_ATTACK'), true)
            DisableControlAction(0, GetHashKey('INPUT_MELEE_GRAPPLE'), true)
            DisableControlAction(0, GetHashKey('INPUT_MELEE_GRAPPLE_CHOKE'), true)
        end
    end
end)