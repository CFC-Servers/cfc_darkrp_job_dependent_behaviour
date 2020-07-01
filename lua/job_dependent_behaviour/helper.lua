function JDB.AllPlayerJobLimit( jobName, multiplier )
    JDB.RelationJobLimit( jobName, "ALL", multiplier )
end

function JDB.RelationJobLimit( jobName, fromJob, multiplier )
    local limiter = JDB.new()
    if type( fromJob ) == "table" then
        limiter:DependsOn( unpack( fromJob ) )
    else
        limiter:DependsOn( fromJob )
    end

    limiter:Via( function( plyCount )
        return math.ceil( plyCount * multiplier )
    end )
    limiter:LimitsJob( jobName )
end

function JDB.Threshold( jobName, threshold, action, isPercent )
    local behaviour = JDB.new()
    if type( jobName ) == "table" then
        behaviour:DependsOn( unpack( jobName ) )
    else
        behaviour:DependsOn( jobName )
    end

    behaviour:Threshold( threshold, JDB.GREATER_OR_EQUAL, isPercent )
    behaviour:Do( action )
end

function JDB.ThresholdPercent( jobName, threshold, action )
    JDB.Threshold( jobName, threshold, action, true )
end
