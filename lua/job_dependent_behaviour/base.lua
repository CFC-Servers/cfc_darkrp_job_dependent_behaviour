JDB = JDB or {}
JDB.behaviours = JDB.behaviours or {}

include( "context.lua" )
include( "jobgroups.lua" )
include( "helper.lua" )
include( "configparser.lua" )
include( "config.lua" )

function JDB.new()
    local behaviour = {}

    local mt = {
        __index = JDB.CONTEXT,
    }

    setmetatable( behaviour, mt )

    table.insert( JDB.behaviours, behaviour )

    return behaviour
end

function JDB.UpdateBehaviours()
    for _, behaviour in pairs( JDB.behaviours ) do
        behaviour:UpdateValue()
    end
end

function JDB.GetByName( name )
    for k, behaviour in pairs( self.behaviours ) do
        if behaviour.name == name then return behaviour end
    end
end

hook.Add( "DarkRPVarChanged", "cfc_job_dependent_behaviour", function( ply, varName, prev, new )
    if varName ~= "job" then return end

    -- This function is called before the job is actually set
    timer.Simple( 0, JDB.UpdateBehaviours )
end )

hook.Add( "PlayerDisconnected", "cfc_job_dependent_behaviour", function()
    -- Give time for player.GetAll() to update
    timer.Simple( 0, JDB.UpdateBehaviours )
end )

hook.Run( "cfc_jdb_init" )
