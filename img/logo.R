library(ggplot2)

# --- 1. Define Pointed-Top Hexagon Vertices (Continuous Clockwise) ---
hex_x <- c(0,  0.866,  0.866, 0, -0.866, -0.866)
hex_y <- c(1,  0.5,   -0.5,  -1, -0.5,    0.5)

# --- 2. Define the Central Trend Line Split ---
line_data <- data.frame(
  x = c(-0.866, -0.5, -0.15,  0.2,  0.5, 0.866),
  y = c(-0.1,    0.2, -0.1,   0.3,  0.0, 0.1)
)

# --- 3. Construct Flawless Solid Polygons (No Gaps) ---
top_bg <- data.frame(
  x = c(line_data$x, 0.866, 0, -0.866),
  y = c(line_data$y, 0.5,   1,  0.5)
)

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
  
  # Layer 4: Custom Data Points
  geom_point(
    data = line_data[-c(1, 6), ], 
    aes(x = x, y = y), 
    color = "#FFFFFF", 
    fill  = "#A51C30", 
    shape = 21, 
    size  = 5.5, 
    stroke = 2.5
  ) +
  
  # Layer 5: Typography
  # Course Code
  annotate(
    "text", x = 0, y = 0.52, 
    label = "STAT 100", 
    color = "#FFFFFF", 
    size = 11, 
    fontface = "bold", 
    family = "sans"
  ) +
  
  # Course Title
  annotate(
    "text", x = 0, y = -0.48, 
    label = "Introduction to Statistics\nand Data Science", 
    color = "#FFFFFF", 
    size = 7, 
    fontface = "bold", 
    family = "sans", 
    lineheight = 1.1
  ) +
  
  # Website URL (Aligned along the bottom-right angled edge)
  annotate(
    "text", 
    x = 0.12, y = -0.85,              # Positioned along the inner bottom-right edge
    label = "stat-100.com", 
    color = "#FFFFFF", 
    size = 2.8, 
    angle = 30,                       # Angles the text parallel to the border
    fontface = "bold", 
    family = "sans",
    alpha = 0.85                      # Soft transparency to keep main text focused
  ) +
  
  # Layer 6: Heavy Outer Hexagon Frame Border
  geom_polygon(
    data = data.frame(x = hex_x, y = hex_y), 
    aes(x = x, y = y), 
    fill = "transparent", 
    color = "#000000", 
    linewidth = 4
  ) +
  
  # Coordinate scaling & stripping
  coord_fixed(xlim = c(-0.9, 0.9), ylim = c(-1.05, 1.05)) +
  theme_void() +
  theme(
    panel.background = element_rect(fill = "transparent", color = NA),
    plot.background  = element_rect(fill = "transparent", color = NA)
  )

# --- 5. Export Final Image ---
ggsave("logo/stat100-logo-square.png", plot = hex_sticker, width = 5, height = 5, dpi = 300, bg = "transparent")
ggsave("logo/stat100-logo-rectangle.png", plot = hex_sticker, width = 4.33, height = 5, dpi = 300, bg = "transparent")