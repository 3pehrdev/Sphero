local function run(msg, matches) 
   if matches[1]:lower() == "github>" then 
      local dat = https.request("https://api.github.com/repos/"..matches[2]) 
      local jdat = JSON.decode(dat) 
      if jdat.message then 
         return "Not Found!\nExample:\ngithub username/project\ngithub 3pehrdev/spammer-bot\n\nSphero-bot ch: @SpheroCh" 
      end 
      local base = "curl 'https://codeload.github.com/"..matches[2].."/zip/master'" 
      local data = io.popen(base):read('*all') 
      f = io.open("file/github.zip", "w+") 
      f:write(data) 
      f:close() 
      return send_document("chat#id"..msg.to.id, "file/github.zip", ok_cb, false) 
   else 
      local dat = https.request("https://api.github.com/repos/"..matches[2]) 
      local jdat = JSON.decode(dat) 
      if jdat.message then 
         return "Not found! : \nExample : github username/project\ngithub 3pehrdev/spammer-bot\n\n Sphero-bot ch:  @SpheroCh" 
      end 
      local res = https.request(jdat.owner.url) 
      local jres = JSON.decode(res) 
      send_photo_from_url("chat#id"..msg.to.id, jdat.owner.avatar_url) 
      return "Account About:\n" 
         .."Account Name: "..(jres.name or "-----").."\n" 
         .."Username: "..jdat.owner.login.."\n" 
         .."Company Name: "..(jres.company or "-----").."\n" 
         .."WebSite: "..(jres.blog or "-----").."\n" 
         .."E-mail: "..(jres.email or "-----").."\n" 
         .."Location: "..(jres.location or "-----").."\n" 
         .."Repos: "..jres.public_repos.."\n" 
         .."Followers: "..jres.followers.."\n" 
         .."Following: "..jres.following.."\n" 
         .."Created at: "..jres.created_at.."\n" 
         .."Bio: "..(jres.bio or "-----").."\n\n" 
         .."Details:\n" 
         .."Project Name: "..jdat.name.."\n" 
         .."Github Page: "..jdat.html_url.."\n" 
         .."Source Package: "..jdat.clone_url.."\n" 
         .."Project Weblog: "..(jdat.homepage or "-----").."\n" 
         .."Account Created at: "..jdat.created_at.."\n" 
         .."Last Update: "..(jdat.updated_at or "-----").."\n" 
         .."Programming Language: "..(jdat.language or "-----").."\n" 
         .."Script Size: "..jdat.size.."\n" 
         .."Stars: "..jdat.stargazers_count.."\n" 
         .."Watch: "..jdat.watchers_count.."\n" 
         .."Fork: "..jdat.forks_count.."\n" 
         .."Subscribers: "..jdat.subscribers_count.."\n" 
         .."Description:\n"..(jdat.description or "-----").."\n" 
   end 
end 

return { 
   description = "Github Informations", 
   usage = { 
      "github (account/proje) : Project informations", 
      "github> (account/proje) : Source Download", 
      }, 
   patterns = { 
      "^([Gg]ithub>) (.*)", 
      "^([Gg]ithub) (.*)", 
      }, 
   run = run 
} 
