Skip to content
This repository
Pull requests
Issues
Gist
 @3pehrdev
 Unwatch 1
  Star 0
  Fork 1 3pehrdev/apibot
 Code  Issues 0  Pull requests 0  Wiki  Pulse  Graphs  Settings
Branch: master Find file apibot/plugins/filter.lua
197f6eb  5 days ago
@3pehrdev 3pehrdev Create filter.lua
1 contributor
RawBlameHistory    144 lines (137 sloc)  5.1 KB
local function save_filter(msg, name, value) 
   local hash = nil 
   if msg.to.type == 'chat' then 
      hash = 'chat:'..msg.to.id..':filters' 
   end 
   if msg.to.type == 'user' then 
      return 'only for the groups!' 
   end 
   if hash then 
      redis:hset(hash, name, value) 
      return "Done!!\n#Sphero_Helper" 
   end 
end 

local function get_filter_hash(msg) 
   if msg.to.type == 'chat' then 
      return 'chat:'..msg.to.id..':filters' 
   end 
end 

local function list_filter(msg) 
   if msg.to.type == 'user' then 
      return 'only for the groups' 
   end 
   local hash = get_filter_hash(msg) 
   if hash then 
      local names = redis:hkeys(hash) 
      local text = 'FilterList for'..msg.to.title..'\n And Your #ID : '..msg.to.id..':\n______________________________\n' 
      for i=1, #names do 
         text = text..'> '..names[i]..'\n' 
      end 
      return text 
   end 
end 

local function get_filter(msg, var_name) 
   local hash = get_filter_hash(msg) 
   if hash then 
      local value = redis:hget(hash, var_name) 
      if value == 'msg' then 
         return 'Word is Blocked on group \nplease not write this Word in this Group' 
      elseif value == 'kick' then 
         send_large_msg('chat#id'..msg.to.id, "Word is Blocked\nWrite = kick\n bye!!") 
         chat_del_user('chat#id'..msg.to.id, 'user#id'..msg.from.id, ok_cb, true) 
      end 
   end 
end 

local function get_filter_act(msg, var_name) 
   local hash = get_filter_hash(msg) 
   if hash then 
      local value = redis:hget(hash, var_name) 
      if value == 'msg' then 
         return 'Warning and pointed to the word!!' 
      elseif value == 'kick' then 
         return 'This word is Blocked!' 
      elseif value == 'none' then 
         return 'The word has been out of Filter!!' 
      end 
   end 
end 

local function run(msg, matches) 
   local data = load_data(_config.moderation.data) 
   if matches[1] == "ilterlist" then 
      return list_filter(msg) 
   elseif matches[1] == "ilter" and matches[2] == ">" then 
      if data[tostring(msg.to.id)] then 
         local settings = data[tostring(msg.to.id)]['settings'] 
         if not is_momod(msg) then 
            return "only for the moderators!" 
         else 
            local value = 'msg' 
            local name = string.sub(matches[3]:lower(), 1, 1000) 
            local text = save_filter(msg, name, value) 
            return text 
         end 
      end 
   elseif matches[1] == "ilter" and matches[2] == "+" then 
      if data[tostring(msg.to.id)] then 
         local settings = data[tostring(msg.to.id)]['settings'] 
         if not is_momod(msg) then 
            return "only for the moderators!" 
         else 
            local value = 'kick' 
            local name = string.sub(matches[3]:lower(), 1, 1000) 
            local text = save_filter(msg, name, value) 
            return text 
         end 
      end 
   elseif matches[1] == "ilter" and matches[2] == "-" then 
      if data[tostring(msg.to.id)] then 
         local settings = data[tostring(msg.to.id)]['settings'] 
         if not is_momod(msg) then 
            return "only for the moderators!" 
         else 
            local value = 'none' 
            local name = string.sub(matches[3]:lower(), 1, 1000) 
            local text = save_filter(msg, name, value) 
            return text 
         end 
      end 
   elseif matches[1] == "ilter" and matches[2] == "?" then 
      return get_filter_act(msg, matches[3]:lower()) 
   else 
      if is_sudo(msg) then 
         return 
      elseif is_admin(msg) then 
         return 
      elseif is_momod(msg) then 
         return 
      elseif tonumber(msg.from.id) == tonumber(our_id) then 
         return 
      else 
         return get_filter(msg, msg.text:lower()) 
      end 
   end 
end 

return { 
   description = "Set and Get Variables", 
   usagehtm = '<tr><td align="center">filter > کلمه</td><td align="right">این دستور یک کلمه را ممنوع میکند و اگر توسط کاربری این کلمه استفاده شود، به او تذکر داده خواهد شد</td></tr>' 
   ..'<tr><td align="center">filter + کلمه</td><td align="right">این دستور کلمه ای را فیلتر میکند به طوری که اگر توسط کاربری استفاده شود، ایشان کیک میگردند</td></tr>' 
   ..'<tr><td align="center">filter - کلمه</td><td align="right">کلمه ای را از ممنوعیت یا فیلترینگ خارج میکند</td></tr>' 
   ..'<tr><td align="center">filter ? کلمه</td><td align="right">با این دستوع اکشن بر روی کلمه ای را میتوانید مشاهده کنید یعنی میتوانید متوجه شوید که این کلمه فیلتر است،ممنوع است یا از فیلترینگ خارج شده</td></tr>', 
   usage = { 
   user = { 
      "filter ? (word) ", 
      "filterlist ", 
   }, 
   moderator = { 
      "filter > (word) : warning!", 
      "filter + (word) : kick!", 
      "filter - (word) : filter out!", 
   }, 
   }, 
   patterns = { 
      "^[Ff](ilter) (.+) (.*)$", 
      "^[Ff](ilterlist)$", 
      "(.*)", 
   }, 
   run = run 
} 
Status API Training Shop Blog About
© 2016 GitHub, Inc. Terms Privacy Security Contact Help
