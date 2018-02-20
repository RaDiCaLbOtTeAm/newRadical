local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '💥You are not bot admin\nChannel:\n'
else
     return '💥شما مدیر ربات نمیباشید\n     \n'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '💥Group is already added\nChannel:\n'
else
return '💥گروه در لیست گروه های مدیریتی ربات هم اکنون موجود است\n     \n'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = '🔓',
          lock_tag = '🔓',
          lock_spam = '🔓',
          lock_webpage = '🔓',
          lock_markdown = '🔓',
          flood = '🔓',
          lock_bots = '🔓',
          lock_pin = '🔓',
          welcome = '🔓',
		  lock_join = '🔓',
		  lock_edit = '🔓',
		  lock_arabic = '🔓',
		  lock_mention = '🔓',
		  lock_all = '🔓',
		  num_msg_max = '5',
		  set_char = '40',
		  time_check = '2',
          },
   mutes = {
                  mute_forward = '🔓',
                  mute_audio = '🔓',
                  mute_video = '🔓',
                  mute_contact = '🔓',
                  mute_text = '🔓',
                  mute_photo = '🔓',
                  mute_gif = '🔓',
                  mute_location = '🔓',
                  mute_document = '🔓',
                  mute_sticker = '🔓',
                  mute_voice = '🔓',
                  mute_all = '🔓',
				  mute_keyboard = '🔓',
				  mute_game = '🔓',
				  mute_inline = '🔓',
				  mute_tgservice = '🔓',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '💥Group has been added\nChannel:\n'..msg_caption
else
  return '💥گروه با موفقیت به لیست گروه های مدیریتی ربات افزوده شد\n     \n'..msg_caption
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '💥You are not bot admin\nChannel:\n'
   else
        return '💥شما مدیر ربات نمیباشید\n     \n'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '💥Group is not added\nChannel:\n'
else
    return '💥گروه به لیست گروه های مدیریتی ربات اضافه نشده است\n     \n'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '💥Group has been removed\nChannel:\n'
 else
  return '💥گروه با موفقیت از لیست گروه های مدیریتی ربات حذف شد\n     \n'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "💥Word *"..word.."* is already filtered\nChannel:\n"
            else
         return "💥کلمه *"..word.."* از قبل فیلتر بود\n     \n"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "💥Word *"..word.."* added to filtered words list\nChannel:\n"
            else
         return "💥کلمه *"..word.."* به لیست کلمات فیلتر شده اضافه شد\n     \n"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "💥Word *"..word.."* removed from filtered words list\nChannel:\n"
       elseif lang then
         return "💥کلمه *"..word.."* از لیست کلمات فیلتر شده حذف شد\n     \n"
     end
      else
       if not lang then
         return "💥_Word_ *"..word.."* _is not filtered_\nChannel:\n"
       elseif lang then
         return "💥_کلمه_ *"..word.."* _از قبل فیلتر نبود_\n     \n"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id)] then
  if not lang then
    return "💥_Group is not added_\nChannel:\n"
 else
    return "💥گروه به لیست گروه های مدیریتی ربات اضافه نشده است\n     \n"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "💥_No_ *moderator* _in this group_\nChannel:\n"
else
   return "💥در حال حاضر هیچ مدیری برای گروه انتخاب نشده است\n     \n"
  end
end
if not lang then
   message = '💥*List of moderators :*\n'
else
   message = '💥*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "💥_Group is not added_\nChannel:\n"..msg_caption
else
return "💥گروه به لیست گروه های مدیریتی ربات اضافه نشده است\n     \n"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "💥_No_ *owner* _in this group_\nChannel:\n"
else
    return "💥در حال حاضر هیچ مالکی برای گروه انتخاب نشده است\n     \n"
  end
end
if not lang then
   message = '💥*List of moderators :*\n'
