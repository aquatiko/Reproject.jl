const UNDEFINED    = 987654321.0e99        # from WCS.jl

"""
    wcs_to_celestial_frame(wcs::WCSTransform)

Returns the reference frame of a WCSTransform.
The reference frame supported in Julia are FK5, ICRS and Galactic.
"""
function wcs_to_celestial_frame(wcs::WCSTransform)
    radesys = wcs.radesys
    
    if wcs.equinox != UNDEFINED
        equinox = wcs.equinox
    else
        equinox = nothing
    end
    
    xcoord = wcs.ctype[1][1:4]
    ycoord = wcs.ctype[2][1:4]
    
    if radesys == ""
        if xcoord == "RA--" && ycoord == "DEC-"
            if equinox === nothing
                radesys = "ICRS"
            elseif equinox < 1984.0
                radesys = "FK4"
            else
                radesys = "FK5"
            end  
        elseif xcoord == "GLON" && ycoord == "GLAT"
            radesys = "Gal"
        elseif xcoord == "TLON" && ycoord == "TLAT"
            radesys = "ITRS"
        end
    end
    
    return radesys
end
