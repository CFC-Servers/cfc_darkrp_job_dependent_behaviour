JDB.groups = JDB.groups or {}

-- Jobs can be a list of jobs, or a function getter
function JDB.groups.add( name, jobs )
    name = string.lower( name )

    if JDB.groups[name] then
        error( "Group with name " .. name .. " already exists" )
    end

    if type( jobs ) == "table" then
        for k, v in pairs( jobs ) do
            jobs[k] = string.lower( v )
        end
    end

    JDB.groups[name] = jobs
end

function JDB.groups.exists( name )
    name = string.lower( name )

    return tobool( JDB.groups[name] )
end

function JDB.groups.addIfNotExists( name, jobs )
    name = string.lower( name )

    if not JDB.groups.exists( name ) then
        JDB.groups.add( name, jobs )
    end
end

function JDB.groups.getPlayers( name )
    name = string.lower( name )

    if name == "all" then return player.GetAll() end

    local getter = JDB.groups[name]
    if not getter then
        getter = function( ply )
            return string.lower( ply:getDarkRPVar( "job" ) ) == string.lower( name )
        end
    end

    if type( getter ) == "table" then
        local groupList = getter
        getter = function( ply )
            return table.HasValue( groupList, string.lower( ply:getDarkRPVar( "job" ) ) )
        end
    end

    local plys = {}
    for _, ply in pairs( player.GetAll() ) do
        if getter( ply ) then
            table.insert( plys, ply )
        end
    end

    return plys
end

function JDB.groups.getPlayerCount( name )
    return #JDB.groups.getPlayers( name )
end

JDB.groups.addIfNotExists( "CP", function( ply )
    return ply:isCP()
end )
