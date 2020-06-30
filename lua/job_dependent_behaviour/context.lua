local CONTEXT = {}

JBD.CONTEXT = CONTEXT
JBD.GREATER = 0
JBD.GREATER_OR_EQUAL = 1
JBD.LESS = 2
JBD.LESS_OR_EQUAL = 3

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
end

function CONTEXT:SetEquation( f )

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
    self.inputs = { i }
end

function CONTEXT:SetInputs( ... )
    self.inputs = { ... }
end

function CONTEXT:GetValue()

end

function CONTEXT:UpdateValue()

end
