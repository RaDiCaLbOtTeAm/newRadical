local function run(msg, matches)
local random3 = {
"ساییدی💦",
"جونم عشقم♥",
"WTF!?😶",
"Joons😈",
"بگو : کارت بگو :😤😬",
"What? : ",
"Joons? : ",
"Ble? : ",
": |",}
return random3[math.random(#random3)]
end
return {
patterns = {
"^ربات$",
"^rebot",
"^[/#!](rebot)",
"^Rebot",
},
run = run
}
