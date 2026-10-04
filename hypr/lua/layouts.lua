-- vim: foldmethod=marker

-- ============================================================
--    __                       __
--   / /  ___ ___ _____  __ __/ /____
--  / /__/ _ `/ // / _ \/ // / __(_-<
-- /____/\_,_/\_, /\___/\_,_/\__/___/
--           /___/
-- ============================================================

hl.config({

    general = {
        layout = "dwindle",
    },

    -- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
    dwindle = {
        preserve_split = true,
    },

    -- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
    master = {
        new_status = "master",
    },

    -- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
    hl.config({
        scrolling = {
            fullscreen_on_one_column = true,
        },
    }),
})
