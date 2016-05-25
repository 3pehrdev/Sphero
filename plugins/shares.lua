do

function run(msg, matches)     -- Bot number     -- first name        -- last name
send_contact(get_receiver(msg), "+639080452513", "SpheroBoT", "@SpheroCh", ok_cb, false)
end

return {
patterns = {
"^!share$",
"^share$",
"^Share$",
"^/share$",
"^/number$",
"^!share$",
"^!number$",
"^Number$",
"^number$",
"^phone$",
"^Phone$",
"^/phone$",

},
run = run
}

end
