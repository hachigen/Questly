-- mq.lua - Minimalist multi-threading library
-- Version: 1.0

local mq = {}

local sleepImpl = function(ms)
    local start = os.clock()
    while os.clock() - start < ms / 1000 do end
end

local sleep = function(ms)
    local co = coroutine.running()
    mq.schedule(ms, function() coroutine.resume(co) end)
    coroutine.yield()
end

local scheduled = {}
local updateRate = 0.1
local lastUpdate = os.clock()

mq.schedule = function(ms, fn)
    local startTime = os.clock() + ms / 1000
    table.insert(scheduled, {startTime = startTime, fn = fn})
end

mq.update = function()
    local now = os.clock()
    if now - lastUpdate >= updateRate then
        lastUpdate = now
        local i = 1
        while i <= #scheduled do
            local entry = scheduled[i]
            if entry.startTime <= now then
                table.remove(scheduled, i)
                entry.fn()
            else
                i = i + 1
            end
        end
    end
end

mq.sleep = sleep
mq.sleepImpl = sleepImpl

return mq
