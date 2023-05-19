module TidyPlots

using Reexport
using Plots
@reexport using Plots.PlotMeasures
using Shapefile

include("raster.jl")
include("shapefile.jl")
include("Region.jl")

include("path_mnt.jl")
include("tools.jl")

end 
