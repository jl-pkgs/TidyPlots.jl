# aspect_ratio=1.3, 
function set_china(shp; xlim = [70, 140], ylim = [15, 55], kw...)
  plot(shp;
    color=RGBA(0, 0, 0, 0),
    linecolor=:black,
    xlim,
    ylim,
    xticks=[], yticks=[],
    linewidth=0.5, kw...)
end

export set_china;
