hook.Add( "cfc_jdb_init", "cfc_jdb_configParser", function()
    if JDB.config.playerCountLimits then
        for k, limit in pairs( JDB.config.playerCountLimits ) do
            JDB.AllPlayerJobLimit( limit.job, limit.percentOfPlayers / 100 )
        end
    end

    if JDB.config.relationalLimits then
        for k, limit in pairs( JDB.config.relationalLimits ) do
            JDB.RelationJobLimit( limit.job, limit.percentOfOtherJob / 100, limit.otherJob )
        end
    end

    if JDB.config.constantThresholds then
        for k, limit in pairs( JDB.config.constantThresholds ) do
            JDB.Threshold( limit.job, limit.threshold, limit.action )
        end
    end

    if JDB.config.percentThresholds then
        for k, limit in pairs( JDB.config.percentThresholds ) do
            JDB.Threshold( limit.job, limit.percentThreshold / 100, limit.action )
        end
    end
end )