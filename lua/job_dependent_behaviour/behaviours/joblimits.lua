hook.Add( "cfc_jbd_init", "cfc_jbd_jobLimits", function()
    --do return end

    -- Example
    -- Add job limits behaviour
    local hitmanLimiter = JDB.new()
    hitmanLimiter:DependsOn( "CP" )
    hitmanLimiter:Via( function( cpCount )
        return cpCount + 1
    end )
    hitmanLimiter:LimitsJob( "mercenary" )
end )
