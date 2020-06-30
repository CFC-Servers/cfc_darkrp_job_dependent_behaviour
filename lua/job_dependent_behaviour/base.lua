JBD = JBD or {}
JBD.behaviours = JBD.behaviours or {}

include( "context.lua" )
include( "jobgroups.lua" )

function JBD.new()
    local behaviour = {}

    local mt = {
        __index = JBD.CONTEXT,
    }

    setmetatable( behaviour, mt )

    table.insert( JBD.behaviours, behaviour )

    return behaviour
end

function JBD.UpdateBehaviours()
    for _, behaviour in pairs( JBD.behaviours ) do
        behaviour:UpdateValue()
    end
end

hook.Add( "DarkRPVarChanged", "cfc_job_dependent_behaviour", function( ply, varName, prev, new )
    if varName ~= "job" then return end

    -- This function is called before the job is actually set
    timer.Simple( 0, JBD.UpdateBehaviours )
end )

hook.Add( "PlayerDisconnected", "cfc_job_dependent_behaviour", JBD.UpdateBehaviours )

-- Include inbuilt behaviours
local _, files = file.Find( "job_dependent_behaviour/behaviours/*", "LUA" )

for _, fileName in pairs( files ) do
    include( "job_dependent_behaviour/behaviours/" .. fileName )
end
