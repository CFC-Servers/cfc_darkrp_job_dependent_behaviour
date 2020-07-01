local config = {}
JDB.config = config

-- Limit job counts by a percent of the total player count on the server
config.playerCountLimits = {
--    { job = "mercenary", percentOfPlayers = 25 }
}

-- Limits job counts by a percent of another job's total
config.relationalLimits = {
--    { job = "mercenary", percentOfOtherJob = 50, otherJob = "CP" }
}

-- Triggered when a job count goes above/below a constant threshold, calls action with true when at/above threshold, and false when below
config.constantThresholds = {
--    { job = "cook", threshold = 1, action = function( crossed ) vendingMachineAddon:SetEnabled( crossed ) end }
}

-- Triggered when a job count goes above/below a percent threshold of the jobs maximum
-- calls action with true when at/above threshold, and false when below
config.percentThresholds = {
--    { job = "cook", percentThreshold = 50, action = function( crossed ) vendingMachineAddon:SetIsExpensive( crossed ) end }
}

-- Put any object-based limits here
-- This include any behaviours that are too complex to be defined in tables
hook.Add( "cfc_jdb_init", "cfc_jdb_complexLimits", function()
    --[[

    local behaviour = JDB.new()
    behaviour:DependsOn( "CP", "Mayor" )
    behaviour:Via( function( cpCount, mayorCount )
        return cpCount >= 2 and mayorCount >= 1
    end )
    behaviour:SetName( "MayorSafeLockpick" )

    -- Then use this to get the value when needed
    local canLockPick = JDB.GetByName( "MayorSafeLockpick" ):GetValue()

    ]]
end )
