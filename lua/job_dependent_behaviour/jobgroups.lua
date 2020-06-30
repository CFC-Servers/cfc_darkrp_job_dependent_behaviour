JBD.groups = JBD.groups or {}

-- Jobs can be a list of jobs, or a function getter
function JBD.groups.add( name, jobs )
    if JBD.groups[name] then
        error( "Group with name " .. name .. " already exists" )
    end
    JBD.groups[name] = jobs
end

function JBD.groups.exists( name )
    return tobool( JBD.groups[name] )
end

function JBD.groups.addIfNotExists( name, jobs )
    if not JBD.groups.exists( name ) then
        JBD.groups.add( name, jobs )
    end
end

function JBD.groups.getPlayers( name )
    local getter = JBD.groups[name]
    if not getter then
        getter = function( ply )
            return ply:getDarkRPVar( "job" ) == name
        end
    end

    if type( getter ) == "table" then
        local groupList = getter
        getter = function( ply )
            return table.HasValue( groupList, ply:getDarkRPVar( "job" ) )
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

function JBD.groups.getPlayerCount( name )
    return #JBD.groups.getPlayers( name )
end

JBD.groups.addIfNotExists( "CP", function( ply )
    return ply:isCP()
end )
