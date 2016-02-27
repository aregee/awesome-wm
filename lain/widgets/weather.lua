
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2015, Luke Bonham                     
                                                  
--]]

local newtimer     = require("lain.helpers").newtimer
local read_pipe    = require("lain.helpers").read_pipe

local async        = require("lain.asyncshell")
local json         = require("lain.util").dkjson
local lain_icons   = require("lain.helpers").icons_dir

local naughty      = require("naughty")
local wibox        = require("wibox")

local math         = { floor  = math.floor }
local mouse        = mouse
local string       = { format = string.format,
                       gsub   = string.gsub }

local setmetatable = setmetatable

-- OpenWeatherMap
-- current weather and X-days forecast
-- lain.widgets.weather

local function worker(args)
    local weather               = {}
    local args                  = args or {}
    local APPID                 = args.APPID or "3e321f9414eaedbfab34983bda77a66e" -- lain default
    local timeout               = args.timeout or 900   -- 15 min
    local timeout_forecast      = args.timeout or 86400 -- 24 hrs
    local current_call          = "curl -s 'http://api.openweathermap.org/data/2.5/weather?id=%s&units=%s&lang=%s&APPID=%s'"
    local forecast_call         = "curl -s 'http://api.openweathermap.org/data/2.5/forecast/daily?id=%s&units=%s&lang=%s&cnt=%s&APPID=%s'"
    local city_id               = args.city_id or 0 -- placeholder
    local units                 = args.units or "metric"
    local lang                  = args.lang or "en"
    local cnt                   = args.cnt or 7
    local date_cmd              = args.date_cmd or "date -u -d @%d +'%%a %%d'"
    local icons_path            = args.icons_path or lain_icons .. "openweathermap/"
    local notification_preset   = args.notification_preset or {}
    local notification_text_fun = args.notification_text_fun or
                                  function (day, desc, tmin, tmax)
                                      return string.format("<b>%s</b>: %s, %d - %d  ", day, desc, tmin, tmax)
                                  end
    local weather_na_markup     = args.weather_na_markup or " N/A "
    local followmouse           = args.followmouse or false
    local settings              = args.settings or function() end

    weather.widget    = wibox.widget.textbox(weather_na_markup)
    weather.icon_path = icons_path .. "na.png"
    weather.icon      = wibox.widget.imagebox(weather.icon_path)

    function weather.show(t_out)
        weather.hide()

        if followmouse then
            notification_preset.screen = mouse.screen
        end

        weather.notification = naughty.notify({
            text    = weather.notification_text
                      or "Waiting for the server to respond...",
            icon    = weather.icon_path,
            timeout = t_out,
            preset  = notification_preset
        })
    end

    function weather.hide()
        if weather.notification ~= nil then
            naughty.destroy(weather.notification)
            weather.notification = nil
        end
    end

    function weather.attach(obj)
        obj:connect_signal("mouse::enter", function()
            weather.show(0)
        end)
        obj:connect_signal("mouse::leave", function()
            weather.hide()
        end)
    end

    function weather.forecast_update()
        local cmd = string.format(forecast_call, city_id, units, lang, cnt, APPID)
        async.request(cmd, function(f)
            local pos, err
            weather_now, pos, err = json.decode(f, 1, nil)

            if not err and weather_now ~= nil and tonumber(weather_now["cod"]) == 200 then
                weather.notification_text = ''
                for i = 1, weather_now["cnt"] do
                    local day = string.gsub(read_pipe(string.format(date_cmd, weather_now["list"][i]["dt"])), "\n", "")

                    local tmin = math.floor(weather_now["list"][i]["temp"]["min"])
                    local tmax = math.floor(weather_now["list"][i]["temp"]["max"])
                    local desc = weather_now["list"][i]["weather"][1]["description"]

                    weather.notification_text = weather.notification_text ..
                                                notification_text_fun(day, desc, tmin, tmax)

                    if i < weather_now["cnt"] then
                        weather.notification_text = weather.notification_text .. "\n"
                    end
                end
            else
                weather.notification_text = "API/connection error or bad/not set city ID"
            end
        end)
    end

    function weather.update()
        local cmd = string.format(current_call, city_id, units, lang, APPID)
        async.request(cmd, function(f)
            local pos, err
            weather_now, pos, err = json.decode(f, 1, nil)

            if not err and weather_now ~= nil and tonumber(weather_now["cod"]) == 200 then
                weather.icon_path = icons_path .. weather_now["weather"][1]["icon"] .. ".png"
                widget = weather.widget
                settings()
            else
                weather.icon_path = icons_path .. "na.png"
                weather.widget:set_markup(weather_na_markup)
            end

            weather.icon:set_image(weather.icon_path)
        end)
    end

    weather.attach(weather.widget)

    newtimer("weather-" .. city_id, timeout, weather.update)
    newtimer("weather_forecast-" .. city_id, timeout, weather.forecast_update)

    return setmetatable(weather, { __index = weather.widget })
end

return setmetatable({}, { __call = function(_, ...) return worker(...) end })
