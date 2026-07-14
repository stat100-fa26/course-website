# Produced with a lot of help from Gemini

library(ggplot2)

# --- 1. Define Pointed-Top Hexagon Vertices (Continuous Clockwise) ---
# Radius = 1. Width from far left to far right is exactly sqrt(3) ~ 1.732
hex_x <- c(0,  0.866,  0.866, 0, -0.866, -0.866)
hex_y <- c(1,  0.5,   -0.5,  -1, -0.5,    0.5)

# --- 2. Define the Central Trend Line Split ---
# The line must start exactly at the left edge (-0.866) and end at the right edge (0.866)
line_data <- data.frame(
  x = c(-0.866, -0.5, -0.15,  0.2,  0.5, 0.866),
  y = c(-0.1,    0.2, -0.1,   0.3,  0.0, 0.1)
)

# --- 3. Construct Flawless Solid Polygons (No Gaps) ---
# Top Half: Trace the line left-to-right, then close up around the upper hex points
top_bg <- data.frame(
  x = c(line_data$x, 0.866, 0, -0.866),
  y = c(line_data$y, 0.5,   1,  0.5)
)

# Bottom Half: Trace the line left-to-right, then close down around the lower hex points
bottom_bg <- data.frame(
  x = c(line_data$x, 0.866, 0, -0.866),
  y = c(line_data$y, -0.5, -1, -0.5)
)

# --- 4. Assemble the Complete Hex Sticker ---
hex_sticker <- ggplot() +
  
  # Layer 1: Solid Black Top Background
  geom_polygon(data = top_bg, aes(x = x, y = y), fill = "#1E1E1E") +
  
  # Layer 2: Solid Crimson Bottom Background
  geom_polygon(data = bottom_bg, aes(x = x, y = y), fill = "#A51C30") +
  
  # Layer 3: White Dividing Trend Line
  geom_line(data = line_data, aes(x = x, y = y), color = "#FFFFFF", linewidth = 2.5) +
  
  # Layer 4: Custom Data Points (Hollow Style: White Border, Crimson Center)
  geom_point(
    data = line_data[-c(1, 6), ], # Drop the boundary anchor points
    aes(x = x, y = y), 
    color = "#FFFFFF", 
    fill  = "#A51C30", 
    shape = 21, 
    size  = 5.5, 
    stroke = 2.5
  ) +
  
  # Layer 5: Typography
  # Course Code (Neatly placed in the upper black panel)
  annotate(
    "text", x = 0, y = 0.52, 
    label = "STAT 100", 
    color = "#FFFFFF", 
    size = 11, 
    fontface = "bold", 
    family = "sans"
  ) +
  
  # Course Title (Neatly wrapped in the lower crimson panel)
  annotate(
    "text", x = 0, y = -0.48, 
    label = "Introduction to Statistics\nand Data Science", 
    color = "#FFFFFF", 
    size = 7, 
    fontface = "bold", 
    family = "sans", 
    lineheight = 1.1
  ) +
  
  # Layer 6: Heavy Outer Hexagon Frame Border (Masking the canvas)
  geom_polygon(
    data = data.frame(x = hex_x, y = hex_y), 
    aes(x = x, y = y), 
    fill = "transparent", 
    color = "#000000", 
    linewidth = 4
  ) +
  
  # Fixed coordinate scaling and canvas stripping
  coord_fixed(xlim = c(-0.9, 0.9), ylim = c(-1.05, 1.05)) +
  theme_void() +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA),
    plot.background  = element_rect(fill = "transparent", color = NA)
  )

# --- 5. Export Final Image ---
ggsave(
  filename = "logo/stat100-logo-square.png", 
  plot = hex_sticker, 
  width = 5, 
  height = 5, 
  dpi = 300, 
  bg = "transparent"
)

# Changing width to 4.33 matches the exact mathematical aspect ratio of the hex
ggsave(
  filename = "logo/stat100-logo-rectangle.png", 
  plot = hex_sticker, 
  width = 4.33,   # Adjusted from 5 to trim the transparent side margins
  height = 5, 
  dpi = 300, 
  bg = "transparent"
)
