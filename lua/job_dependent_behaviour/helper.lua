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

function JDB.Threshold( jobName, threshold, action, isPercent )
    local behaviour = JDB.new()

    behaviour:DependsOn( jobName )
    behaviour:Threshold( threshold, JDB.GREATER_OR_EQUAL, isPercent )
    behaviour:Do( action )
end

function JDB.ThresholdPercent( jobName, threshold, action )
    JDB.Threshold( jobName, threshold, action, true )
end
