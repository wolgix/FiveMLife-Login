startMoney = 10000

RegisterNetEvent("life:checkPlayerData")
AddEventHandler("life:checkPlayerData", function()
    local src = source
    local ident = PlayerIdentifier("license", src)
    local name = GetPlayerName(src)

    MySQL.Async.fetchAll("SELECT * FROM `players` WHERE `id` = @identifier", {
        identifier = ident
    }, function(results)
        if #results == 0 then
            CreatePlayerData(src, function()
                TriggerClientEvent("life:openUI", src)
                checkPlayerUID()
            end)
        else
            local foundUser = results[1]
            GetPlayerData(src, foundUser, function()
            end)
        end
    end)
end)

function CreatePlayerData(source, callback)
    MySQL.Async.execute("INSERT INTO `players` (`id`, `name`) VALUES (@id, @name)", {
        ["@id"] = PlayerIdentifier("license", source),
        ["@name"] = GetPlayerName(source)
    }, function(results)
        callback()
    end)
end

function GetPlayerData(source, data)
    TriggerClientEvent("life:Spawn", source)
end

function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
    end

    function checkPlayerUID()
        rando = math.random (100000000, 999999999)
        MySQL.Async.fetchAll("SELECT * FROM `height` WHERE `UID` = @UID", {
            UID = rando
        }, function(results)
            if #results == 0 then
            else
                rando = math.random (100000000, 999999999)
            end
        end)
    end

RegisterServerEvent("life:CreateCharacter")
AddEventHandler("life:CreateCharacter",function(data, id)
    playerId = PlayerIdentifier("license", source)
    MySQL.Async.execute('INSERT INTO playername (id, firstName, lastName) VALUES (@identifier, @firstname, @lastname)',
    {
      ['@identifier']   = playerId,
      ['@firstname']    = data.firstname,
      ['@lastname']     = data.lastname
    },
    function( result )
    end)
    MySQL.Async.execute('INSERT INTO playersexndob (id, sex, dob) VALUES (@identifier, @sex, @dateofbirth)',
    {
      ['@identifier']   = playerId,
      ['@sex']    = data.sex,
      ['@dateofbirth']     = data.dateofbirth
    },
    function( result )
    end)
    GetPlayerData(source)
end)

RegisterServerEvent("life:CreateCharacterUID")
AddEventHandler("life:CreateCharacterUID",function(data, id)
playerId = PlayerIdentifier("license", source)
MySQL.Async.execute('INSERT INTO height (id, height, UID) VALUES (@identifier, @height, @UID)',
{
  ['@identifier']   = playerId,
  ['@height']    = data.height,
  ['@UID']    = rando
},
function( result )
end)
MySQL.Async.execute('INSERT INTO playerbank (id, balance, accountNumber) VALUES (@identifier, @balance, @accountNumber)',
{
  ['@identifier']   = playerId,
  ['@balance']    = startMoney,
  ['@accountNumber']    = rando
},
function( result )
end)
end)