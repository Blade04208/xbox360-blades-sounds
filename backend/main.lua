local fs = require("fs")
local logger = require("logger")
local millennium = require("millennium")

local function install_sounds()
    local target = fs.join(millennium.steam_path(), "steamui", "sounds")
    if not fs.exists(target) then
        local ok, directory_error = fs.create_directories(target)
        if not ok then
            error("Could not create " .. target .. ": " .. tostring(directory_error))
        end
    end

    local copied, kept, failed = 0, 0, 0
    for _, name in ipairs(millennium.assets.list("sounds")) do
        if name:lower():match("%.wav$") then
            local data = assert(millennium.assets.read("sounds/" .. name), "Missing sound: " .. name)
            local destination = fs.join(target, name)
            local existing = io.open(destination, "rb")
            local current
            if existing then
                current = existing:read("*a")
                existing:close()
            end
            if current == data then
                kept = kept + 1
            else
                local output, write_error = io.open(destination, "wb")
                local ok
                if output then
                    ok, write_error = output:write(data)
                    local closed, close_error = output:close()
                    if not closed then
                        ok, write_error = nil, close_error
                    end
                end
                if output and ok then
                    copied = copied + 1
                else
                    failed = failed + 1
                    logger:error("Could not install " .. name .. ": " .. tostring(write_error))
                end
            end
        end
    end

    logger:info(string.format("Sounds: %d copied, %d already in place, %d failed", copied, kept, failed))
end

local function on_load()
    local ok, load_error = pcall(install_sounds)
    if not ok then
        logger:error("Sound install failed: " .. tostring(load_error))
    end
    millennium.ready()
end

return {
    on_load = on_load,
}