else
   message = '💥*لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id) then return false end
    if data.sender_user_id then
  if not administration[tostring(data.chat_id)] then
  if not lang then
    return tdbot.sendMessage(data.chat_id, "", 0, "💥_Group is not added_\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(data.chat_id, "", 0, "💥_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_\n     \n", 0, "md")
     end
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already in_ *white list*\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل در لیست سفید بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been added to_ *white list*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به لیست سفید اضافه شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, setwhitelist_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not in_ *white list*\nChannel:\n", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل در لیست سفید نبود*\n     \n", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been removed from_ *white list*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از لیست سفید حذف شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, remwhitelist_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already a_ *group owner*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل صاحب گروه بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is now the_ *group owner*\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به مقام صاحب گروه منتصب شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, owner_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already a_ *moderator*\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل مدیر گروه بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been_ *promoted*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به مقام مدیر گروه منتصب شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, promote_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not a_ *group owner*\nChannel:\n", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* *از قبل صاحب گروه نبود*\nChannel:\n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is no longer a_ *group owner*\nChannel:\n", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از مقام صاحب گروه برکنار شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, rem_owner_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not a_ *moderator*\nChannel:\n", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل مدیر گروه نبود*\n     \n", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been_ *demoted*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از مقام مدیر گروه برکنار شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, demote_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdbot.sendMessage(arg.chat_id, "", 0, "*"..data.id.."*", 0, "md")
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, id_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
else
    if lang then
  return tdbot.sendMessage(data.chat_id, "", 0, "کاربر یافت نشد\n     \n", 0, "md")
   else
  return tdbot.sendMessage(data.chat_id, "", 0, "💥*User Not Found*\nChannel:\n", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
    --return tdbot.sendMessage(arg.chat_id, "", 0, serpent.block(data), 0, "html")
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_Group is not added_\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_\n     \n", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id then
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
    --return tdbot.sendMessage(arg.chat_id, "", 0, serpent.block(data), 0, "html")
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already in_ *white list*\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل در لیست سفید بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been added to_ *white list*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به لیست سفید اضافه شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, setwhitelist_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not in_ *white list*\nChannel:\n", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل در لیست سفید نبود*\n     \n", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been removed from_ *white list*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از لیست سفید حذف شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, remwhitelist_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already a_ *group owner*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل صاحب گروه بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "_💥User_ "..user_name.." *"..data.id.."* _is now the_ *group owner*\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به مقام صاحب گروه منتصب شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, owner_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already a_ *moderator*\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل مدیر گروه بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been_ *promoted*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به مقام مدیر گروه منتصب شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, promote_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not a_ *group owner*\nChannel:\n", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* *از قبل صاحب گروه نبود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is no longer a_ *group owner*\nChannel:\n", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از مقام صاحب گروه برکنار شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, rem_owner_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not a_ *moderator*\nChannel:\n", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل مدیر گروه نبود*\n     \n", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been_ *demoted*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از مقام مدیر گروه برکنار شد*\n     \n", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, demote_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "res" then
local function res_cb(arg, data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_This user doesn't exists._\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "*💥کاربر موردنظر وجود ندارد*\n     \n", 0, "md")
     end
 end
if data.last_name then
user_name = check_markdown(data.first_name).." "..check_markdown(data.last_name)
else
user_name = check_markdown(data.first_name)
end
    if not lang then
     text = "💥_Result For :_ @"..check_markdown(data.username).."\n_Name :_ "..user_name.."\n_ID :_ `"..data.id.."`"
      else
     text = "💥_اطلاعات برای :_ @"..check_markdown(data.username).."\n_نام :_ "..user_name.."\n_ایدی :_ `"..data.id.."`"
  end
    return tdbot.sendMessage(arg.chat_id, "", 0, text, 0, "md")
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, res_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "_💥کاربر یافت نشد_\n     \n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥*User Not Found*\nChannel:\n", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdbot.sendMessage(data.chat_id, "", 0, "💥_Group is not added_\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(data.chat_id, "", 0, "💥_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_\n     \n", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id then
if data.first_name then
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already in_ *white list*\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل در لیست سفید بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been added to_ *white list*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به لیست سفید اضافه شد*\n     \n", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not in_ *white list*\nChannel:\n", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل در لیست سفید نبود*\n     \n", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been removed from_ *white list*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از لیست سفید حذف شد*\n     \n", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already a_ *group owner*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل صاحب گروه بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is now the_ *group owner*\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به مقام صاحب گروه منتصب شد*\n     \n", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is already a_ *moderator*\nChannel:\n", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل مدیر گروه بود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been_ *promoted*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *به مقام مدیر گروه منتصب شد*\n     \n", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not a_ *group owner*\nChannel:\n", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "💥کاربر "..user_name.." *"..data.id.."* *از قبل صاحب گروه نبود*\n     \n", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is no longer a_ *group owner*\nChannel:\n", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از مقام صاحب گروه برکنار شد*\n     \n", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _is not a_ *moderator*\nChannel:\n", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از قبل مدیر گروه نبود*\n     \n", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User_ "..user_name.." *"..data.id.."* _has been_ *demoted*\nChannel:\n", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "💥_کاربر_ "..user_name.." *"..data.id.."* *از مقام مدیر گروه برکنار شد*\n     \n", 0, "md")
   end
end
    if cmd == "whois" then
if data.username then
username = '@'..check_markdown(data.username)
else
if not lang then
username = '💥not found\nChannel:\n'
 else
username = '💥ندارد\n     \n'
  end
end
     if not lang then
       return tdbot.sendMessage(arg.chat_id, "", 0, '💥Info for [ '..data.id..' ] :\nUserName : '..username..'\nName : '..check_markdown(data.first_name), 0, "md")
   else
       return tdbot.sendMessage(arg.chat_id, "", 0, '💥اطلاعات برای [ '..data.id..' ] :\nیوزرنیم : '..username..'\nنام : '..check_markdown(data.first_name), 0, "md")
      end
   end
 else
    if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥_User not founded_\nChannel:\n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "_💥کاربر یافت نشد_\n     \n", 0, "md")
    end
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "_💥کاربر یافت نشد_\n     \n", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "💥*User Not Found*\nChannel:\n", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "🔐" then
if not lang then
 return "💥*Link* _Posting Is Already Locked_"
elseif lang then
 return "💥ارسال لینک در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_link"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Link* _Posting Has Been Locked_"
else
 return "💥ارسال لینک در گروه ممنوع شد"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "🔓" then
if not lang then
return "💥*Link* _Posting Is Not Locked_" 
elseif lang then
return "💥ارسال لینک در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Link* _Posting Has Been Unlocked_" 
else
return "💥ارسال لینک در گروه آزاد شد"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "🔐" then
if not lang then
 return "💥*Tag* _Posting Is Already Locked_"
elseif lang then
 return "💥ارسال تگ در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Tag* _Posting Has Been Locked_"
else
 return "💥ارسال تگ در گروه ممنوع شد"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "🔓" then
if not lang then
return "💥*Tag* _Posting Is Not Locked_" 
elseif lang then
return "💥ارسال تگ در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Tag* _Posting Has Been Unlocked_" 
else
return "💥ارسال تگ در گروه آزاد شد"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "🔐" then
if not lang then
 return "💥*Mention* _Posting Is Already Locked_"
elseif lang then
 return "💥ارسال فراخوانی افراد هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "🔐"
save_data(_config.moderation.data, data)
if not lang then 
 return "💥*Mention* _Posting Has Been Locked_"
else 
 return "💥ارسال فراخوانی افراد در گروه ممنوع شد"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "🔓" then
if not lang then
return "💥*Mention* _Posting Is Not Locked_" 
elseif lang then
return "💥ارسال فراخوانی افراد در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mention* _Posting Has Been Unlocked_" 
else
return "💥ارسال فراخوانی افراد در گروه آزاد شد"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "🔐" then
if not lang then
 return "💥*Arabic/Persian* _Posting Is Already Locked_"
elseif lang then
 return "💥ارسال کلمات عربی/فارسی در گروه هم اکنون ممنوع است"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Arabic/Persian* _Posting Has Been Locked_"
else
 return "💥ارسال کلمات عربی/فارسی در گروه ممنوع شد"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "🔓" then
if not lang then
return "💥*Arabic/Persian* _Posting Is Not Locked_" 
elseif lang then
return "💥ارسال کلمات عربی/فارسی در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Arabic/Persian* _Posting Has Been Unlocked_" 
else
return "💥ارسال کلمات عربی/فارسی در گروه آزاد شد"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "🔐" then
if not lang then
 return "💥*Editing* _Is Already Locked_"
elseif lang then
 return "💥ویرایش پیام هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Editing* _Has Been Locked_"
else
 return "💥ویرایش پیام در گروه ممنوع شد"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "🔓" then
if not lang then
return "💥*Editing* _Is Not Locked_" 
elseif lang then
return "💥ویرایش پیام در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Editing* _Has Been Unlocked_" 
else
return "💥ویرایش پیام در گروه آزاد شد"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "🔐" then
if not lang then
 return "💥*Spam* _Is Already Locked_"
elseif lang then
 return "💥ارسال هرزنامه در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Spam* _Has Been Locked_"
else
 return "💥ارسال هرزنامه در گروه ممنوع شد"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "🔓" then
if not lang then
return "💥*Spam* _Posting Is Not Locked_" 
elseif lang then
 return "💥ارسال هرزنامه در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "🔓" 
save_data(_config.moderation.data, data)
if not lang then 
return "💥*Spam* _Posting Has Been Unlocked_" 
else
 return "💥ارسال هرزنامه در گروه آزاد شد"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "🔐" then
if not lang then
 return "💥*Flooding* _Is Already Locked_"
elseif lang then
 return "💥ارسال پیام مکرر در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["flood"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Flooding* _Has Been Locked_"
else
 return "💥ارسال پیام مکرر در گروه ممنوع شد"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "🔓" then
if not lang then
return "💥*Flooding* _Is Not Locked_" 
elseif lang then
return "💥ارسال پیام مکرر در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["flood"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Flooding* _Has Been Unlocked_" 
else
return "💥ارسال پیام مکرر در گروه آزاد شد"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "🔐" then
if not lang then
 return "💥*Bots* _Protection Is Already Enabled_"
elseif lang then
 return "💥محافظت از گروه در برابر ربات ها هم اکنون فعال است"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Bots* _Protection Has Been Enabled_"
else
 return "💥محافظت از گروه در برابر ربات ها فعال شد"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "🔓" then
if not lang then
return "💥*Bots* _Protection Is Not Enabled_" 
elseif lang then
return "💥محافظت از گروه در برابر ربات ها غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Bots* _Protection Has Been Disabled_" 
else
return "💥محافظت از گروه در برابر ربات ها غیر فعال شد"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "🔐" then
if not lang then
 return "💥*Lock Join* _Is Already Locked_"
elseif lang then
 return "ورود به گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Lock Join* _Has Been Locked_"
else
 return "💥ورود به گروه ممنوع شد"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "🔓" then
if not lang then
return "💥*Lock Join* _Is Not Locked_" 
elseif lang then
return "💥ورود به گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "🔓"
save_data(_config.moderation.data, data) 
if not lang then
return "💥*Lock Join* _Has Been Unlocked_" 
else
return "💥ورود به گروه آزاد شد"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "🔐" then
if not lang then 
 return "💥*Markdown* _Posting Is Already Locked_"
elseif lang then
 return "💥ارسال پیام های دارای فونت در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Markdown* _Posting Has Been Locked_"
else
 return "💥ارسال پیام های دارای فونت در گروه ممنوع شد"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "🔓" then
if not lang then
return "💥*Markdown* _Posting Is Not Locked_"
elseif lang then
return "💥ارسال پیام های دارای فونت در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "🔓" save_data(_config.moderation.data, data) 
if not lang then
return "💥*Markdown* _Posting Has Been Unlocked_"
else
return "💥ارسال پیام های دارای فونت در گروه آزاد شد"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "🔐" then
if not lang then
 return "💥*Webpage* _Is Already Locked_"
elseif lang then
 return "💥ارسال صفحات وب در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Webpage* _Has Been Locked_"
else
 return "💥ارسال صفحات وب در گروه ممنوع شد"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "🔓" then
if not lang then
return "💥*Webpage* _Is Not Locked_" 
elseif lang then
return "💥ارسال صفحات وب در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "🔓"
save_data(_config.moderation.data, data) 
if not lang then
return "💥*Webpage* _Has Been Unlocked_" 
else
return "💥ارسال صفحات وب در گروه آزاد شد"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "🔐" then
if not lang then
 return "💥*Pinned Message* _Is Already Locked_"
elseif lang then
 return "💥سنجاق کردن پیام در گروه هم اکنون ممنوع است"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "🔐"
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Pinned Message* _Has Been Locked_"
else
 return "💥سنجاق کردن پیام در گروه ممنوع شد"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "🔓" then
if not lang then
return "💥*Pinned Message* _Is Not Locked_" 
elseif lang then
return "💥سنجاق کردن پیام در گروه ممنوع نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "🔓"
save_data(_config.moderation.data, data) 
if not lang then
return "💥*Pinned Message* _Has Been Unlocked_" 
else
return "💥سنجاق کردن پیام در گروه آزاد شد"
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "💥_You're Not_ *Moderator*"
else
  return "💥شما مدیر گروه نمیباشید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "🔐"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "🔐"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "🔓"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "🔓"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "🔓"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "🔐"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "🔐"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "🔐"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "🔓"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "🔓"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "🔓"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "🔓"		
 end
 end
 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "🔓"		
 end
 end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
if not lang then

local settings = data[tostring(target)]["settings"] 
 text = "*💥Group Lock Settings:*\n_edit :_ *"..settings.lock_edit.."*\n_links :_ *"..settings.lock_link.."*\n_tags :_ *"..settings.lock_tag.."*\n_Join :_ *"..settings.lock_join.."*\n_flood :_ *"..settings.flood.."*\n_spam :_ *"..settings.lock_spam.."*\n_mention :_ *"..settings.lock_mention.."*\n_arabic :_ *"..settings.lock_arabic.."*\n_Lock webpage :_ *"..settings.lock_webpage.."*\n_markdown :_ *"..settings.lock_markdown.."*\n_welcome :_ *"..settings.welcome.."*\n_pin :_ *"..settings.lock_pin.."*\n_Bots :_ *"..settings.lock_bots.."*\n_Flood sensitivity :_ *"..NUM_MSG_MAX.."*\n_Character sensitivity :_ *"..SETCHAR.."*\n_Flood check time :_ *"..TIME_CHECK.."*\n*____________________*\n_Expire Date :_ *"..expire_date.."*\n*Bot channel*: \n*Group Language* : *EN*"
else
local settings = data[tostring(target)]["settings"] 
 text = "*💥تنظیمات قفلی گروه:*\n_ویرایش :_ *"..settings.lock_edit.."*\n_لینک :_ *"..settings.lock_link.."*\n_ورود :_ *"..settings.lock_join.."*\n_تگ :_ *"..settings.lock_tag.."*\n_فلود :_ *"..settings.flood.."*\n_اسپم :_ *"..settings.lock_spam.."*\n_فراخوانی :_ *"..settings.lock_mention.."*\n_عربی :_ *"..settings.lock_arabic.."*\n_صفحات وب :_ *"..settings.lock_webpage.."*\n _فونت :_ *"..settings.lock_markdown.."*\n _خوش امد :_ *"..settings.welcome.."*\n_سنجاق :_ *"..settings.lock_pin.."*\n_ربات :_ *"..settings.lock_bots.."*\n_حداکثر پیام مکرر :_ *"..NUM_MSG_MAX.."*\n_حداکثر حروف مجاز :_ *"..SETCHAR.."*\n_زمان بررسی پیام های مکرر :_ *"..TIME_CHECK.."*\n*____________________*\n_تاریخ انقضا :_ *"..expire_date.."*\n*کانال ما*: \n_زبان سوپرگروه_ : *FA*"
end
return text
end
--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "شما مدیر گروه نمیباشید"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "🔐" then 
if not lang then
return "💥*Mute Group* _Is Already Enabled_" 
elseif lang then
return "💥بیصدا کردن گروه فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "🔐"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Group* _Has Been Enabled_" 
else
return "💥بیصدا کردن گروه فعال شد"
end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "💥_You're Not_ *Moderator*" 
else
return "💥شما مدیر گروه نمیباشید"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "🔓" then 
if not lang then
return "💥*Mute Group* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن گروه غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Group* _Has Been Disabled_" 
else
return "💥بیصدا کردن همه گروه فعال شد"
end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "🔐" then
if not lang then
 return "💥*Mute Gif* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن تصاویر متحرک فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "💥*Mute Gif* _Has Been Enabled_"
else
 return "💥بیصدا کردن تصاویر متحرک فعال شد"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "🔓" then
if not lang then
return "💥*Mute Gif* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن تصاویر متحرک غیر فعال بود"
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Gif* _Has Been Disabled_" 
else
return "💥بیصدا کردن تصاویر متحرک غیر فعال شد"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "🔐" then
if not lang then
 return "💥*Mute Game* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن بازی های تحت وب فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_game"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Game* _Has Been Enabled_"
else
 return "💥بیصدا کردن بازی های تحت وب فعال شد"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "🔓" then
if not lang then
return "💥*Mute Game* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن بازی های تحت وب غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_game"] = "🔓"
 save_data(_config.moderation.data, data)
if not lang then 
return "💥*Mute Game* _Has Been Disabled_" 
else
return "💥بیصدا کردن بازی های تحت وب غیر فعال شد"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "🔐" then
if not lang then
 return "💥*Mute Inline* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن کیبورد شیشه ای فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Inline* _Has Been Enabled_"
else
 return "💥بیصدا کردن کیبورد شیشه ای فعال شد"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "🔓" then
if not lang then
return "💥*Mute Inline* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن کیبورد شیشه ای غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Inline* _Has Been Disabled_" 
else
return "💥بیصدا کردن کیبورد شیشه ای غیر فعال شد"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "🔐" then
if not lang then
 return "💥*Mute Text* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن متن فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_text"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Text* _Has Been Enabled_"
else
 return "💥بیصدا کردن متن فعال شد"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "🔓" then
if not lang then
return "💥*Mute Text* _Is Already Disabled_"
elseif lang then
return "💥بیصدا کردن متن غیر فعال است" 
end
else 
data[tostring(target)]["mutes"]["mute_text"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Text* _Has Been Disabled_" 
else
return "💥بیصدا کردن متن غیر فعال شد"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "🔐" then
if not lang then
 return "??*Mute Photo* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن عکس فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Photo* _Has Been Enabled_"
else
 return "💥بیصدا کردن عکس فعال شد"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "🔓" then
if not lang then
return "💥*Mute Photo* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن عکس غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Photo* _Has Been Disabled_" 
else
return "💥بیصدا کردن عکس غیر فعال شد"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "🔐" then
if not lang then
 return "💥*Mute Video* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن فیلم فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_video"] = "🔐" 
save_data(_config.moderation.data, data)
if not lang then 
 return "💥*Mute Video* _Has Been Enabled_"
else
 return "💥بیصدا کردن فیلم فعال شد"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "🔓" then
if not lang then
return "💥*Mute Video* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن فیلم غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_video"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Video* _Has Been Disabled_" 
else
return "💥بیصدا کردن فیلم غیر فعال شد"
end
end
end
---------------Mute Video_Note-------------------
local function mute_video_note(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_video_note = data[tostring(target)]["mutes"]["mute_video_note"] 
if mute_video == "🔐" then
if not lang then
 return "💥*Mute Video Note* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن فیلم سلفی فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_video_note"] = "🔐" 
save_data(_config.moderation.data, data)
if not lang then 
 return "💥*Mute Video Note* _Has Been Enabled_"
else
 return "💥بیصدا کردن فیلم سلفی فعال شد"
end
end
end

local function unmute_video_note(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_video_note = data[tostring(target)]["mutes"]["mute_video_note"]
 if mute_video == "🔓" then
if not lang then
return "💥*Mute Video Note* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن فیلم سلفی غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_video_note"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "*Mute Video Note* _Has Been Disabled_" 
else
return "بیصدا کردن فیلم سلفی غیر فعال شد"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "🔐" then
if not lang then
 return "💥*Mute Audio* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن آهنگ فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Audio* _Has Been Enabled_"
else 
return "💥بیصدا کردن آهنگ فعال شد"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "🔓" then
if not lang then
return "💥*Mute Audio* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن آهنک غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = "🔓"
 save_data(_config.moderation.data, data)
if not lang then 
return "💥*Mute Audio* _Has Been Disabled_"
else
return "💥بیصدا کردن آهنگ غیر فعال شد" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "🔐" then
if not lang then
 return "💥*Mute Voice* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن صدا فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Voice* _Has Been Enabled_"
else
 return "💥بیصدا کردن صدا فعال شد"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "🔓" then
if not lang then
return "💥*Mute Voice* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن صدا غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = "🔓"
 save_data(_config.moderation.data, data)
if not lang then 
return "💥*Mute Voice* _Has Been Disabled_" 
else
return "💥بیصدا کردن صدا غیر فعال شد"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "🔐" then
if not lang then
 return "💥*Mute Sticker* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن برچسب فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Sticker* _Has Been Enabled_"
else
 return "💥بیصدا کردن برچسب فعال شد"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end 
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "🔓" then
if not lang then
return "💥*Mute Sticker* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن برچسب غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = "??"
 save_data(_config.moderation.data, data)
if not lang then 
return "💥*Mute Sticker* _Has Been Disabled_"
else
return "💥بیصدا کردن برچسب غیر فعال شد"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "🔐" then
if not lang then
 return "💥*Mute Contact* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن مخاطب فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Contact* _Has Been Enabled_"
else
 return "💥بیصدا کردن مخاطب فعال شد"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "🔓" then
if not lang then
return "💥*Mute Contact* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن مخاطب غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Contact* _Has Been Disabled_" 
else
return "💥بیصدا کردن مخاطب غیر فعال شد"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "🔐" then
if not lang then
 return "💥*Mute Forward* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن نقل قول فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Forward* _Has Been Enabled_"
else
 return "💥بیصدا کردن نقل قول فعال شد"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "🔓" then
if not lang then
return "💥*Mute Forward* _Is Already Disabled_"
elseif lang then
return "💥بیصدا کردن نقل قول غیر فعال است"
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = "🔓"
 save_data(_config.moderation.data, data)
if not lang then 
return "💥*Mute Forward* _Has Been Disabled_" 
else
return "💥بیصدا کردن نقل قول غیر فعال شد"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "🔐" then
if not lang then
 return "💥*Mute Location* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن موقعیت فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_location"] = "🔐" 
save_data(_config.moderation.data, data)
if not lang then
 return "💥*Mute Location* _Has Been Enabled_"
else
 return "💥بیصدا کردن موقعیت فعال شد"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "🔓" then
if not lang then
return "💥*Mute Location* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن موقعیت غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_location"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Location* _Has Been Disabled_" 
else
return "💥بیصدا کردن موقعیت غیر فعال شد"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "🔐" then
if not lang then
 return "💥*Mute Document* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن اسناد فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_document"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Document* _Has Been Enabled_"
else
 return "بیصدا کردن اسناد فعال شد"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نمیباشید"
end
end 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "🔓" then
if not lang then
return "💥*Mute Document* _Is Already Disabled_" 
elseif lang then
return "💥بیصدا کردن اسناد غیر فعال است"
end
else 
data[tostring(target)]["mutes"]["mute_document"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Document* _Has Been Disabled_" 
else
return "💥بیصدا کردن اسناد غیر فعال شد"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "🔐" then
if not lang then
 return "💥*Mute TgService* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن خدمات تلگرام فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute TgService* _Has Been Enabled_"
else
return "💥بیصدا کردن خدمات تلگرام فعال شد"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نیستید"
end 
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "🔓" then
if not lang then
return "💥*Mute TgService* _Is Already Disabled_"
elseif lang then
return "💥بیصدا کردن خدمات تلگرام غیر فعال است"
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute TgService* _Has Been Disabled_"
else
return "💥بیصدا کردن خدمات تلگرام غیر فعال شد"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "💥_You're Not_ *Moderator*"
else
 return "💥شما مدیر گروه نمیباشید"
end
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "🔐" then
if not lang then
 return "💥*Mute Keyboard* _Is Already Enabled_"
elseif lang then
 return "💥بیصدا کردن صفحه کلید فعال است"
end
else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "🔐" 
save_data(_config.moderation.data, data) 
if not lang then
 return "💥*Mute Keyboard* _Has Been Enabled_"
else
return "💥بیصدا کردن صفحه کلید فعال شد"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "💥_You're Not_ *Moderator*"
else
return "💥شما مدیر گروه نیستید"
end 
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "🔓" then
if not lang then
return "💥*Mute Keyboard* _Is Already Disabled_"
elseif lang then
return "💥بیصدا کردن صفحه کلید غیرفعال است"
end 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "🔓"
 save_data(_config.moderation.data, data) 
if not lang then
return "💥*Mute Keyboard* _Has Been Disabled_"
else
return "💥بیصدا کردن صفحه کلید غیرفعال شد"
end 
end
end
----------MuteList---------
local function mutes(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "💥_You're Not_ *Moderator*"	
else
 return "💥شما مدیر گروه نیستید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_all"] then			
data[tostring(target)]["mutes"]["mute_all"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video_note"] then			
data[tostring(target)]["mutes"]["mute_video_note"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "🔓"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "🔓"		
end
end
if not lang then
local mutes = data[tostring(target)]["mutes"] 
 text = " *💥Group Media Settings* : \n_group : _ *"..mutes.mute_all.."*\n_gif :_ *"..mutes.mute_gif.."*\n_text :_ *"..mutes.mute_text.."*\n_inline :_ *"..mutes.mute_inline.."*\n_game :_ *"..mutes.mute_game.."*\n_photo :_ *"..mutes.mute_photo.."*\n_video :_ *"..mutes.mute_video.."*\n_audio :_ *"..mutes.mute_audio.."*\n_voice :_ *"..mutes.mute_voice.."*\n_sticker :_ *"..mutes.mute_sticker.."*\n_contact :_ *"..mutes.mute_contact.."*\n_forward :_ *"..mutes.mute_forward.."*\n_location :_ *"..mutes.mute_location.."*\n_document :_ *"..mutes.mute_document.."*\n_tgService :_ *"..mutes.mute_tgservice.."*\n_keyboard :_ *"..mutes.mute_keyboard.."*\n_video note :_ *"..mutes.mute_video_note.."*\n *____________________*\n*Bot channel*: \n*Group Language* : *EN*"
else
local mutes = data[tostring(target)]["mutes"] 
 text = " *💥تنظیمات رسانه گروه* : \n_گروه : _ *"..mutes.mute_all.."*\n_گیف :_ *"..mutes.mute_gif.."*\n_متن :_ *"..mutes.mute_text.."*\n_اینلاین :_ *"..mutes.mute_inline.."*\n_بازی :_ *"..mutes.mute_game.."*\n_عکس :_ *"..mutes.mute_photo.."*\n_ویدیو :_ *"..mutes.mute_video.."*\n_آهنگ :_ *"..mutes.mute_audio.."*\n_ویس :_ *"..mutes.mute_voice.."*\n_استیکر :_ *"..mutes.mute_sticker.."*\n_مخاطب :_ *"..mutes.mute_contact.."*\n_فوروارد :_ *"..mutes.mute_forward.."*\n_موقعیت :_ *"..mutes.mute_location.."*\n_فایل :_ *"..mutes.mute_document.."*\n_سرویس :_ *"..mutes.mute_tgservice.."*\n_کیبورد :_ *"..mutes.mute_keyboard.."*\n_فیلم سلفی :_ *"..mutes.mute_video_note.."*\n*____________________*\n*کانال ما*: @BeyondTeam\n_زبان سوپرگروه_ : *FA*"
end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
local data = load_data(_config.moderation.data)
local chat = msg.chat_id
local user = msg.sender_user_id
-- if msg.to.type ~= 'pv' then
if ((matches[1] == "add" and not Clang) or (matches[1] == "نصب" and Clang)) then
return modadd(msg)
end
if ((matches[1] == "rem" and not Clang) or (matches[1] == "لغو نصب" and Clang)) then
return modrem(msg)
end
if not data[tostring(msg.chat_id)] then return end
if (matches[1] == "id" and not Clang) or (matches[1] == "ایدی" and Clang) or (matches[1] == "آیدی" and Clang) then
print('OK')
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
-- vardump(data)
   if data.photos[0] then
       if not lang then
        tdbot.sendPhoto(msg.to.id, msg.id, data.photos[0].sizes[1].photo.persistent_id, 0, {}, 0, 0, 'Gp ID : '..msg.to.id..'\nUser ID : '..msg.from.id, 0, 0, 1, nil, dl_cb, nil)
       elseif lang then
        tdbot.sendPhoto(msg.to.id, msg.id, data.photos[0].sizes[1].photo.persistent_id, 0, {}, 0, 0, 'یوزرنیم گپ : '..msg.to.id..'\nیوزرنیم شما : '..msg.from.id, 0, 0, 1, nil, dl_cb, nil)
     end
   else
       if not lang then
      tdbot.sendMessage(msg.to.id, msg.id, 1, "💥`You Have Not Profile Photo...!`\n\n> *Gp ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdbot.sendMessage(msg.to.id, msg.id, 1, "💥_شما هیچ عکسی ندارید...!_\n\n> _یوزرنیم گپ :_ `"..msg.to.id.."`\n_یوزرنیم شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   assert(tdbot_function ({
    _ = "getUserProfilePhotos",
    user_id = msg.sender_user_id,
    offset = 0,
    limit = 1
  }, getpro, nil))
end
if tonumber(msg.reply_to_message_id) ~= 0 and not matches[2] and is_mod(msg) then
    assert(tdbot_function ({
      _ = "getMessage",
      chat_id = msg.chat_id,
      message_id = msg.reply_to_message_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"}))
  end
if matches[2] and is_mod(msg) then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if ((matches[1] == "pin" and not Clang) or (matches[1] == "سنجاق" and Clang)) and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '🔓' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
if not lang then
return "💥*Message Has Been Pinned*\nChannel:\n"
elseif lang then
return "💥پیام سجاق شد\n     \n"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == '🔓' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
if not lang then
return "💥*Message Has Been Pinned*\nChannel:\n"
elseif lang then
return "💥پیام سجاق شد\n     \n"
end
end
end
if ((matches[1] == 'unpin' and not Clang) or (matches[1] == "حذف سنجاق" and Clang)) and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '🔓' then
if is_owner(msg) then
tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
if not lang then
return "💥*Pin message has been unpinned*\nChannel:\n"
elseif lang then
return "💥پیام سنجاق شده پاک شد\n     \n"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == '🔓' then
tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
if not lang then
return "💥*Pin message has been unpinned*\nChannel:\n"
elseif lang then
return "💥پیام سنجاق شده پاک شد\n     \n"
end
end
end
if ((matches[1]:lower() == "vip" and not Clang) or (matches[1] == "ویژه" and Clang)) and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if ((matches[1]:lower() == "vips" and not Clang) or (matches[1] == "ویژه ها" and Clang)) and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if ((matches[1] == "setowner" and not Clang) or (matches[1] == 'تنظیم صاحب' and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if ((matches[1] == "remowner" and not Clang) or (matches[1] == "حذف صاحب" and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if ((matches[1] == "promote" and not Clang) or (matches[1] == "تنظیم مدیر" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if ((matches[1] == "demote" and not Clang) or (matches[1] == "حذف مدیر" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if ((matches[1] == "lock" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "لینک" and Clang)) then
return lock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "تگ" and Clang)) then
return lock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "فراخوانی" and Clang)) then
return lock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "عربی" and Clang)) then
return lock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "ویرایش" and Clang)) then
return lock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "اسپم" and Clang)) then
return lock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "فلود" and Clang)) then
return lock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "ربات" and Clang)) then
return lock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "فونت" and Clang)) then
return lock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "وب" and Clang)) then
return lock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "سنجاق" and Clang)) and is_owner(msg) then
return lock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "جوین" and Clang)) then
return lock_join(msg, data, target)
end
end

