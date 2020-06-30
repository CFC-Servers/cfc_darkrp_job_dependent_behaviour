function JDB.AllPlayerJobLimit( jobName, multiplier )
    JDB.RelationJobLimit( jobName, "ALL", multiplier )
end

function JDB.RelationJobLimit( jobName, fromJob, multiplier )
    local limiter = JDB.new()
    limiter:DependsOn( fromJob )
    limiter:Via( function( plyCount )
        return math.ceil( plyCount * multiplier )
    end )
    limiter:LimitsJob( jobName )
end
