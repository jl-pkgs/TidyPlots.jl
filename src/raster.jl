# This script is modified from: 
#   `https://github.com/evetion/GeoArrays.jl/blob/master/src/plot.jl`
# Copyright (c) 2018 Maarten Pronk, MIT license

abstract type AbstractRast{T,N} <: AbstractArray{T,N} end

Base.@kwdef mutable struct rast{T<:Real,N} <: AbstractRast{T,N}
  A::AbstractArray{T,N}
  x::AbstractVector
  y::AbstractVector
end

# missval replaced with zero
# TODO: change cmap, improve for missing values
@recipe function plot(ra::AbstractRast; band=1, fact=nothing, missval=nothing)
  xflip --> false
  yflip --> false
  aspect_ratio --> 1
  seriestype := :heatmap
  seriescolor := :viridis
  framestyle := :box

  # 默认的分辨率为全球0.25°
  if fact === nothing
    n = prod(size(ra.A)[1:2])
    cellsize = 0.5
    fact = ceil(Int, sqrt(n / (360 / cellsize * 180 / cellsize)))
  end

  if fact > 1
    println("[st_plot]: fact = $fact\n")
    # ra = resample(ra, fact)
  end
  
  if missval !== nothing
    type = eltype(ra.A)
    replace!(ra.A, type(missval) => type(0))
  end
  
  # coords = st_coordinates(ra)
  x = ra.x
  y = ra.y
  # x = st_coordinates(ra, :x)
  # y = st_coordinates(ra, :y)
  # x = map(x->x[1], coords[:, 1])
  # y = map(x->x[2], coords[end, :])
  z = ra.A[:, :, band]'

  # Can't use x/yflip as x/y coords
  # have to be sorted for Plots
  # if ra.f.linear[1] < 0
  #   z = reverse(z, dims=2)
  #   reverse!(x)
  # end

  # if ra.f.linear[4] < 0
    z = reverse(z, dims=1)
    reverse!(y)
  # end
  
  xlims --> (extrema(x))
  ylims --> (extrema(y))

  x, y, z
end


export AbstractRast, rast, plot
