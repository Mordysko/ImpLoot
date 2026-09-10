-------------------------------------------------
-- ImpLoot Event System
--
-- Simple publish / subscribe system used to
-- decouple addon modules.
-------------------------------------------------

ImpLoot = ImpLoot or {}

ImpLoot.Events = {}

local Events = ImpLoot.Events

Events.Listeners = {}

-------------------------------------------------
-- Register
-------------------------------------------------

function Events:Register(eventName, callback)

    if not self.Listeners[eventName] then
        self.Listeners[eventName] = {}
    end

    table.insert(self.Listeners[eventName], callback)

end

-------------------------------------------------
-- Fire
-------------------------------------------------

function Events:Fire(eventName, ...)

    local listeners = self.Listeners[eventName]

    if not listeners then
        return
    end

    for _, callback in ipairs(listeners) do
        callback(...)
    end

end
