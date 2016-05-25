do
 
function pairsByKeys(t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
      return iter
    end
 
-- Returns true if is not empty
local function has_usage_data(dict)
  if (dict.usage == nil or dict.usage == '\n') then
    return false
  end
  return true
end
 
-- Get commands for that plugin
local function plugin_help(name,number,requester)
  local plugin = ""
  if number then
    local i = 0
    for name in pairsByKeys(plugins) do
      if plugins[name].hidden then
        name = nil
      else
        i = i + 1
        if i == tonumber(number) then
          plugin = plugins[name]
        end
      end
    end
  else
    plugin = plugins[name]
    if not plugin then return nil end
  end
 
    local text = ""
    if (type(plugin.usage) == "table") then
      for ku,usage in pairs(plugin.usage) do
          if ku == 'user' then -- usage for user
              if (type(plugin.usage.user) == "table") then
                  for k,v in pairs(plugin.usage.user) do
                      text = text..v..'\n---\n'
                  end
              elseif has_usage_data(plugin) then -- Is not empty
                  text = text..plugin.usage.user..'\n---\n'
              end
          elseif ku == 'moderator' then -- usage for moderator
              if requester == 'moderator' or requester == 'admin' or requester == 'sudo' then
                  if (type(plugin.usage.moderator) == "table") then
                      for k,v in pairs(plugin.usage.moderator) do
                          text = text..v..'\n---\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.moderator..'\n---\n'
                  end
              end
          elseif ku == 'admin' then -- usage for admin
              if requester == 'admin' or requester == 'sudo' then
                  if (type(plugin.usage.admin) == "table") then
                      for k,v in pairs(plugin.usage.admin) do
                          text = text..v..'\n---\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.admin..'\n---\n'
                  end
              end
          elseif ku == 'sudo' then -- usage for sudo
              if requester == 'sudo' then
                  if (type(plugin.usage.sudo) == "table") then
                      for k,v in pairs(plugin.usage.sudo) do
                          text = text..v..'\n---\n'
                      end
                  elseif has_usage_data(plugin) then -- Is not empty
                      text = text..plugin.usage.sudo..'\n---\n'
                  end
              end
          else
              text = text..usage..'\n---\n'
          end
      end
      text = text..''
    elseif has_usage_data(plugin) then -- Is not empty
      text = text..plugin.usage..''
    end
    return text
end
 
 
-- !available command
local function telegram_help()
  local i = 0
  local text = "Tools for SpheroBoT:\n----\n"
  -- Plugins names
  for name in pairsByKeys(plugins) do
    if plugins[name].hidden then
      name = nil
    else
    i = i + 1
    text = text..i..'. '..name..'\n'
    end
  end
  text = text..'\n'..'There are '..i..' plugins help available.'
  text = text..'\n'..'Write "!plugin> [plugin name]" or "plugin> [plugin number]" for more info.'
  text = text..'\n'..'Or "!help" to show all info.'
  return text
end
 
 
-- !help command
local function help_all(requester)
  local ret = ""
  for name in pairsByKeys(plugins) do
    if plugins[name].hidden then
      name = nil
    else
      ret = ret .. plugin_help(name, nil, requester)
    end
  end
  return ret
end
 
local function run(msg, matches)
  if is_sudo(msg) then
      requester = "sudo"
  elseif is_admin(msg) then
      requester = "admin"
  elseif is_momod(msg) then
      requester = "moderator"
  else
      requester = "user"
  end
  if matches[1] == "!available" then
    return telegram_help()
  elseif matches[1] == "!help" then
    return help_all(requester)
  else
    local text = ""
    if tonumber(matches[1])  then
      text = plugin_help(nil, matches[1], requester)
    else
      text = plugin_help(matches[1], nil, requester)
    end
    if not text then
      text = telegram_help()
    end
    return text
  end
end
 
return {
  description = "Help plugin. Get info from other plugins.  ",
  usage = {
    "!available: Show list of plugins for SpheroBoT.",
    "!help: Show all commands for every plugin.",
    "!plugin> [plugin name]: Commands for that plugin.",
    "!plugin> [number]: Commands for that plugin. Type !help to get the plugin number."
  },
  patterns = {
    "^!available$",
    "^!help$",
    "^!plugin> (.+)"
  },
  run = run
}
 
end
