JDB = JDB or {}
JDB.behaviours = JDB.behaviours or {}

include( "context.lua" )
include( "jobgroups.lua" )

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

hook.Add( "DarkRPVarChanged", "cfc_job_dependent_behaviour", function( ply, varName, prev, new )
    if varName ~= "job" then return end

    -- This function is called before the job is actually set
    timer.Simple( 0, JDB.UpdateBehaviours )
end )

hook.Add( "PlayerDisconnected", "cfc_job_dependent_behaviour", JDB.UpdateBehaviours )

-- Include inbuilt behaviours
local _, files = file.Find( "job_dependent_behaviour/behaviours/*", "LUA" )

for _, fileName in pairs( files ) do
    include( "job_dependent_behaviour/behaviours/" .. fileName )
end

hook.Run( "cfc_JDB_init" )