if ((matches[1] == "unlock" and not Clang) or (matches[1] == "بازکردن" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "لینک" and Clang)) then
return unlock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "تگ" and Clang)) then
return unlock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "فراخوانی" and Clang)) then
return unlock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "عربی" and Clang)) then
return unlock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "ویرایش" and Clang)) then
return unlock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "اسپم" and Clang)) then
return unlock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "فلود" and Clang)) then
return unlock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "ربات" and Clang)) then
return unlock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "فونت" and Clang)) then
return unlock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "وب" and Clang)) then
return unlock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "سنجاق" and Clang)) and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "جوین" and Clang)) then
return unlock_join(msg, data, target)
end
end
if ((matches[1] == "mute" and not Clang) or (matches[1] == "بیصدا" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "group" and not Clang) or (matches[2] == "گروه" and Clang)) then
return mute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "گیف" and Clang)) then
return mute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "متن" and Clang)) then
return mute_text(msg ,data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "عکس" and Clang)) then
return mute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "فیلم" and Clang)) then
return mute_video(msg ,data, target)
end
if ((matches[2] == "video_note" and not Clang) or (matches[2] == "فیلم سلفی" and Clang)) then
return mute_video_note(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "اهنگ" and Clang)) then
return mute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "صدا" and Clang)) then
return mute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "استیکر" and Clang)) then
return mute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "مخاطب" and Clang)) then
return mute_contact(msg ,data, target)
end
if ((matches[2] == "forward" and not Clang) or (matches[2] == "فوروارد" and Clang)) then
return mute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "موقعیت" and Clang)) then
return mute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "فایل" and Clang)) then
return mute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "سرویس" and Clang)) then
return mute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "اینلاین" and Clang)) then
return mute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "بازی" and Clang)) then
return mute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "کیبورد" and Clang)) then
return mute_keyboard(msg ,data, target)
end
end

