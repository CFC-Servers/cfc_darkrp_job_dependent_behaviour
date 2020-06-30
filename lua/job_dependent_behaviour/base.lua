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

-- Include inbuilt behaviours
local _, files = file.Find( "job_dependent_behaviour/behaviours/*", "LUA" )

for _, fileName in pairs( files ) do
    include( "job_dependent_behaviour/behaviours/" .. fileName )
end
