local CONTEXT = {}

JDB.CONTEXT = CONTEXT
JDB.GREATER = 0
JDB.GREATER_OR_EQUAL = 1
JDB.LESS = 2
JDB.LESS_OR_EQUAL = 3

JDB.INF_JOBS = -1001

CONTEXT.equation = function( x ) return x end
CONTEXT.action = function() end

local compFuncs = {
    [JDB.GREATER] = function( a, b )
        return a > b
    end,
    [JDB.GREATER_OR_EQUAL] = function( a, b )
        return a >= b
    end,
    [JDB.LESS] = function( a, b )
        return a < b
    end,
    [JDB.LESS_OR_EQUAL] = function( a, b )
        return a <= b
    end,
}

function CONTEXT:Do( f )
    self.action = f

    local this = self
    timer.Simple( 0, function()
        this:UpdateValue()
    end )
end

function CONTEXT:LimitsJob( jobName )
    self:Do( function( value )
        if type( value ) ~= "number" then
            error( "Job limiter returned non-numeric value" )
        end

        value = math.floor( value )

        local jobTable = DarkRP.getJobByCommand( jobName )

        if not jobTable then
            error( "Attempt to limit job " .. jobName .. ", which does not exist" )
        end

        -- A max of 0 in DarkRP means infinite, likely not what you want with a job limiter
        if value == 0 then value = -1 end

        if value == JDB.INF_JOBS then value = 0 end

        if value < -1 then value = -1 end

        jobTable.max = value

        BroadcastLua( "( DarkRP.getJobByCommand( \"" .. jobName .. "\" ) or {} ).max = " .. value )
    end )
end

function CONTEXT:Via( f )
    self.equation = f
end

function CONTEXT:Threshhold( threshold, thresholdType, isPercent )
    local compFunc = compFuncs[thresholdType]
    if not compFunc then
        error( "Invalid comparison type" )
    end

    local this = self
    self:Via( function( val )
        local other = threshold
        if isPercent then
            other = other * JDB.groups.getMax( this.inputs[1] )
        end
        return compFunc( val, other )
    end )
end

function CONTEXT:DependsOn( ... )
    self.inputs = { ... }
end

function CONTEXT:GetValue()
    self:UpdateValue()
    return self.value
end

function CONTEXT:UpdateValue()
    if not self.inputs then return end

    local inputValues = {}
    for k, v in ipairs( self.inputs ) do
        inputValues[k] = JDB.groups.getPlayerCount( v )
    end

    local value = self.equation( unpack( inputValues ) )

    if value ~= self.prevValue then
        self.value = value
        self.prevValue = value

        self.action( self.value )
    end
end

function CONTEXT:SetName( name )
    self.name = name
end
