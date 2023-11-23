RegisterCommand(Config.Command, function(source)
    local _source = source
    TriggerClientEvent("BGS_PvP:TogglePvP", _source)
end, false)