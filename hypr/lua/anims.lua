-- vi:foldmethod=marker

-- ============================================================
--    ___        _            __  _
--   / _ | ___  (_)_ _  ___ _/ /_(_)__  ___  ___
--  / __ |/ _ \/ /  ' \/ _ `/ __/ / _ \/ _ \(_-<
-- /_/ |_/_//_/_/_/_/_/\_,_/\__/_/\___/_//_/___/
-- ============================================================

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
-- hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, damping = 24 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "gnomed" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "linear", style = "gnomed" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = false, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint", popin = "0%" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade", popin = "0%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", popin = "0%" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.21, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
