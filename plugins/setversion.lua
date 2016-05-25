local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)
local VERSION = data[tostring(msg.to.id)]['VERSION']

if matches[1] and is_sudo(msg) then
    
data[tostring(msg.to.id)]['VERSION'] = matches[1]
        save_data(_config.moderation.data, data)
        
        return 'Bot Version Has benn upgraded to '..matches[1]

end
if not is_sudo(msg) then 
    return 'only for sudo !'
    end
end
return {
  patterns = {
  "^[!/]setversion (.*)$",
  },
  run = run
}
