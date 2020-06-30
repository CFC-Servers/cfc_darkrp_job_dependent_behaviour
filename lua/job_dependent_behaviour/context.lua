local CONTEXT = {}

JBD.CONTEXT = CONTEXT
JBD.GREATER = 0
JBD.GREATER_OR_EQUAL = 1
JBD.LESS = 2
JBD.LESS_OR_EQUAL = 3

CONTEXT.equation = function( x ) return x end
CONTEXT.action = function() end

local compFuncs = {
    [JBD.GREATER] = function( a, b )
        return a > b
    end,
    [JBD.GREATER_OR_EQUAL] = function( a, b )
        return a >= b
    end,
    [JBD.LESS] = function( a, b )
        return a < b
    end,
    [JBD.LESS_OR_EQUAL] = function( a, b )
        return a <= b
    end,
}

function CONTEXT:SetAction( f )
    self.action = f

    local this = self
    timer.Simple( 0, function()
        this:UpdateValue()
    end )
end

function CONTEXT:SetEquation( f )
    self.equation = f
end

function CONTEXT:SetThreshhold( threshold, thresholdType )
    local compFunc = compFuncs[thresholdType]
    if not compFunc then
        error( "Invalid comparison type" )
    end

    self:SetEquation( function( val )
        return compFunc( val, threshold )
    end )
end

function CONTEXT:SetInput( i )
    self:SetInputs( i )
end

function CONTEXT:SetInputs( ... )
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
        inputValues[k] = JBD.groups.getPlayerCount( v )
    end

    local value = self.equation( unpack( inputValues ) )

    if value ~= self.prevValue then
        self.value = value
        self.prevValue = value

        self.action( self.value )
    end
end