if ((matches[1] == "unmute" and not Clang) or (matches[1] == "باصدا" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "group" and not Clang) or (matches[2] == "گروه" and Clang)) then
return unmute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "گیف" and Clang)) then
return unmute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "متن" and Clang)) then
return unmute_text(msg, data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "عکس" and Clang)) then
return unmute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "فیلم" and Clang)) then
return unmute_video(msg ,data, target)
end
if ((matches[2] == "video_note" and not Clang) or (matches[2] == "فیلم سلفی" and Clang)) then
return unmute_video_note(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "اهنگ" and Clang)) then
return unmute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "صدا" and Clang)) then
return unmute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "استیکر" and Clang)) then
return unmute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "مخاطب" and Clang)) then
return unmute_contact(msg ,data, target)
end
if ((matches[2] == "forward" and not Clang) or (matches[2] == "فوروارد" and Clang)) then
return unmute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "موقعیت" and Clang)) then
return unmute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "فایل" and Clang)) then
return unmute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "سرویس" and Clang)) then
return unmute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "اینلاین" and Clang)) then
return unmute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "بازی" and Clang)) then
return unmute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "کیبورد" and Clang)) then
return unmute_keyboard(msg ,data, target)
end
end
if ((matches[1] == "gpinfo" and not Clang) or (matches[1] == "اطلاعات گروه" and Clang)) and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "💥*Group Info :*\n_Admin Count :_ *"..data.administrator_count.."*\n_Member Count :_ *"..data.member_count.."*\n_Kicked Count :_ *"..data.kicked_count.."*\n_Group ID :_ *"..data.channel.id.."*\nChannel:\n"
-- print(serpent.block(data))
elseif lang then
ginfo = "*💥اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count.."*\n_تعداد اعضا :_ *"..data.member_count.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count.."*\n_شناسه گروه :_ *"..data.channel.id.."*\n     \n"
-- print(serpent.block(data))
end
        tdbot.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdbot.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if ((matches[1] == 'newlink' and not Clang) or (matches[1] == "لینک جدید" and Clang)) and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "💥_Bot is not group creator_\n_set a link for group with using_ /setlink\nChannel:\n"..msg_caption, 1, 'md')
       elseif lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "💥_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_\n     \n"..msg_caption, 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "💥*Newlink Created*\nChannel:\n", 1, 'md')
        elseif lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "_💥لینک جدید ساخته شد_\n     \n", 1, 'md')
            end
				end
			end
 tdbot.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if ((matches[1] == 'setlink' and not Clang) or (matches[1] == "تنظیم لینک" and Clang)) and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '💥_Please send the new group_ *link* _now_\nChannel:\n'
    else 
         return '💥لطفا لینک گروه خود را ارسال کنید\n     \n'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "💥*Newlink* _has been set_\nChannel:\n"
           else
           return "💥لینک جدید ذخیره شد\n     \n"
		 	end
       end
		end
    if ((matches[1] == 'link' and not Clang) or (matches[1] == "لینک" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "💥_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink\nChannel:\n"
     else
        return "💥ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید\n     \n"
      end
      end
     if not lang then
       text = "<b>💥Group Link :</b>\n"..linkgp..msg_caption
     else
      text = "<b>💥لینک گروه :</b>\n"..linkgp..msg_caption
         end
        return tdbot.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if ((matches[1] == 'linkpv' and not Clang) or (matches[1] == "لینک خصوصی" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "💥_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink\nChannel:\n"
     else
        return "💥ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید\n     \n"
      end
      end
     if not lang then
     tdbot.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
     else
      tdbot.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
         end
      if not lang then
        return "💥*Group Link Was Send In Your Private Message*\nChannel:\n"
       else
        return "💥_لینک گروه به چت خصوصی شما ارسال شد_\n     \n"
        end
     end
  if ((matches[1] == "setrules" and not Clang) or (matches[1] == "تنظیم قوانین" and Clang)) and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "💥*Group rules* _has been set_\nChannel:\n"
   else 
  return "💥قوانین گروه ثبت شد\n     \n"
   end
  end
  if ((matches[1] == "rules" and not Clang) or (matches[1] == "قوانین" and Clang)) then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "💥ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\nChannel:\n"..msg_caption
    elseif lang then
       rules = "💥ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n     \n"..msg_caption
 end
        else
     rules = "💥*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if ((matches[1] == "port1" and not Clang) or (matches[1] == "درگاه1" and Clang)) then
   if not lang then
     return "💥*1 month payday payment:*\nhttps://idpay.ir/RADICALBOT/80000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
    elseif lang then
       return "💥درگاه پرداخت 1 ماهه:\nhttps://idpay.ir/RADICALBOT/80000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`     `"..msg_caption
 end
 end
if ((matches[1] == "port2" and not Clang) or (matches[1] == "درگاه2" and Clang)) then
   if not lang then
     return "💥*2 month payday payment:*\nhttps://idpay.ir/RADICALBOT/150000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
    elseif lang then
       return "💥درگاه پرداخت 2 ماهه:\nhttps://idpay.ir/RADICALBOT/150000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`     `"..msg_caption
 end
 end
if ((matches[1] == "port3" and not Clang) or (matches[1] == "درگاه3" and Clang)) then
   if not lang then
     return "💥*3 month payday payment:*\nhttps://idpay.ir/RADICALBOT/200000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
    elseif lang then
       return "💥درگاه پرداخت 3 ماهه:\nhttps://idpay.ir/RADICALBOT/200000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`     `"..msg_caption
 end
 end
 if ((matches[1] == "port4" and not Clang) or (matches[1] == "درگاه4" and Clang)) then
   if not lang then
     return "💥*4 month payday payment:*\nhttps://idpay.ir/RADICALBOT/250000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
    elseif lang then
       return "💥درگاه پرداخت 4 ماهه:\nhttps://idpay.ir/RADICALBOT/250000\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`     `"..msg_caption
 end
 end
if ((matches[1] == "portall" and not Clang) or (matches[1] == "لیست درگاه" and Clang)) then
   if not lang then
     return "💥*RADICALBOT List of Paid Ports*\n\n`💥1 month payday payment:`\nhttps://idpay.ir/RADICALBOT/80000\n\n`💥2 month payday payment:`\nhttps://idpay.ir/RADICALBOT/150000\n\n`💥3 month payday payment:`\nhttps://idpay.ir/RADICALBOT/200000\n\n`💥4 month payday payment:`\nhttps://idpay.ir/RADICALBOT/250000\n\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
    elseif lang then
       return "💥لیست درگاه های پرداخت (رادیڪال بوت)\n\n`💥درگاه پرداخت 1 ماهه:`\nhttps://idpay.ir/RADICALBOT/80000\n\n`💥درگاه پرداخت 2 ماهه:`\nhttps://idpay.ir/RADICALBOT/150000\n\n`💥درگاه پرداخت 3 ماهه:`\nhttps://idpay.ir/RADICALBOT/200000\n\n`💥درگاه پرداخت 4 ماهه:`\nhttps://idpay.ir/RADICALBOT/250000\n\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
 end
 end
 if ((matches[1] == "card number" and not Clang) or (matches[1] == "شماره کارت" and Clang)) then
   if not lang then
     return "💥Card number to buy a robot (mega plus) \n\n *6037701661044351*\n`Ghasmi`\n`Bank post`\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`Channel:`"..msg_caption
    elseif lang then
       return "💥شماره کارت جهت خرید ربات (رادیڪال بوت)\n\n*6037701661044351*\n`قاسمی`\n`پست بانک`\nلطفا عکس را به ایدی زیر ارسال کنید\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n`     `"..msg_caption
 end
 end
if (matches[1] == 'update' or matches[1] == "اپدیت") and is_sudo(msg) then
   if not lang then
     return "💥The RADICALBOT Robot was upgraded\nCurrent version: *3.0*\nnew version: *Not available*\nBy:\n@SudoRadical\n\n`Channel:`"..msg_caption
    elseif lang then
       return "💥ربات (رادیڪال بوت) اپدیت شد\nورژن فعلی: *3.0*\nورژن جدید: در دسترس نیست\nتوسعه دهنده:\n@SudoRadical\n\n`     `"..msg_caption
 end
 end
 if ((matches[1] == "botrules" and not Clang) or (matches[1] == "قوانین ربات" and Clang)) then
   if not lang then
     return "💥قوانین ربات (رادیڪال بوت)\n\n*1*`.حذف کردن ربات به هر بهانه مورد قبول نیست و برای نصب دوباره مبلغ 5000هزار تومان کسر میشود`\n\n*2*`.خرید ربات از هر شخصی جز` \n[ @SudoRadical ] \n`به تیم ما ربطی ندارد`\n\n*3*`.پاک شدن گروه شما با فیلتر شدن ان به ما ربطی ندارد و باید ربات دوباره خریداری شود`\n\nروز خوبی داشته باشید با رادیڪال بوت تیم\n\n`توسعه دهنده:`\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n\n`Channel`:"..msg_caption
    elseif lang then
       return "💥قوانین ربات (رادیڪال بوت)\n\n*1*`.حذف کردن ربات به هر بهانه مورد قبول نیست و برای نصب دوباره مبلغ 5000هزار تومان کسر میشود`\n\n*2*`.خرید ربات از هر شخصی جز`\n[ @SudoRadical ]\n`به تیم ما ربطی ندارد`\n\n*3*`.پاک شدن گروه شما با فیلتر شدن ان به ما ربطی ندارد و باید ربات دوباره خریداری شود`\n\nروز خوبی داشته باشید با رادیڪال بوت تیم\n\n`توسعه دهنده:`\n@SudoRadical\n@SudoRadical\n@sudoradicalbot\n\n`کانال ما`:"..msg_caption
 end
 end
if (matches[1] == 'creator' or matches[1] == "سازنده") and is_sudo(msg) then
   if not lang then
     return "💥*Educated and written by* \n@SudoRadical\n\n`Channel:`"..msg_caption
    elseif lang then
       return "💥نوشته شده توسط:\n@SudoRadical\n@SudoRadicalBot\n`     `"..msg_caption
 end
 end
 if ((matches[1] == "ping" and not Clang) or (matches[1] == "پینگ" and Clang)) then
   if not lang then
     return "💥*RADICALBOT Bot Hes Online*\n`Channel:`"..msg_caption
    elseif lang then
       return "💥*ربات (رادیڪال بوت) هم اکنون انلاین است*\n`     `"..msg_caption
 end
 end
if (matches[1] == 'version' or matches[1] == "ورژن") and is_sudo(msg) then
   if not lang then
     return "💥*Robot Specification (RadicalBot)*\n\n`Robot Version:` *TDBOT v ( 3.0 )*\n\n`Developer:`\n@SudoRadical\n\n\n`Bot rules are enabled with the `*( BotRules )* `command`\n\n`Channel:`"..msg_caption
    elseif lang then
       return "💥مشخصات ربات\n(رادیڪال بوت)\n\n`ورژن ربات: `*TDBOT v( 3.0 )*\n\n`توسعه دهنده:`\n@SudoRadical\n\n\n`دیدن قوانین ربات با دستور ( قوانین ربات ) میسر میشود`\n\n`     `"..msg_caption
 end
 end
 if ((matches[1] == "nerkh" and not Clang) or (matches[1] == "نرخ" and Clang)) then
   if not lang then
     return "💵 *Nerkh RADICALBOT Bot*\n\n💥️ *For All Group*\n\n`💥️1 month 8 Toman `\n`💥️2 month 15 Toman`\n`💥️3 month 20 Toman`\n`💥️4 month 25 Toman`\n\n🔹 نکته مهم :\n\n`➖توجه داشته باشید ربات ما بدلیل سرعت بالا و امکانات فراوان ربات دائمی نداریم\n\n`جهت خرید اینترنتی *[ help6 ]* و خرید کارت به کارت *[ card number ]* را ارسال کنید\n`Channel:`"..msg_caption
    elseif lang then
       return "💵 نرخ ربات (رادیڪال بوت) \n\n💥️ برای تمام گروه ها‌\n\n`💥️1 ماهه8هزار تومان `\n`💥️2 ماهه15هزار تومان`\n`💥️3 ماهه20هزار تومان`\n`💥️4 ماهه25هزار تومان`\n\n🔹 نکته مهم :\n\n`➖توجه داشته باشید ربات ما بدلیل سرعت بالا و امکانات فراوان ربات دائمی نداریم\n\n`جهت خرید اینترنتی  `[ لیست درگاه ]` و کارت به کارت [ شماره کارت ] را ارسال کنید\n\n`     `"..msg_caption
 end
 end
if ((matches[1] == "res" and not Clang) or (matches[1] == "کاربری" and Clang)) and matches[2] and is_mod(msg) then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if ((matches[1] == "whois" and not Clang) or (matches[1] == "شناسه" and Clang)) and matches[2] and is_mod(msg) then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if ((matches[1]:lower() == 'setchar' and not Clang) or (matches[1] == "حداکثر حروف مجاز" and Clang)) then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "💥*Character sensitivity* _has been set to :_ *[ "..matches[2].." ]*\nChannel:\n"
   else
     return "💥_حداکثر حروف مجاز در پیام تنظیم شد به :_ *[ "..matches[2].." ]*\n     \n"
		end
  end
  if ((matches[1]:lower() == 'setflood' and not Clang) or (matches[1] == "تنظیم پیام مکرر" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "💥_Wrong number, range is_ *[2-50]*\nChannel:\n"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "💥_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*\nChannel:\n"
    else
    return '💥_محدودیت پیام مکرر به_ *'..tonumber(matches[2])..'* _تنظیم شد._\n     \n'
    end
       end
  if ((matches[1]:lower() == 'setfloodtime' and not Clang) or (matches[1] == "تنظیم زمان بررسی" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "💥_Wrong number, range is_ *[2-10]*\nChannel:\n"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "💥_Group_ *flood* _check time has been set to :_ *[ "..matches[2].." ]*\nChannel:\n"
    else
    return "💥_حداکثر زمان بررسی پیام های مکرر تنظیم شد به :_ *[ "..matches[2].." ]*\n     \n"
    end
       end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "پاکسازی" and Clang)) and is_owner(msg) then
			if ((matches[2] == 'mods' and not Clang) or (matches[2] == "مدیر ها" and Clang)) then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "💥_No_ *moderators* _in this group_\nChannel:\n"
             else
                return "💥هیچ مدیری برای گروه انتخاب نشده است\n     \n"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "💥_All_ *moderators* _has been demoted_\nChannel:\n"
          else
            return "💥تمام مدیران گروه تنزیل مقام شدند\n     \n"
			end
         end
			if ((matches[2] == 'filters' and not Clang) or (matches[2] == "فیلتر ها" and Clang)) then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "💥*Filtered words list* _is empty_\nChannel:\n"
         else
					return "_💥لیست کلمات فیلتر شده خالی است_\n     \n"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "💥*Filtered words list* _has been cleaned_\nChannel:\n"
           else
				return "_💥لیست کلمات فیلتر شده پاک شد_\n     \n"
           end
			end
			if ((matches[2] == 'rules' and not Clang) or (matches[2] == "قوانین" and Clang)) then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "💥_No_ *rules* _available_\nChannel:\n"
             else
               return "💥قوانین برای گروه ثبت نشده است\n     \n"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "💥*Group rules* _has been cleaned_\nChannel:\n"
          else
            return "💥قوانین گروه پاک شد\n     \n"
			end
       end
			if ((matches[2] == 'welcome' and not Clang) or (matches[2] == "خوشامد" and Clang)) then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "💥*Welcome Message not set*\nChannel:\n"
             else
               return "💥پیام خوشآمد گویی ثبت نشده است\n     \n"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "💥*Welcome message* _has been cleaned_\nChannel:\n"
          else
            return "💥پیام خوشآمد گویی پاک شد\n     \n"
			end
       end
			if ((matches[2] == 'about' and not Clang) or (matches[2] == "درباره" and Clang)) then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "💥_No_ *description* _available_\nChannel:\n"
            else
              return "💥پیامی مبنی بر درباره گروه ثبت نشده است\n     \n"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdbot.changeChannelDescription(chat, "", dl_cb, nil)
             end
             if not lang then
				return "💥*Group description* _has been cleaned_\nChannel:\n"
           else
              return "💥پیام مبنی بر درباره گروه پاک شد\n     \n"
             end
		   	end
        end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "پاکسازی" and Clang)) and is_admin(msg) then
			if ((matches[2] == 'owners' and not Clang) or (matches[2] == "صاحب ها" and Clang)) then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "💥_No_ *owners* _in this group_\nChannel:\n"
            else
                return "💥مالکی برای گروه انتخاب نشده است\n     \n"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "💥_All_ *owners* _has been demoted_\nChannel:\n"
           else
            return "💥تمامی مالکان گروه تنزیل مقام شدند\n     \n"
          end
			end
     end
if ((matches[1] == "setname" and not Clang) or (matches[1] == "تنظیم نام" and Clang)) and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdbot.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if ((matches[1] == "setabout" and not Clang) or (matches[1] == "تنظیم درباره" and Clang)) and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdbot.changeChannelDescription(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "💥*Group description* _has been set_\nChannel:\n"
    else
     return "💥پیام مبنی بر درباره گروه ثبت شد\n     \n"
      end
  end
  if ((matches[1] == "about" and not Clang) or (matches[1] == "درباره" and Clang)) and msg.to.type == "chat" and is_owner(msg) then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "💥_No_ *description* _available_\nChannel:\n"
      elseif lang then
      about = "💥پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "💥*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if ((matches[1] == 'filter' and not Clang) or (matches[1] == "فیلتر" and Clang)) and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if ((matches[1] == 'unfilter' and not Clang) or (matches[1] == "حذف فیلتر" and Clang)) and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if ((matches[1] == 'filters' and not Clang) or (matches[1] == "فیلتر ها" and Clang)) and is_mod(msg) then
    return filter_list(msg)
  end
if ((matches[1] == "settings1" and not Clang) or (matches[1] == "تنظیمات1" and Clang)) and is_mod(msg) then
return group_settings(msg, target)
end
if ((matches[1] == "settings2" and not Clang) or (matches[1] == "تنظیمات2" and Clang)) and is_mod(msg) then
return mutes(msg, target)
end
if ((matches[1] == "mods" and not Clang) or (matches[1] == "مدیر ها" and Clang)) and is_mod(msg) then
return modlist(msg)
end
if ((matches[1] == "owners" and not Clang) or (matches[1] == "صاحب ها" and Clang)) and is_owner(msg) then
return ownerlist(msg)
end
if ((matches[1] == "vips" and not Clang) or (matches[1] == "ویژه ها" and Clang)) and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if ((matches[1]:lower() == "menu" and not Clang) or (matches[1] == "منو" and Clang)) and is_mod(msg) then
local function found_helper(TM, Beyond)
local function inline_query_cb(TM, BD)
      if BD.results and BD.results[0] then
		redis:setex("ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true)	tdbot.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, BD.inline_query_id, BD.results[0].id, dl_cb, nil)
    else
    if not lang then
    text = "*💥Helper is offline*\nChannel:\n"
        elseif lang then
    text = "_💥ربات هلپر خاموش است_\n     \n"
    end
  return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdbot.getInlineQueryResults(Beyond.id, msg.to.id, nil, nil, msg.to.id, 0, inline_query_cb, nil)
end
tdbot.searchPublicChat(tostring(helper_username), found_helper, nil)
end

if (matches[1]:lower() == "setlang" and not Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "fa" then
redis:set(hash, true)
return "💥*زبان گروه تنظیم شد به : فارسی*\n     \n"..msg_caption
  elseif matches[2] == "en" then
 redis:del(hash)
return "💥_Group Language Set To:_ EN\nChannel:\n"..msg_caption
end
end
if (matches[1] == 'زبان' and Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "فارسی" then
redis:set(hash, true)
return "💥*زبان گروه تنظیم شد به : فارسی*\n     \n"..msg_caption
  elseif matches[2] == "انگلیسی" then
 redis:del(hash)
return "💥_Group Language Set To:_ EN\nChannel:\n"..msg_caption
end
end

if (matches[1]:lower() == "setcmd" and not Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
if matches[2] == "fa" then
redis:set(hash, true)
   if lang then
return "💥*زبان دستورات ربات تنظیم شد به : فارسی*\n     \n"..msg_caption
else
return "💥_Bot Commands Language Set To:_ Fa\nChannel:\n"..msg_caption
end
end
end

if (matches[1]:lower() == "دستورات انگلیسی" and Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
redis:del(hash)
   if lang then
return "💥*زبان دستورات ربات تنظیم شد به : انگلیسی*\n     \n"..msg_caption
else
return "💥_Bot Commands Language Set To:_ EN\nChannel:\n"..msg_caption
end
end

--------------------- Welcome -----------------------
	if ((matches[1] == "welcome" and not Clang) or (matches[1] == "خوشامد" and Clang)) and is_mod(msg) then
		if ((matches[2] == "+" and not Clang) or (matches[2] == "+" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "🔐" then
       if not lang then
				return "💥_Group_ *welcome* _is already enabled_\nChannel:\n"
       elseif lang then
				return "💥_خوشآمد گویی از قبل فعال بود_\n     \n"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "🔐"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "💥_Group_ *welcome* _has been enabled_\nChannel:\n"
       elseif lang then
				return "💥_خوشآمد گویی فعال شد_\n     \n"
          end
			end
		end
		
		if ((matches[2] == "-" and not Clang) or (matches[2] == "-" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "🔓" then
      if not lang then
				return "💥_Group_ *Welcome* _is already disabled_\nChannel:\n"
      elseif lang then
				return "💥_خوشآمد گویی از قبل فعال نبود_\n     \n"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "🔓"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "💥_Group_ *welcome* _has been disabled_\nChannel:\n"
      elseif lang then
				return "💥_خوشآمد گویی غیرفعال شد_\n     \n"
          end
			end
		end
	end
	if ((matches[1] == "setwelcome" and not Clang) or (matches[1] == "تنظیم خوشامد" and Clang)) and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_💥Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{time} ➣ Show time english _\n_{date} ➣ Show date english _\n_{timefa} ➣ Show time persian _\n_{datefa} ➣ show date persian _\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"..msg_caption
       else
		return "_💥پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"..msg_caption
        end
     end
	-- end
end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdbot.getChannelMembers(msg.to.id, 0, 200, 'Administrators', function(a, b)
	local secchk = true
		for k,v in pairs(b.members) do
			if v.user_id == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdbot.sendMessage(msg.to.id, 0, 1, '_Robot isn\'t Administrator, Please promote to Admin!_', 1, "md")
			else
				return tdbot.sendMessage(msg.to.id, 0, 1, '_💥لطفا برای کارکرد کامل دستورات، ربات را به مدیر گروه ارتقا دهید._\n     \n', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://api.beyond-dev.ir/time/')
          if res ~= 200 then return "💥No connection\nChannel:\n" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*💥Welcome Dude*\nChannel:\n"
    elseif lang then
     welcome = "_💥خوش آمدید_\n     \n"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "💥ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\nChannel:\n"
    elseif lang then
       rules = "💥ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n      \n"
 end
end
if data.username then
user_name = "@"..check_markdown(data.username)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name..' '..(data.last_name or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdbot.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "🔐" then
			tdbot.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "🔐" then
			tdbot.getUser(msg.sender_user_id, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
 
return {
patterns ={
"^[!/#](id)$",
"^(id)$",
"^[!/#](id) (.*)$",
"^(id) (.*)$",
"^[!/#](pin)$",
"^(pin)$",
"^[!/#](unpin)$",
"^(unpin)$",
"^[!/#](gpinfo)$",
"^(gpinfo)$",
"^[!/#](test)$",
"^(test)$",
"^[!/#](add)$",
"^(add)$",
"^[!/#](rem)$",
"^(rem)$",
"^[!/#](menu)$",
"^(menu)$",
"^[!/#](vip) ([+-])$",
"^(vip) ([+-])$",
"^[!/#](vip) ([+-]) (.*)$",
"^(vip) ([+-]) (.*)$",
"^[#!/](vips)$",
"^(vips)$",
"^[!/#](setowner)$",
"^(setowner)$",
"^[!/#](setowner) (.*)$",
"^(setowner) (.*)$",
"^[!/#](remowner)$",
"^(remowner)$",
"^[!/#](remowner) (.*)$",
"^(remowner) (.*)$",
"^[!/#](promote)$",
"^(promote)$",
"^[!/#](promote) (.*)$",
"^(promote) (.*)$",
"^[!/#](demote)$",
"^(demote)$",
"^[!/#](demote) (.*)$",
"^(demote) (.*)$",
"^[!/#](mods)$",
"^(mods)$",
"^[!/#](owners)$",
"^(owners)$",
"^[!/#](lock) (.*)$",
"^(lock) (.*)$",
"^[!/#](unlock) (.*)$",
"^(unlock) (.*)$",
"^[!/#](settings1)$",
"^(settings1)$",
"^[!/#](settings2)$",
"^(settings2)$",
"^[!/#](mute) (.*)$",
"^(mute) (.*)$",
"^[!/#](unmute) (.*)$",
"^(unmute) (.*)$",
"^[!/#](link)$",
"^(link)$",
"^[!/#](linkpv)$",
"^(linkpv)$",
"^[!/#](setlink)$",
"^(setlink)$",
"^[!/#](newlink)$",
"^(newlink)$",
"^[!/#](rules)$",
"^(rules)$",
"^[!/#](setrules) (.*)$",
"^(setrules) (.*)$",
"^[!/#](about)$",
"^(about)$",
"^[!/#](setabout) (.*)$",
"^(setabout) (.*)$",
"^[!/#](setname) (.*)$",
"^(setname) (.*)$",
"^[!/#](clean) (.*)$",
"^(clean) (.*)$",
"^[!/#](setflood) (%d+)$",
"^(setflood) (%d+)$",
"^[!/#](setchar) (%d+)$",
"^(setchar) (%d+)$",
"^[!/#](setfloodtime) (%d+)$",
"^(setfloodtime) (%d+)$",
"^[!/#](res) (.*)$",
"^(res) (.*)$",
"^[!/#](whois) (%d+)$",
"^(whois) (%d+)$",
"^[!/#](setlang) (.*)$",
"^(setlang) (.*)$",
"^[!/#](setcmd) (.*)$",
"^(setcmd) (.*)$",
"^[#!/](filter) (.*)$",
"^(filter) (.*)$",
"^[#!/](unfilter) (.*)$",
"^(unfilter) (.*)$",
"^[#!/](filters)$",
"^(filters)$",
"^[!/#](nerkh)$",
"^(nerkh)$",
"^[!/#](borules)$",
"^(botrules)$",
"^[!/#](ping)$",
"^(ping)$",
"^[!/#](port1)$",
"^(port1)$",
"^[!/#](port2)$",
"^(port2)$",
"^[!/#](port3)$",
"^(port3)$",
"^[!/#](port4)$",
"^(port4)$",
"^[!/#](portall)$",
"^(portall)$",
"^[!/#](card number)$",
"^(card number)$",
"^[!/#](version)$",
"^(version)$",
"^[!/#](creator)$",
"^(creator)$",
"^[!/#](update)$",
"^(update)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#](setwelcome) (.*)",
"^(setwelcome) (.*)",
"^[!/#](welcome) (.*)$",
"^(welcome) (.*)$",
"^(زبان) (.*)$",
"^(دستورات انگلیسی)$",
"^(ایدی)$",
"^(آیدی) (.*)$",
"^(آیدی)$",
"^(ایدی) (.*)$",
'^(تنظیمات1)$',
'^(منو)$',
'^(سنجاق)$',
'^(حذف سنجاق)$',
'^(نصب)$',
'^(لغو نصب)$',
'^(ادمین گروه)$',
'^(ادمین گروه) (.*)$',
'^(حذف ادمین گروه) (.*)$',
'^(حذف ادمین گروه)$',
'^(ویژه) ([+-]) (.*)$',
'^(ویژه) ([+-])$',
'^(ویژه ها)$',
'^(تنظیم صاحب)$',
'^(تنظیم صاحب) (.*)$',
'^(حذف صاحب) (.*)$',
'^(حذف صاحب)$',
'^(تنظیم مدیر)$',
'^(تنظیم مدیر) (.*)$',
'^(حذف مدیر)$',
'^(حذف مدیر) (.*)$',
'^(قفل) (.*)$',
'^(بازکردن) (.*)$',
'^(بیصدا) (.*)$',
'^(باصدا) (.*)$',
'^(لینک جدید)$',
'^(لینک جدید) (خصوصی)$',
'^(اطلاعات گروه)$',
'^(دستورات) (.*)$',
'^(قوانین)$',
'^(لینک)$',
'^(تنظیم لینک)$',
'^(تنظیم قوانین) (.*)$',
'^(لینک) (خصوصی)$',
'^(کاربری) (.*)$',
'^(شناسه) (%d+)$',
'^(تنظیم پیام مکرر) (%d+)$',
'^(تنظیم زمان بررسی) (%d+)$',
'^(حداکثر حروف مجاز) (%d+)$',
'^(پاکسازی) (.*)$',
'^(درباره)$',
'^(تنظیم نام) (.*)$',
'^(تنظیم درباره) (.*)$',
'^(فیلتر ها)$',
'^(تنظیمات2)$',
'^(صاحب ها)$',
'^ مدیر ها)$',
'^(درگاه1)$',
'^(درگاه2)$',
'^(درگاه3)$',
'^(درگاه4)$',
'^(لیست درگاه)$',
'^(شماره کارت)$',
'^(قوانین ربات)$',
'^(ورژن)$',
'^(سازنده)$',
'^(اپدیت)$',
'^(نرخ)$',
'^(پینگ)$',
'^(فیلتر) (.*)$',
'^(حذف فیلتر) (.*)$',
'^(خوشامد) (.*)$',
'^(تنظیم خوشامد) (.*)$',


},
run=run,
pre_process = pre_process
}
--end groupmanager.lua #beyond team#
