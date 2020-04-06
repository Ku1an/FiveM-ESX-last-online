RegisterNetEvent('esx:playerJoined')
AddEventHandler('esx:playerJoined', function()
    local playerid = source
    local identifier = GetPlayerIdentifiers(playerid)[2]
    local date = os.date('%Y') .. '-' .. os.date('%m') .. '-' .. os.date('%d')
    local lastonline = MySQL.Sync.execute("UPDATE lastonline SET time=@time WHERE license=@license", {['@license'] = identifier, ['@time'] =  os.date('%X')})
    local lasttime = MySQL.Sync.execute("UPDATE lastonline SET date=@date WHERE license=@license", {['@license'] = identifier, ['@date'] =  date})

    if lastonline == 0 then
        MySQL.Async.fetchAll("INSERT INTO lastonline (license, date, time,ip) VALUES(@license, @date, @time, @ip)",     
        {["@license"] = identifier, ["@date"] = date, ["@time"] = os.date('%X'), ['@ip'] = GetPlayerEndpoint(playerid)})
    end
    print(identifier ..' = ' .. date)
end)

