--Begin Core.lua By #MeGaPlusTeaM
local function getindex(t,id) 
	for i,v in pairs(t) do 
		if v == id then 
			return i 
		end 
	end 
	return nil 
end 

local function reload_plugins( ) 
	plugins = {} 
	load_plugins() 
end

--By @SajjadMazini
local function already_sudo(user_id)
	for k,v in pairs(_config.sudo_users) do
		if user_id == v then
			return k
		end
	end
	-- If not found
	return false
end

--By @SajjadMazini
local function sudolist(msg)
	local sudo_users = _config.sudo_users
	local text = "Sudo Users :\n"
	for i=1,#sudo_users do
		text = text..i.." - "..sudo_users[i].."\n"
	end
	return text
end

local function options(msg, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
     if not lang then
	 text = '*Welcome To MeGaPlus Group Menu*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
	        {text = "»Lock List«", callback_data="/settings:"..GP_id},
			{text = "»Media List«", callback_data="/mutelist:"..GP_id}
		},
		{
			{text = '»More Settings«', callback_data = '/more:'..GP_id}
		},
		{
			{text = '»Tv«', callback_data = '/tv:'..GP_id},
			{text = '»Satellite«', callback_data = '/satellite:'..GP_id}
		},
		{
			{text = '»Help.EN«', callback_data = '/helpen:'..GP_id},
			{text = '»Help.FA«', callback_data = '/helpfa:'..GP_id}
		},
		{
			{text = '»Shopping«', callback_data = '/shopping:'..GP_id},
			{text = '»Support«', callback_data = '/support:'..GP_id}
		},
		{
			{text = '»MeGaPlus«', callback_data = '/megaplus:'..GP_id}
		},
		{
			{text= '➦Back' ,callback_data = '/lang:'..GP_id}
		}				
	}
  elseif lang then
	 text = '_به منو ربات (مگا پلاس) خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "»لیست قفل«", callback_data="/settings:"..GP_id},
			{text = "»لیست رسانه«", callback_data="/mutelist:"..GP_id}
		},
		{
			{text = '»سایر امکانات«', callback_data = '/more:'..GP_id}
		},
		{
			{text = '»تلویزیون«', callback_data = '/tv:'..GP_id},
			{text = '»ماهواره«', callback_data = '/satellite:'..GP_id}
		},
		{
			{text = '»راهنما.انگلیسی«', callback_data = '/helpen:'..GP_id},
			{text = '»راهنما.فارسی«', callback_data = '/helpfa:'..GP_id}
		},
		{
			{text = '»خرید ربات«', callback_data = '/shopping:'..GP_id},
			{text = '»پشتیبانی«', callback_data = '/support:'..GP_id}
		},
		{
			{text = '»مگا پلاس«', callback_data = '/megaplus:'..GP_id}
		},
		{
			{text= '➦خروج' ,callback_data = '/lang:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function moresetting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
local settings = data[tostring(GP_id)]["settings"]
   if not lang then
 text = '*Welcome To MeGaPlus More Lock*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '〖Flood Sensitivity〗 ', callback_data = 'MeGaPlusTeaM'}
		},
		{
			{text = "▲", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="MeGaPlusTeaM"},
			{text = "▼", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '〖Character Sensitivity〗 ', callback_data = 'MeGaPlusTeaM'}
		},
		{
			{text = "▲", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="MeGaPlusTeaM"},
			{text = "▼", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '〖Flood Check Time〗 ', callback_data = 'MeGaPlusTeaM'}
		},
		{
			{text = "▲", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="MeGaPlusTeaM"},
			{text = "▼", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '➦Back ', callback_data = '/settings:'..GP_id}
		}				
	}
   elseif lang then
 text = '_به تنظیمات سایر قفل ها (مگا پلاس) خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '〖حداکثر پیام های مکرر〗 ', callback_data = 'MeGaPlusTeaM'}
		},
		{
			{text = "▲", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="MeGaPlusTeaM"},
			{text = "▼", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '〖حداکثر حروف مجاز〗 ', callback_data = 'MeGaPlusTeaM'}
		},
		{
			{text = "▲", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="MeGaPlusTeaM"},
			{text = "▼", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '〖زمان بررسی پیام های مکرر〗 ', callback_data = 'MeGaPlusTeaM'}
		},
		{
			{text = "▲", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="MeGaPlusTeaM"},
			{text = "▼", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '➦برگشت ', callback_data = '/settings:'..GP_id}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

function setting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
	if data[tostring(GP_id)] and data[tostring(GP_id)]['settings'] then
		settings = data[tostring(GP_id)]['settings']
	else
		return
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = '🔓'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = '🔓'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = '🔓'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = '🔓'
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = '🔓'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = '🔓'
	end
		if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = '🔓'
	end
		if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = '🔓'
	end
	if settings.flood then
		lock_flood = settings.flood
	else
		lock_flood = '🔓'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = '🔓'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = '🔓'
	end
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = '🔓'
	end
	if settings.welcome then
		group_welcone = settings.welcome
	else
		group_welcone = '🔓'
	end
    if not lang then
 text = '*Welcome To MeGaPlus Group Lock List*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "ᵉᵈⁱᵗ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id},
			{text = "ˡⁱⁿᵏ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "ᵗᵃᵍ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id},
			{text = "ʲᵒⁱⁿ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "ᶠˡᵒᵒᵈ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id},
			{text = "ˢᵖᵃᵐ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "ᵐᵃⁿᵗⁱᵒⁿ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id},
			{text = "ᵃʳᵃᵇⁱᶜ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "ʷᵉᵇ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id},
			{text = "ᵐᵃʳᵏᵈᵒʷⁿ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "ᵖⁱⁿ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id},
			{text = "ᵇᵒᵗ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "〖ʷᵉˡᶜᵒᵐᵉ〗", callback_data='MeGaPlusTeaM'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '〖More Lock〗 ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '➦Back ', callback_data = '/option:'..GP_id}
		}				
	}
     elseif lang then
 text = '_به تنظیمات قفل ها (مگا پلاس) گروه خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "ویرایش", callback_data='MeGaPlusTeaM'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id},
			{text = "لینک", callback_data='MeGaPlusTeaM'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "تگ", callback_data='MeGaPlusTeaM'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id},
			{text = "ورود", callback_data='MeGaPlusTeaM'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "فلود", callback_data='MeGaPlusTeaM'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id},
			{text = "اسپم", callback_data='MeGaPlusTeaM'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "فراخوانی", callback_data='MeGaPlusTeaM'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id},
			{text = "عربی", callback_data='MeGaPlusTeaM'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "وب", callback_data='MeGaPlusTeaM'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id},
			{text = "فونت", callback_data='MeGaPlusTeaM'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "سنجاق", callback_data='MeGaPlusTeaM'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id},
			{text = "ربات", callback_data='MeGaPlusTeaM'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "〖خوشامد〗", callback_data='MeGaPlusTeaM'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '〖سایر قفل ها〗 ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '➦بازگشت', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function mutelists(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
    if data[tostring(GP_id)] and data[tostring(GP_id)]['mutes'] then
		mutes = data[tostring(GP_id)]['mutes']
	else
		return
	end
	if mutes.mute_all then
		mute_all = mutes.mute_all
	else
		mute_all = '🔓'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = '🔓'
	end
   if mutes.mute_photo then
		mute_photo = mutes.mute_photo
	else
		mute_photo = '🔓'
	end
	if mutes.mute_sticker then
		mute_sticker = mutes.mute_sticker
	else
		mute_sticker = '🔓'
	end
	if mutes.mute_contact then
		mute_contact = mutes.mute_contact
	else
		mute_contact = '🔓'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = '🔓'
	end
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = '🔓'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = '🔓'
	end
	if mutes.mute_keyboard then
		mute_keyboard = mutes.mute_keyboard
	else
		mute_keyboard = '🔓'
	end
	if mutes.mute_forward then
		mute_forward = mutes.mute_forward
	else
		mute_forward = '🔓'
	end
	if mutes.mute_location then
		mute_location = mutes.mute_location
	else
		mute_location = '🔓'
	end
   if mutes.mute_document then
		mute_document = mutes.mute_document
	else
		mute_document = '🔓'
	end
	if mutes.mute_voice then
		mute_voice = mutes.mute_voice
	else
		mute_voice = '🔓'
	end
	if mutes.mute_audio then
		mute_audio = mutes.mute_audio
	else
		mute_audio = '🔓'
	end
	if mutes.mute_video then
		mute_video = mutes.mute_video
	else
		mute_video = '🔓'
	end
	if mutes.mute_tgservice then
		mute_tgservice = mutes.mute_tgservice
	else
		mute_tgservice = '🔓'
	end
   if not lang then
	 text = '*Welcome To MeGaPlus Group Mutelist*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "ᵍᵒʳᵘᵖ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id},
			{text = "ᵍⁱᶠ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id}
		},
		{
			{text = "ᵗᵉˣᵗ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id},
			{text = "ⁱⁿˡⁱⁿᵉ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = "ᵍᵃᵐᵉ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id},
			{text = "ᵖʰᵒᵗᵒ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = "ᵛⁱᵈᵉᵒ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id},
			{text = "ᵃᵘᵈⁱᵒ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = "ᵛᵒⁱᶜᵉ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id},
			{text = "ˢᵗⁱᶜᵏᵉʳ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = "ᶜᵒⁿᵗᵃᶜᵗ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id},
			{text = "ᶠᵒʳʷᵃʳᵈ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_forward, callback_data="/muteforward:"..GP_id}
		},
		{
			{text = "ˡᵒᶜᵃᵗⁱᵒⁿ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id},
			{text = "ᵈᵒᶜᵘᵐᵉⁿᵗ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = "ᵗᵍˢᵉʳᵛⁱᶜᵉ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id},
			{text = "ᵏᵉʸᵇᵒᵃʳᵈ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '➦Back ', callback_data = '/option:'..GP_id}
		}				
	}
   elseif lang then
	 text = '_به لیست بیصدای (مگا پلاس) گروه خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "گروه", callback_data='MeGaPlusTeaM'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id},
			{text = "گیف", callback_data='MeGaPlusTeaM'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id}
		},
		{
			{text = "متن", callback_data='MeGaPlusTeaM'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id},
			{text = "اینلاین", callback_data='MeGaPlusTeaM'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = "بازی", callback_data='MeGaPlusTeaM'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id},
			{text = "عکس", callback_data='MeGaPlusTeaM'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = "فیلم", callback_data='MeGaPlusTeaM'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id},
			{text = "آهنگ", callback_data='MeGaPlusTeaM'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = "صدا", callback_data='MeGaPlusTeaM'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id},
			{text = "استیکر", callback_data='MeGaPlusTeaM'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = "مخاطب", callback_data='MeGaPlusTeaM'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id},
			{text =  "فوروارد", callback_data='MeGaPlusTeaM'}, 
			{text = mutes.mute_forward, callback_data="/muteforward:"..GP_id}
		},
		{
			{text = "موقعیت", callback_data='MeGaPlusTeaM'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id},
			{text = "فایل", callback_data='MeGaPlusTeaM'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = "سرویس", callback_data='MeGaPlusTeaM'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id},
			{text = "کیبورد", callback_data='MeGaPlusTeaM'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '➦بازگشت ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
--------------Begin Msg Matches---------------
	if matches[1] == "sudolist" and is_sudo(msg) then
		return sudolist(msg)
	end
	if tonumber(msg.from.id) == sudo_id then
		if matches[1]:lower() == "setsudo" then
			if matches[2] and not msg.reply_to_message then
				local user_id = matches[2]
				if already_sudo(tonumber(user_id)) then
					return 'User '..user_id..' is already sudo users'
				else
					table.insert(_config.sudo_users, tonumber(user_id)) 
					print(user_id..' added to sudo users') 
					save_config() 
					reload_plugins(true) 
					return "User "..user_id.." added to sudo users" 
				end
		elseif not matches[2] and msg.reply_to_message then
			local user_id = msg.reply_to_message.from.id
			if already_sudo(tonumber(user_id)) then
				return 'User '..user_id..' is already sudo users'
			else
				table.insert(_config.sudo_users, tonumber(user_id)) 
				print(user_id..' added to sudo users') 
				save_config() 
				reload_plugins(true) 
				return "User "..user_id.." added to sudo users" 
			end
		end
	end
	if matches[1]:lower() == "remsudo" then
	if matches[2] and not msg.reply_to_message then
		local user_id = tonumber(matches[2]) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	elseif not matches[2] and msg.reply_to_message then
		local user_id = tonumber(msg.reply_to_message.from.id) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	end
	end
	end
--------------End Msg Matches---------------

--------------Begin Inline Query---------------
if msg.query and msg.query:match("-%d+") and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = ' ➣ورود به منو ', callback_data = '/lang:'..chatid}
		},
		{
			{text= '➦خروج از منو' ,callback_data = '/exit:'..chatid}
		}					
	}
	send_inline(msg.id,'settings','Group Option','Tap Here','Please select an Menu.!',keyboard)
end
if msg.cb then
local hash = "gp_lang:"..matches[2]
local lang = redis:get(hash) 
	if matches[1] == '/lang' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    elseif not data[tostring(matches[2])] then
     if not lang then
		edit_inline(msg.message_id, "`Group Is Not Added`")
   elseif lang then
		edit_inline(msg.message_id, "_گروه به لیست مدیریتی ربات اضافه نشده_")
   end
	else
	local text = '_Please Select An_ *Language*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "➣انگلیسی", callback_data="/english:"..matches[2]},
			{text = '➣فارسی ', callback_data = '/persian:'..matches[2]}
		},
		{
			{text= '➦خروج' ,callback_data = '/exit:'..matches[2]}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
	end
end
	if matches[1] == '/english' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    redis:del(hash)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/persian' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    redis:set(hash, true)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/option' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
	options(msg, matches[2])
	end
end
if matches[1] == '/settings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutelist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/moresettings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		moresetting(msg, data, matches[2])
	end
end

          -- ####################### Settings ####################### --
if matches[1] == '/locklink' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
		if locklink == "🔓" then
   if not lang then
			text = 'Link Has Been Locked'
   elseif lang then
			text = 'قفل لینک فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif locklink == "🔐" then
   if not lang then
			text = 'Link Has Been Unlocked'
   elseif lang then
			text = 'قفل لینک غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockedit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
		if lockedit == "🔓" then
   if not lang then
			text = 'Edit Has Been Locked'
   elseif lang then
			text = 'قفل ویرایش فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif lockedit == "🔐" then
   if not lang then
			text = 'Edit Has Been Unlocked'
   elseif lang then
			text = 'قفل ویرایش غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktags' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_tag"]
		if chklock == "🔓" then
   if not lang then
			text = 'Tags Has Been Locked'
   elseif lang then
			text = 'قفل تگ فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_tag"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Tags Has Been Unlocked'
   elseif lang then
			text = 'قفل تگ غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_tag"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockjoin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_join"]
		if chklock == "🔓" then
   if not lang then
			text = 'Join Has Been Locked'
   elseif lang then
			text = 'قفل ورود فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_join"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Join Has Been Unlocked'
   elseif lang then
			text = 'قفل ورود غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_join"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockflood' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["flood"]
		if chklock == "🔓" then
   if not lang then
			text = 'Flood Has Been Locked'
   elseif lang then
			text = 'قفل پیام های مکرر فعال شد'
    end
            data[tostring(matches[2])]["settings"]["flood"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Flood Has Been Unlocked'
   elseif lang then
			text = 'قفل پیام های مکرر غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["flood"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockspam' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_spam"]
		if chklock == "🔓" then
   if not lang then
			text = 'Spam Has Been Locked'
   elseif lang then
			text = 'قفل هرزنامه فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_spam"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Spam Has Been Unlocked'
   elseif lang then
			text = 'قفل هرزنامه غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_spam"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmention' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_mention"]
		if chklock == "🔓" then
   if not lang then
			text = 'Mention Has Been Locked'
   elseif lang then
			text = 'قفل فراخوانی فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_mention"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Mention Has Been Unlocked'
   elseif lang then
			text = 'قفل فراخوانی غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_mention"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabic' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_arabic"]
		if chklock == "🔓" then
   if not lang then
			text = 'Arabic Has Been Locked'
   elseif lang then
			text = 'قفل عربی فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_arabic"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Arabic Has Been Unlocked'
   elseif lang then
			text = 'قفل عربی غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpage' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_webpage"]
		if chklock == "🔓" then
   if not lang then
			text = 'Webpage Has Been Locked'
   elseif lang then
			text = 'قفل صفحات وب فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_webpage"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Webpage Has Been Unlocked'
   elseif lang then
			text = 'قفل صفحات وب غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_markdown"]
		if chklock == "🔓" then
   if not lang then
			text = 'Markdown Has Been Locked'
   elseif lang then
			text = 'قفل فونت فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_markdown"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Markdown Has Been Unlocked'
   elseif lang then
			text = 'قفل فونت غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockpin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_pin"]
		if chklock == "🔓" then
   if not lang then
			text = 'Pin Has Been Locked'
   elseif lang then
			text = 'قفل سنجاق کردن فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_pin"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Pin Has Been Unlocked'
   elseif lang then
			text = 'قفل سنجاق کردن غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_pin"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockbots' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_bots"]
		if chklock == "🔓" then
   if not lang then
			text = 'Bots Has Been Locked'
   elseif lang then
			text = 'قفل ربات ها فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_bots"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Bots Has Been Unlocked'
   elseif lang then
			text = 'قفل ربات ها غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_bots"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/welcome' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["welcome"]
		if chklock == "🔓" then
   if not lang then
			text = 'Welcome Has Been Enabled'
   elseif lang then
			text = 'خوش آمد گویی فعال شد'
    end
            data[tostring(matches[2])]["settings"]["welcome"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chklock == "🔐" then
   if not lang then
			text = 'Welcome Has Been Disabled'
   elseif lang then
			text = 'خوش آمد گویی غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["welcome"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/floodup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) < 30 then
			flood_max = tonumber(flood_max) + 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Sensitivity Has Been Set To : "..flood_max
   elseif lang then
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/flooddown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) > 2 then
			flood_max = tonumber(flood_max) - 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Sensitivity Has Been Set To : "..flood_max
   elseif lang then
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/charup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) < 1000 then
			char_max = tonumber(char_max) + 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Character Sensitivity Has Been Set To : "..char_max
   elseif lang then
			text = "تعداد حروف مجاز تنظیم شد به : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/chardown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) > 2 then
			char_max = tonumber(char_max) - 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Character Sensitivity Has Been Set To : "..char_max
   elseif lang then
			text = "تعداد حروف مجاز تنظیم شد به : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimeup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) < 10 then
			check_time = tonumber(check_time) + 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Check Time Has Been Set To : "..check_time
   elseif lang then
			text = "زمان بررسی پیام های مکرر تنظیم شد به : "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimedown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) > 2 then
			check_time = tonumber(check_time) - 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Check Time Has Been Set To : "..check_time
   elseif lang then
			text = "زمان بررسی پیام های مکرر تنظیم شد به : "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end

			-- ###################### Mute ###################### --
			
if matches[1] == '/muteall' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_all"]
		if chkmute == "🔓" then
    if not lang then
			text = 'All Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن همه فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_all"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'All Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن همه غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_all"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegif' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_gif"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Gifs Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن تصاویر متحرک فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_gif"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Gifs Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن تصاویر متحرک غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetext' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_text"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Text Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن متن فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_text"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Text Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن متن غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_text"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteinline' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_inline"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Inline Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن اینلاین فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_inline"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Inline Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن اینلاین غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegame' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_game"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Game Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن بازی فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_game"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Game Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن بازی غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_game"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutephoto' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_photo"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Photo Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن عکس فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_photo"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Photo Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن عکس غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideo' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_video"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Video Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن فیلم فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_video"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Video Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن فیلم غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_video"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudio' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_audio"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Audio Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن آهنگ فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_audio"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Audio Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن آهنگ غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_voice"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Voice Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن صدا فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_voice"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Voice Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن صدا غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutesticker' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_sticker"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Sticker Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن استیکر فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_sticker"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Sticker Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن استیکر غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontact' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_contact"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Contact Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن مخاطب فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_contact"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Contact Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن مخاطب غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforward' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_forward"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Forward Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن نقل و قول فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_forward"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Forward Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن نقل و قول غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocation' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_location"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Location Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن موقعیت فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_location"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Location Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن موقعیت غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_location"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocument' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_document"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Document Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن فایل فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_document"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Document Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن فایل غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_document"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetgservice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_tgservice"]
		if chkmute == "🔓" then
    if not lang then
			text = 'TgService Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن خدمات تلگرام فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'TgService Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن خدمات تلگرام غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboard' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
		if chkmute == "🔓" then
    if not lang then
			text = 'Keyboard Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن کیبورد شیشه ای فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "🔐"
			save_data(_config.moderation.data, data)
		elseif chkmute == "🔐" then
    if not lang then
			text = 'Keyboard Has Been uted'
    elseif lang then
        text = 'بیصدا کردن کیبورد شیشه ای غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "🔓"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end

            -- ####################### More #######################--
			
if matches[1] == '/more' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    if not lang then
		local text = '*Welcome To More Menu*'
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖OwnerList〗", callback_data="/ownerlist:"..matches[2]},
				{text = "〖ModList〗", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = " 〖SillentList〗", callback_data="/silentlist:"..matches[2]},
				{text = "〖FilterList〗", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "〖BanList〗", callback_data="/bans:"..matches[2]},
				{text = "〖WhiteList〗", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "〖Group Link〗", callback_data="/link:"..matches[2]},
				{text = "〖Group Rules〗", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "〖Show Welcome〗", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "➦Back To Menu", callback_data="/option:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖لیست مالکین〗", callback_data="/ownerlist:"..matches[2]},
				{text = "〖لیست مدیران〗", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "〖لیست سایلنت〗", callback_data="/silentlist:"..matches[2]},
				{text = "〖لیست فیلتر〗", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "〖لیست مسدود〗", callback_data="/bans:"..matches[2]},
				{text = " 〖لیست سفید〗", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "〖لینک گروه〗", callback_data="/link:"..matches[2]},
				{text = " 〖قوانین گروه〗", callback_data="/rules:"..matches[2]}
			},
			{
				{text = " 〖نمایش پیام خوشامد〗", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = " ➦بازگشت به  منو", callback_data="/option:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/ownerlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['owners']) == nil then --fix way
     if not lang then
			text = "*No owner in this group*"
   elseif lang then
			text = "_هیچ مالکی برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "*List Of Group Owners :*\n"
   elseif lang then
			text = "_لیست مالکین گروه :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖Demote All Owners〗", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖برکناری تمام مالکین〗", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanowners' then
	if not is_admin1(msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Bot Admin")
   elseif lang then
		get_alert(msg.cb_id, "شما ادمین ربات نیستید")
   end
	else
		if next(data[tostring(matches[2])]['owners']) == nil then
     if not lang then
			text = "*No owner in this group*"
   elseif lang then
			text = "_هیچ مالکی برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "*All Group Owners Has Been Demoted*"
   elseif lang then
			text = "_تمام مالکین از مقام خود برکنار شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				data[tostring(matches[2])]['owners'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/ownerlist:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/ownerlist:"..matches[2]}
			}
		}
   end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/filterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then --fix way
   if not lang then
			text = "*Filter List Is Emptyz*"
     elseif lang then
			text = "_لیست کلمات فیلتر شده خالی است_"
     end
		else 
			local i = 1
   if not lang then
			text = '*List Of Filtered Words List :*\n'
     elseif lang then
			text = '_لیست کلمات فیلتر شده :_\n'
    end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				text = text..''..i..' - '..check_markdown(k)..'\n'
				i = i + 1
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖Clean〗", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖پاکسازی〗", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanfilterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then
   if not lang then
			text = "*Filter List Is Empty*"
     elseif lang then
			text = "_لیست کلمات فیلتر شده خالی است_"
     end
		else
   if not lang then
			text = "*Filter List Has Been Cleaned*"
     elseif lang then
			text = "_لیست کلمات فیلتر پاک شد_"
     end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				data[tostring(matches[2])]['filterlist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/filterlist:"..matches[2]}
			}
		}
     elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/filterlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/modlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['mods']) == nil then --fix way
     if not lang then
			text = "*No moderator in this group*"
   elseif lang then
			text = "_هیچ مدیری برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "*List Of Moderators :*\n"
   elseif lang then
			text = "_لیست مدیران گروه :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖Demote All Moderators〗", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖برکناری تمام مدیران〗", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanmods' then
	if not is_owner1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Group Owner")
   elseif lang then
		get_alert(msg.cb_id, "شما صاحب گروه نیستید")
   end
	else
		if next(data[tostring(matches[2])]['mods']) == nil then
     if not lang then
			text = "*No moderator in this group*"
   elseif lang then
			text = "_هیچ مدیری برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "*All Moderators Has Been Demoted*"
   elseif lang then
			text = "_تمام مدیران از مقام خود برکنار شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				data[tostring(matches[2])]['mods'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/modlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/bans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['banned']) == nil then --fix way
     if not lang then
			text = "*No banned users in this group*"
   elseif lang then
			text = "_هیچ فردی از این گروه محروم نشده_"
   end
		else
     if not lang then
			text = "*List Of Banned Users :*\n"
   elseif lang then
			text = "_لیست افراد محروم شده از گروه :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖Unban All Banned Users〗", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖 پاکسازی لیست مسدود〗 ", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/silentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then --fix way
     if not lang then
			text = "*No silent users in this group*"
   elseif lang then
			text = "_هیچ فردی در این گروه سایلنت نشده_"
   end
		else
     if not lang then
			text = "*List Of Silent Users :*\n"
   elseif lang then
			text = "_لیست افراد سایلنت شده :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖Unsilent All Silent Users〗", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " 〖پاکسازی لیست سایلنت〗", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleansilentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then
     if not lang then
			text = "*No silent users in this group*"
   elseif lang then
			text = "_هیچ فردی در این گروه سایلنت نشده"
   end
		else
     if not lang then
			text = "*All Silent Users Has Been Unsilent*"
   elseif lang then
			text = "_تمام افراد سایلنت شده از سایلنت خارج شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				data[tostring(matches[2])]['is_silent_users'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/silentlist:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/silentlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanbans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['banned']) == nil then
     if not lang then
			text = "*No banned users in this group*"
   elseif lang then
			text = "_هیچ فردی از این گروه محروم نشده"
   end
		else
     if not lang then
			text = "*All Banned Users Has Been Unbanned*"
   elseif lang then
			text = "_تمام افراد محروم شده از محرومیت این گروه خارج شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				data[tostring(matches[2])]['banned'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/bans:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/bans:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/link' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local linkgp = data[tostring(matches[2])]['settings']['linkgp']
		if not linkgp then
   if not lang then
			text = "*First set a link for group with using* /setlink"
    elseif lang then
			text = "_ابتدا با دستور_ setlink/ _لینک جدیدی برای گروه تعیین کنید_"
  end
		else
   if not lang then
			text = "[Group Link Is Here]("..linkgp..")"
    elseif lang then
			text = "[لینک گروه اینجاست]("..linkgp..")"
        end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/rules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
   if not lang then
     text = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@MeGaPlusTeaM"
    elseif lang then
       text = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@MeGaPlusTeaM"
 end
		elseif rules then
     if not lang then
			text = '*Group Rules :*\n'..rules
   elseif lang then
			text = '_قوانین گروه :_\n'..rules
       end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖Clean〗", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "〖پاکسازی〗", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanrules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
    if not lang then
			text = "`No Rules Available`"
   elseif lang then
			text = "_قوانین گروه ثبت نشده_"
   end
		else
    if not lang then
			text = "*Group Rules Has Been Cleaned*"
   elseif lang then
			text = "_قوانین گروه پاک شد_"
  end
			data[tostring(matches[2])]['rules'] = nil
			save_data(_config.moderation.data, data)
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/rules:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/rules:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
		if matches[1] == '/whitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "_White List is Empty._"
			else
				text = "_لیست سفید خالی می باشد._"
			end
		else 
			local i = 1
			if not lang then
				text = '_> White List:_ \n'
			else
				text = '_> لیست سفید:_ \n'
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				text = text..''..i..' - '..check_markdown(v)..' ' ..k.. ' \n'
				i = i + 1
			end
		end
		local keyboard = {}
		if not lang then
		keyboard.inline_keyboard = {
			{
				{text = "〖Clean White List〗", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{
				{text = "〖حذف لیست سفید〗", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end

if matches[1] == '/cleanwhitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "_White List is Empty._"
			else
				text = "_لیست سفید خالی می باشد._"
			end
		else
			if not lang then
				text = "_White List Was Cleared._"
			else
				text = "_لیست سفید حذف شد._"
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				data[tostring(matches[2])]['whitelist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
		end
end
if matches[1] == '/showwlc' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "*Welcome Message Not Set.*\n*Default Message :* *Welcome Dude*"
			else
				text = "_پیام خوشامد تنظیم نشده است._"
			end
		else
		if not lang then
			text = '_Welcome Message:_\n'..wlc
		else
			text = '_پیام خوشامد:_\n'..wlc
		end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {
			{ 
				{text = "〖Clean Welcome Message〗", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{ 
				{text = "〖حذف پیام خوشامد〗", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwlcmsg' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "_Welcome Message Not Set._"
			else
				text = "_پیام خوشامد تنظیم نشده است._"
			end
		else
		if not lang then
			text = '*Welcome Message Was Cleaned.*'
		else
			text = '_پیام خوشامد حذف شد._'
		end
		data[tostring(matches[2])]['setwelcome'] = nil
		save_data(_config.moderation.data, data)
end
local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = "➦Back", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "➦برگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
         -- ####################### TV Iran ####################### --
if matches[1] == '/tv' then 
		local text = 'به بخش تلویزیون ربات (مگا پلاس) خوش امدید'
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '〖Tv①〗', url = 'http://www.aparat.com/live/tv1'},
			{text = '〖Tv②〗', url = 'http://www.aparat.com/live/tv2'}
		},
		{
			{text = '〖Tv③〗', url = 'http://www.aparat.com/live/tv3'}
		},
		{
			{text = '〖Namayesh〗', url = 'https://www.aparat.com/live/namayesh'},
			{text = '〖Tmasha〗', url = 'https://www.aparat.com/live/hd'}
		},
		{
			{text = '〖Ifilm〗', url = 'https://www.aparat.com/live/ifilm'}
		},
		{
			{text = '〖Nasim〗', url = 'https://www.aparat.com/live/nasim'},
			{text = '〖Varzsh〗', url = 'https://www.aparat.com/live/varzesh'}
		},
		{
			{text = '〖Pouya〗', url = 'https://www.aparat.com/live/pouya'}
		},
		{
			{text = '〖Mostanad〗', url = 'http://www.aparat.com/live/mostanad'},
			{text = '〖Ofogh〗', url = 'http://www.aparat.com/live/ofogh'}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '〖شـبــکـه① 〗', url = 'http://www.aparat.com/live/tv1'},
			{text = '〖شبــکــه②〗', url = 'http://www.aparat.com/live/tv2'}
		},
		{
			{text = '〖شبــکــه③〗', url = 'http://www.aparat.com/live/tv3'}
		},
		{
			{text = '〖نـــمـــایـش〗', url = 'https://www.aparat.com/live/namayesh'},
			{text = '〖تـمــاشـــا〗', url = 'https://www.aparat.com/live/hd'}
		},
		{
			{text = '〖ای فـــیــلـم〗', url = 'https://www.aparat.com/live/ifilm'}
		},
		{
			{text = '〖نـسـیــم〗', url = 'https://www.aparat.com/live/nasim'},
			{text = '〖ورزش〗', url = 'https://www.aparat.com/live/varzesh'}
		},
		{
			{text = '〖پـویـا〗', url = 'https://www.aparat.com/live/pouya'}
		},
		{
			{text = '〖مـــسـتـــنــد〗', url = 'http://www.aparat.com/live/mostanad'},
			{text = '〖افـــق〗', url = 'http://www.aparat.com/live/ofogh'}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end
         -- ####################### Satellite ####################### --
if matches[1] == '/satellite' then 
		local text = 'به بخش تلویزیون ربات (مگا پلاس) خوش امدید'
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖Reminder〗", callback_data="/reminder:"..matches[2]}
		},
		{
			{text = '〖GemTv〗', url = 'http://tvmanoto.com/gem-tv/'},
			{text = '〖GemSeries〗', url = 'http://tvmanoto.com/gem-series/'}
		},
		{
			{text = '〖GemBollywood〗', url = 'http://tvmanoto.com/gem-bollywood/'}
		},
		{
			{text = '〖GemRiver〗', url = 'http://tvmanoto.com/gem-river'},
			{text = '〖GemRubix〗', url = 'http://tvmanoto.com/gem-rubix/'}
		},
		{
			{text = '〖GemLife〗', url = 'http://tvmanoto.com/gem-life'}
		},
		{
			{text = '〖Darama〗', url = 'http://tvmanoto.com/gem-drama'},
			{text = '〖Tvpersia〗', url = 'http://tvmanoto.com/tv-persia'}
		},
		{
			{text = '〖Pmc〗', url = 'http://tvmanoto.com/pmc/'}
		},
		{
			{text = '〖Manoto〗', url = 'http://tvmanoto.com/manototv/comment-page-2/'},
			{text = '〖Bbc〗', url = 'http://tvmanoto.com/bbc-persian/'}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖تذکر〗", callback_data="/reminder:"..matches[2]}
		},
		{
			{text = '〖جم تی وی〗', url = 'http://tvmanoto.com/gem-tv/'},
			{text = '〖جم سریز〗', url = 'http://tvmanoto.com/gem-series/'}
		},
		{
			{text = '〖جم بالیوود〗', url = 'http://tvmanoto.com/gem-bollywood/'}
		},
		{
			{text = '〖جم ریور〗', url = 'http://tvmanoto.com/gem-river'},
			{text = '〖جم روبیکس〗', url = 'http://tvmanoto.com/gem-rubix/'}
		},
		{
			{text = '〖جم لایف〗', url = 'http://tvmanoto.com/gem-life'}
		},
		{
			{text = '〖دراما〗', url = 'http://tvmanoto.com/gem-drama'},
			{text = '〖تی وی پرشیا〗', url = 'http://tvmanoto.com/tv-persia'}
		},
		{
			{text = '〖پی ام سی〗', url = 'http://tvmanoto.com/pmc/'}
		},
		{
			{text = '〖من و تو〗', url = 'http://tvmanoto.com/manototv/comment-page-2/'},
			{text = '〖بی بی سی〗', url = 'http://tvmanoto.com/bbc-persian/'}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/reminder' then
local text = [[💥لطفا قبل از استفاده از این بخش فیلتر شکن گوشی خود را روشن کنید 
*کانال ما:*
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/satellite:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/satellite:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
         -- ####################### Supprt ####################### --
if matches[1] == '/megaplus' then
	local text = _config.info_text
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖Developer〗", callback_data="/sajjad:"..matches[2]}, 
			{text = "〖Version〗", callback_data="/version:"..matches[2]}
		},
		{
			{text = "〖BotRules〗", callback_data="/botrules:"..matches[2]}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖سازنده〗", callback_data="/sajjad:"..matches[2]}, 
			{text = "〖ورژن ربات〗", callback_data="/version:"..matches[2]}
		},
		{
			{text = "〖قوانین ربات〗", callback_data="/botrules:"..matches[2]}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/sajjad' then
local text = [[*》Sajjad Mazini Information《*
_》Age :《_ *16*
_》Name :《_ *Sajjad Mazini*
_》City :《_ *Gorgan*
*-------------------------*
_》Pv :《_ @SajjadMazini and @KingLonely
_》Bot :《_ @MeGaPlusSupportBot
*-------------------------*
*》Expertise :《*
_》_*Lua & Php*, *Cli* `and` *Api* _Bots_
*-------------------------*]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/megaplus:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/megaplus:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/version' then
local text = [[*💥Robot Specification (Mega Plus)*

*Robot Version:* TDBOT v ( 3.0 )

*Developer:*
@kingLonely
@SajjadMazini

Bot rules are enabled with the *( botrules )* command

*Channel:*
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/megaplus:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/megaplus:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/botrules' then
local text = [[💥قوانین ربات (مگا پلاس)

1.حذف کردن ربات به هر بهانه مورد قبول نیست و برای نصب دوباره مبلغ 5000هزار تومان کسر میشود

2.خرید ربات از هر شخصی جز 
[ @SajjadMazini ] 
به تیم ما ربطی ندارد

3.پاک شدن گروه شما با فیلتر شدن ان به ما ربطی ندارد و باید ربات دوباره خریداری شود

روز خوبی داشته باشید با مگا پلاس تیم

توسعه دهنده:
@kingLonely
@SajjadMazini
@MeGaPlusSupportBot

کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/megaplus:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/megaplus:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
         -- ####################### Buy Bot ####################### --
if matches[1] == '/support' then
	local text = 'به بخش پشتیبانی ربات (مگا پلاس) خوش امدید'
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '〖Developer〗', url = 'https://t.me/sajjadmazini'},
			{text = '〖BotDev〗', url = 'https://t.me/sajjadmazinibot'}
		},
		{
			{text = '〖Support 〗', url = 'https://t.me/kinglonely'},
			{text = '〖BotSupport〗', url = 'https://t.me/megaplussupportbot'}
		},
		{
			{text = '〖GpSupport〗', url = 'https://t.me/joinchat/HLwaYVJcInptFPbGgYB-2A'},
			{text = '〖BotChannel〗', url = 'https://t.me/megaplusteam'}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '〖برنامه نویس 〗', url = 'https://t.me/sajjadmazini'},
			{text = '〖پـیـامرسـان〗', url = 'https://t.me/sajjadmazinibot'}
		},
		{
			{text = '〖پــشـتـیـبـانـی 〗', url = 'https://t.me/kinglonely'},
			{text = '〖پـیـامرسـان〗', url = 'https://t.me/megaplussupportbot'}
		},
		{
			{text = '〖گپ پشتیبانی〗', url = 'https://t.me/joinchat/HLwaYVJcInptFPbGgYB-2A'},
			{text = '〖کـــانـال ربـات〗', url = 'https://t.me/megaplusteam'}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end
         -- ####################### Buy Bot ####################### --
if matches[1] == '/shopping' then
	local text = 'به بخش خرید خودکار ربات (مگا پلاس) خوش امدید'
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖Nerkh Bot〗", callback_data="/nerkh:"..matches[2]}, 
			{text = "〖Features〗", callback_data="/features:"..matches[2]}
		},
		{
			{text = "〖Card Number〗", callback_data="/cardnumber:"..matches[2]}
		},
		{
			{text = '〖Month① 〗', url = 'https://idpay.ir/megaplus/80000'},
			{text = '〖Month②〗', url = 'https://idpay.ir/megaplus/150000'}
		},
		{
			{text = '〖Month③〗', url = 'https://idpay.ir/megaplus/200000'},
			{text = '〖Month④〗', url = 'https://idpay.ir/megaplus/250000'}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖قیمت ربات〗", callback_data="/nerkh:"..matches[2]}, 
			{text = "〖امکانات ربات〗", callback_data="/features:"..matches[2]}
		},
		{
			{text = "〖شماره کارت〗", callback_data="/carnumber:"..matches[2]}
		},
		{
			{text = '〖مـــاهــه① 〗', url = 'https://idpay.ir/megaplus/80000'},
			{text = '〖مـــاهــه②〗', url = 'https://idpay.ir/megaplus/150000'}
		},
		{
			{text = '〖مـــاهــه③〗', url = 'https://idpay.ir/megaplus/200000'},
			{text = '〖مـــاهــه④〗', url = 'https://idpay.ir/megaplus/250000'}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/nerkh' then
local text = [[💵 نرخ ربات (مگا پلاس) 

💥️ برای تمام گروه ها‌

💥️1 ماهه8هزار تومان 
💥️2 ماهه15هزار تومان
💥️3 ماهه20هزار تومان
💥️4 ماهه25هزار تومان

🔹 نکته مهم :

➖توجه داشته باشید ربات ما بدلیل سرعت بالا و امکانات فراوان ربات دائمی نداریم

لطفا پس از خرید از صفحه پرداخت عکس گرفته و به ایدی زیر ارسال کنید
@SajjadMazini
@KingLonely
@MeGaPlusSupportBot

کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/shopping:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/shopping:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/features' then
local text = [[💥ربات ضد اسپم یا ضد لینک (مگا پلاس) هم میتواند مانند یکی از ادمینهای یک سوپر گروه کار کند و گروهتان را مدیریت کند
    کاربرد ربات ضد اسپم (مگا پلاس) میتواند خیلی چیزا مانند مدیرتی یا تفریحی باشد

    ▎○1. مدیریت گروه وقتی شما خواب هستید
    ▎●2. نمایش اطلاعات گروه
    ▎○3. تنظیم قانون گذاری
    ▎●4. تنظیم توضیحات گروه
    ▎○3. حذف افرادی که تعداد پیام زیادی در ثانیه در گروه میفرستند
    ▎●4. خوش آمدگویی
    ▎○5. پاک کننده لینک
    ▎●6. پاک کننده پیام های طولانی
    ▎○7. پاک کننده چتهای فارسی
    ▎●8. پاک کننده چتهای انگلیسی
    ▎○9. پاک کننده شماره و مخاطب
    ▎●10. پاک کننده گیف
    ▎○11. پاک کننده فیلم
    ▎○12. پاک کننده استیکر
    ▎●13. پاک کننده چت
    ▎○14. پاک کننده رباتهای خرابکار
    ▎●15. پاک کننده ویرایش
    ▎○16. پاک کننده آیدی کانال
    ▎●17. انتخاب چندین مدیر و مقام کاربردی برای کنترل ربات
    ▎○18. ریمو کردن افراد
    ▎●19. سکوت کردن افراد در گروه
    ▎○20. اخطار دادن به افراد گروه
    ▎●21. دارای لیست های گوناگون
    ▎○22. ثبت لینک گروه خود در ربات
    ▎●23. پاکسازی گروه
    24. ممنوع کردن یک کلمه خاص در گروه
    ▎○25. امکانات تفریحی
    ▎●26. همیشه انلاین بودن
    ▎○27. قابلیت تعطیلی گروه بصورت زمانی
    ▎●28. ضد فحش
    ▎○29. ضد هک

    در نظر داشته باشید تمام موارد بالا را میتوانید بصورت جداگانه برای گروهتان شخصی سازی کنید
    یعنی کدام فعال باشند و کدام نباشند

    سوالات خود را با مدیریت در میان بگذارید
@SajjadMazini
@KingLonely
@MeGaPlusSupportBot

*کانال ما:*
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/shopping:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/shopping:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/cardnumber' then
local text = [[💥Card number to buy a robot (mega plus) 

 6277-6012-2451-1582
سجاد مزینی
پست بانک
لطفا عکس را به ایدی زیر ارسال کنید
@KingLonely
@SajjadMazini
@MeGaPlusSupportBot
کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/shopping:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/shopping:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
         -- ####################### Help ####################### --
if matches[1] == '/helpen' then
	local text = 'به بخش راهنما انگلیسی ربات (مگا پلاس) خوش امدید'
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖Help①〗", callback_data="/helpsudo:"..matches[2]}, 
			{text = "〖Help②〗", callback_data="/helplock:"..matches[2]}
		},
		{
			{text = "〖Help③〗", callback_data="/helpmedia:"..matches[2]}
		},
		{
			{text = "〖Help④〗", callback_data="/helpmod:"..matches[2]}, 
			{text = "〖Help⑤〗", callback_data="/helpfun:"..matches[2]}
		},
		{
			{text = "〖Help⑥〗", callback_data="/helpport:"..matches[2]}
		},
		{
			{text = "〖Help⑦〗", callback_data="/helpadd:"..matches[2]}, 
			{text = "〖Help⑧〗", callback_data="/helpclean:"..matches[2]}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖راهنما①〗", callback_data="/helpsudo:"..matches[2]}, 
			{text = "〖راهنما②〗", callback_data="/helplock:"..matches[2]}
		},
		{
			{text = "〖راهنما③〗", callback_data="/helpmedia:"..matches[2]}
		},
		{
			{text = "〖راهنما④〗", callback_data="/helpmod:"..matches[2]}, 
			{text = "〖راهنما⑤〗", callback_data="/helpfun:"..matches[2]}
		},
		{
			{text = "〖راهنما⑥〗", callback_data="/helpport:"..matches[2]}
		},
		{
			{text = "〖راهنما⑦〗", callback_data="/helpadd:"..matches[2]}, 
			{text = "〖راهنما⑧〗", callback_data="/helpclean:"..matches[2]}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/helpsudo' then
local text = [[*💥MeGaPlus Sudo  Help*

▎ ○install
▎`Add the group to the robot management list`
▎ ○uninstall
▎`Delete the group from the robot management list`

▎○visudo `[id]`
▎`Add Sudo`

▎●desudo `[id]`
▎`Demote Sudo`

▎○sudos
▎`Sudo(s) list`

▎●setadmin `[id]`
▎`Add admin for bot`

▎○remadmin `[id]`
▎`Demote bot admin`

▎●admins
▎`Admin(s) list`

▎○leave 
▎`Leave current group`

▎●autoleave `[+/-]`
▎`Automatically leaves group`

▎○creategroup `[text]`
▎`Create normal group`

▎●createsuper `[text]`
▎`Create supergroup`

▎○tosuper 
▎`Convert to supergroup`

▎●stats
▎`List of added groups`

▎○join `[id]`
▎`Adds you to the group`

▎●rem `[id]`
▎`Remove a group from Database`

▎○import `[link]`
▎`Bot joins via link`

▎●setname 
▎`Change bot's name`

▎○setusername 
▎`Change bot's username`

▎●remusername 
▎`Delete bot's username`

▎○markread `[+/-]`
▎`Second mark`

▎●sendall `[text]`
▎`Send message to all added groups`

▎○send `[text|Gpid]`
▎`Send message to a specific group`

▎●sendfile `[file]`
▎`Send file from folder`

▎○sendplug `[name]`
▎`Send plugin`

▎●save `[name]`
▎`Save plugin by reply`

▎○savefile `[name]`
▎`Save File by reply to specific folder`

▎●config
▎`Set Owner and Admin Group`

▎○clean cache
▎`Clear All Cache Of .telegram-cli/data`

▎●expire
▎`Stated Expiration Date`

▎○expire `[GroupID]`
▎`Stated Expiration Date Of Specific Group`

▎●expire `[Gid|dys]`
▎`Set Expire Time For Specific Group`

▎○expire `[days]`
▎`Set Expire Time For Group`

▎●jointo `[GroupID]`
▎`Invite You To Specific Group`

▎○leave `[GroupID]`
▎`Leave Bot From Specific Group`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @KingLonely and @SajjadMazini
🏅Channel: 
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helplock' then
local text = [[*💥MeGaPlus Lock Help*

*enabled Locked🔐*

▎○lock `[link | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention | pin | join]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*Disable Locked🔓*

▎●unlock `[link | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention | pin | join]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @KingLonely and @SajjadMazini
🏅Channel:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpmedia' then
local text = [[*💥MeGaPlus MediaLock Help*

*enabled Muted🔇*

▎○mute `[gif | photo | document | sticker | keyboard | video | video_note | text | forward | location | audio | voice | contact | group]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*Disable Muted🔈*

▎●unmute `[gif | photo | document | sticker | keyboard | video | video_note | text | forward | location | audio | voice | contact | group]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @KingLonely and @SajjadMazini
🏅Channel:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpmod' then
local text = [[text]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpfun' then
local text = [[*💥MeGaPlus Fun Help*

▎○time
▎`Get time in a sticker`

▎●short `[link]`
▎`Make short url`

▎○tovoice `[text]`
▎`Convert text to voice`

▎●tr `[lang]`
▎`Translates FA to EN`

▎○sticker `[word]`
▎`Convert text to sticker`

▎●photo `[word]`
▎`Convert text to photo`

▎○calc 
▎Calculator

▎●ptime `[city]`
▎`Get Patent (Pray Time)`

▎○tosticker `[reply]`
▎`Convert photo to sticker`

▎●tophoto `[reply]`
▎`Convert text to photo`

▎○weather `[city]`
▎`Get weather`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @KingLonely and @SajjadMazini
🏅Channel:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpport' then
local text = [[*💥MeGaPlus Payment gateway Help*

▎○port1
▎`One-month payment`

▎●prot2 
▎`2-month payment`

▎○port3
▎`3-month payment  `

▎●port4
▎`4-month payment`

▎○portall
▎`List of paid ports` 

▎○card number
▎`Get a card number` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @KingLonely and @SajjadMazini
🏅Channel:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpadd' then
local text = [[*💥MeGaPlus GpAddUser  Help*

▎○lock add
▎`Locking add user`

▎●unlock add 
▎`Unlocking add user`

▎○setadd `[1-10]`
▎`Set Add Mandatory User`

▎●getadd
▎`Checked Numbers`

▎○addpm {on-off}
▎`Turned off the forced force`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @KingLonely and @SajjadMazini
🏅Channel:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpclean' then
local text = [[text]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpen:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpen:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
         -- ####################### Help ####################### --
if matches[1] == '/helpfa' then
	local text = 'به بخش راهنما فارسی ربات (مگا پلاس) خوش امدید'
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖Help①〗", callback_data="/helpsudofa:"..matches[2]}, 
			{text = "〖Help②〗", callback_data="/helplockfa:"..matches[2]}
		},
		{
			{text = "〖Help③〗", callback_data="/helpmediafa:"..matches[2]}
		},
		{
			{text = "〖Help④〗", callback_data="/helpmodfa:"..matches[2]}, 
			{text = "〖Help⑤〗", callback_data="/helpfunfa:"..matches[2]}
		},
		{
			{text = "〖Help⑥〗", callback_data="/helpportfa:"..matches[2]}
		},
		{
			{text = "〖Help⑦〗", callback_data="/helpaddfa:"..matches[2]}, 
			{text = "〖Help⑧〗", callback_data="/helpcleanfa:"..matches[2]}
		},
		{
			{text= '➦Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "〖راهنما①〗", callback_data="/helpsudofa:"..matches[2]}, 
			{text = "〖راهنما②〗", callback_data="/helplockfa:"..matches[2]}
		},
		{
			{text = "〖راهنما③〗", callback_data="/helpmediafa:"..matches[2]}
		},
		{
			{text = "〖راهنما④〗", callback_data="/helpmodfa:"..matches[2]}, 
			{text = "〖راهنما⑤〗", callback_data="/helpfunfa:"..matches[2]}
		},
		{
			{text = "〖راهنما⑥〗", callback_data="/helpportfa:"..matches[2]}
		},
		{
			{text = "〖راهنما⑦〗", callback_data="/helpaddfa:"..matches[2]}, 
			{text = "〖راهنما⑧〗", callback_data="/helpcleanfa:"..matches[2]}
		},
		{
			{text= '➦بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/helpsudofa' then
local text = [[*💥راهنما سودو (مگا پلاس)*

▎ ○نصب
▎ `اضافه کردن گروه به لیست گروه مدیریتی ربات`

▎ ○لغو نصب
▎ `حذف کردن گروه از لیست گروه مدیریتی ربات`

▎ ○سودو `[id]`
▎ `اضافه کردن سودو`

▎ ●حذف سودو `[id]`
▎ `حذف کردن سودو`

▎ ○سودو ها
▎ `لیست سودو‌های ربات`

▎ ●تنظیم ادمین `[id]`
▎ `اضافه کردن ادمین به ربات`

▎ ○حذف ادمین `[id]`
▎ `حذف فرد از ادمینی ربات`

▎ ●ادمین ها
▎ `لیست ادمین ها`

▎ ○خروج از گروه
▎ `خارج شدن ربات از گروه`

▎ ●خروج خودکار `[+/-]`
▎ `خروج خودکار`

▎ ○ساخت گروه 
▎ `ساخت گروه ریلم`

▎ ●ساخت سوپرگروه 
▎ `ساخت سوپر گروه`

▎ ○تبدیل به سوپرگروه
▎ `تبدیل به سوپر گروه`

▎ ●امار
▎ `لیست گروه های مدیریتی ربات`

▎ ○افزودن `[ID]`
▎ `جوین شدن توسط ربات`

▎ ●حذف `[GroupID]`
▎ `حذف گروه ازطریق پنل مدیریتی`

▎ ○ورود لینک `[link]`
▎ `جوین شدن ربات توسط لینک`

▎ ●تنظیم نام 
▎ `تغییر اسم ربات`

▎ ○تنظیم یوزرنیم 
▎ `تغییر یوزرنیم ربات`

▎ ●حذف یوزرنیم
▎ `پاک کردن یوزرنیم ربات`

▎ ○تیک دوم `[+/-]`
▎ `تیک دوم`

▎ ●ارسال به همه `[text]`
▎ `فرستادن پیام به تمام گروه های مدیریتی ربات`

▎ ○ارسال `[text|Gpid]`
▎ `ارسال پیام مورد نظر به گروه خاص`

▎ ●ارسال فایل `[file]`
▎ `ارسال فایل موردنظر از پوشه خاص`

▎ ○ارسال پلاگین `[name]`
▎ `ارسال پلاگ مورد نظر`

▎ ●ذخیره پلاگین `[name]`
▎ `ذخیره کردن پلاگین`

▎ ○ذخیره فایل `[name]`
▎ `ذخیره کردن فایل در پوشه مورد نظر`

▎ ●ترفیع گروه
▎ `اضافه کردن سازنده و مدیران گروه به مدیریت ربات`

▎ ○پاکسازی حافظه
▎ `پاک کردن کش`

▎ ●انقضا
▎ `اعلام تاریخ انقضای گروه`

▎ ○انقضا `[GroupID]`
▎ `اعلام تاریخ انقضای گروه مورد نظر`

▎ ●انقضا `[Gid|dys]`
▎ `تنظیم تاریخ انقضای گروه مورد نظر`

▎ ○انقضا `[days]`
▎ `تنظیم تاریخ انقضای گروه`

▎ ●ورود به `[GroupID]`
▎ `دعوت شدن شما توسط ربات به گروه مورد نظر`

▎ ○خروج از گروه `[Gpid]`
▎ `خارج شدن ربات از گروه مورد نظر`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @KingLonely and @SajjadMazini
🏅کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helplockfa' then
local text = [[*💥راهنما قفلی (مگا پلاس)*

*فعال سازی قفل ها🔐*

▎ ●قفل `[لینک | تگ | ویرایش | عربی | وب | ربات | اسپم | فلود | فونت | فراخوانی | سنجاق | جوین]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*غیرفعال سازی قفل ها🔓*

▎ ●باز کردن `[لینک | تگ | ویرایش | عربی | وب | ربات | اسپم | فلود | فونت | فراخوانی | سنجاق | جوین]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @KingLonely and @SajjadMazini
🏅کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpmediafa' then
local text = [[*💥راهنما قفل رسانه (مگا پلاس)*

*فعال سازی ممنوعیت ها🔇*

▎ ●بیصدا `[گروه | گیف | عکس | فایل | استیکر | کیبورد | فیلم | فیلم سلفی | متن | فوروارد | موقعیت | اهنگ | ویس | مخاطب | شیشه ای | بازی | سرویس]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*غیرفعال سازی ممنوعیت ها🔈*

▎ ●باصدا `[گروه | گیف | عکس | فایل | استیکر | کیبورد | فیلم | فیلم سلفی | متن | فوروارد | موقعیت | اهنگ | ویس | مخاطب | شیشه ای | بازی | سرویس]`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @KingLonely and @SajjadMazini
🏅کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpmodfa' then
local text = [[text]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpfunfa' then
local text = [[*💥راهنما فان (مگا پلاس)*

▎  ○ساعت
▎ `دریافت ساعت به صورت استیکر`

▎  ●کوتاه `[link]`
▎ `کوتاه کننده لینک`

▎  ○به صدا `[text]`
▎ `تبدیل متن به صدا`

▎  ●ترجمه `[lang]`
▎ `ترجمه متن فارسی به انگلیسی `

▎  ○استیکر `[word]`
▎ `تبدیل متن به استیکر`

▎  ●عکس `[word]`
▎ `تبدیل متن به عکس`

▎  ○ماشین حساب 
▎ `ماشین حساب`

▎  ●زمان `[city]`
▎ `اعلام ساعات شرعی`

▎  ○به استیکر `[reply]`
▎ `تبدیل عکس به استیکر`

▎  ●به عکس `[reply]`
▎ `تبدیل استیکر‌به عکس`

▎  ○دما `[city]`
▎ `دریافت اب وهوا`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @KingLonely and @SajjadMazini
🏅کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpportfa' then
local text = [[*💥راهنما درگاه های پرداختی (مگا پلاس)*

▎ ○درگاه1
▎  `دریافت درگاه 1ماهه`

▎ ●درگاه2 
▎  `دریافت درگاه 2ماهه`

▎ ○درگاه3
▎  `دریافت درگاه 3ماهه`  

▎ ●درگاه4
▎  `دریافت درگاه 4ماهه`

▎ ○لیست درگاه
▎‌  `دریافت لیست درگاه ها` 

▎ ○ شماره کارت
▎‌  `دریافت شماره کارت` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @KingLonely and @SajjadMazini
🏅کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpaddfa' then
local text = [[*💥راهنما ادداجباری گروه (مگا پلاس)*

▎ ○قفل اداجباری
▎  `روشن کردن ادد اجباری`

▎ ●بازکردن اداجباری
▎ `خاموش کردن ادد اجباری`

▎  ○تنظیم اداجباری `[10-1]`
▎  `تنظیم تعداد ادد اجباری`

▎ ●تعداد اداجباری
▎  `چک کردن تعداد تنظیم شده `

▎ ○پیام اداجباری {فعال-غیرفعال}
▎  `خاموش روشن کردن پیام ادد`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @KingLonely and @SajjadMazini
🏅کانال ما:
@MeGaPlusTeaM]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/helpcleanfa' then
local text = [[text]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦Back", callback_data="/helpfa:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "➦برگشت", callback_data="/helpfa:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/exit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    if not lang then
		 text = '*MeGaPlus Group Menu Closed*'
   elseif lang then
		 text = 'منو ربات (مگا پلاس) بسته شد'
   end
		edit_inline(msg.message_id, text)
	end
end

end
--------------End Inline Query---------------
end

local function pre_process(msg)
-- print(serpent.block(msg), {comment=false})
--leave_group(msg.chat.id)
end

return {
	patterns ={
		"^-(%d+)$",
		"^###cb:(%d+)$",
		"^[/](sudolist)$",
		"^[/](setsudo)$",
		"^[/](remsudo)$",
		"^[/](setsudo) (%d+)$",
		"^[/](remsudo) (%d+)$",
		"^###cb:(/option):(.*)$",
		"^###cb:(/lang):(.*)$",
		"^###cb:(/persian):(.*)$",
		"^###cb:(/english):(.*)$",
		"^###cb:(/settings):(.*)$",
		"^###cb:(/mutelist):(.*)$",
		"^###cb:(/locklink):(.*)$",
		"^###cb:(/lockedit):(.*)$",
		"^###cb:(/locktags):(.*)$",
		"^###cb:(/lockjoin):(.*)$",
		"^###cb:(/lockpin):(.*)$",
		"^###cb:(/lockmarkdown):(.*)$",
		"^###cb:(/lockmention):(.*)$",
		"^###cb:(/lockarabic):(.*)$",
		"^###cb:(/lockwebpage):(.*)$",
		"^###cb:(/lockbots):(.*)$",
		"^###cb:(/lockspam):(.*)$",
		"^###cb:(/lockflood):(.*)$",
		"^###cb:(/welcome):(.*)$",
		"^###cb:(/muteall):(.*)$",
		"^###cb:(/mutegif):(.*)$",
		"^###cb:(/mutegame):(.*)$",
		"^###cb:(/mutevideo):(.*)$",
		"^###cb:(/mutevoice):(.*)$",
		"^###cb:(/muteinline):(.*)$",
		"^###cb:(/mutesticker):(.*)$",
		"^###cb:(/mutelocation):(.*)$",
		"^###cb:(/mutedocument):(.*)$",
		"^###cb:(/muteaudio):(.*)$",
		"^###cb:(/mutephoto):(.*)$",
		"^###cb:(/mutetext):(.*)$",
		"^###cb:(/mutetgservice):(.*)$",
		"^###cb:(/mutekeyboard):(.*)$",
		"^###cb:(/mutecontact):(.*)$",
		"^###cb:(/muteforward):(.*)$",
		"^###cb:(/version):(.*)$",
		"^###cb:(/setflood):(.*)$",
		"^###cb:(/floodup):(.*)$",
		"^###cb:(/flooddown):(.*)$",
		"^###cb:(/charup):(.*)$",
		"^###cb:(/chardown):(.*)$",
		"^###cb:(/floodtimeup):(.*)$",
		"^###cb:(/floodtimedown):(.*)$",
		"^###cb:(/moresettings):(.*)$",
		"^###cb:(/more):(.*)$",
		"^###cb:(/ownerlist):(.*)$",
		"^###cb:(/cleanowners):(.*)$",
		"^###cb:(/modlist):(.*)$",
		"^###cb:(/cleanmods):(.*)$",
		"^###cb:(/bans):(.*)$",
		"^###cb:(/satellite):(.*)$",
		"^###cb:(/tv):(.*)$",
		"^###cb:(/megaplus):(.*)$",
		"^###cb:(/shopping):(.*)$",
		"^###cb:(/support):(.*)$",
		"^###cb:(/reminder):(.*)$",
		"^###cb:(/helpen):(.*)$",
		"^###cb:(/helpfa):(.*)$",
		"^###cb:(/cleanbans):(.*)$",
		"^###cb:(/filterlist):(.*)$",
		"^###cb:(/cleanfilterlist):(.*)$",
		"^###cb:(/whitelist):(.*)$",
		"^###cb:(/cleanwhitelist):(.*)$",
		"^###cb:(/silentlist):(.*)$",
		"^###cb:(/sajjad):(.*)$",
		"^###cb:(/features):(.*)$",
		"^###cb:(/cardnumber):(.*)$",
		"^###cb:(/botrules):(.*)$",
		"^###cb:(/nerkh):(.*)$",
		"^###cb:(/helplock):(.*)$",
		"^###cb:(/helplockfa):(.*)$",
		"^###cb:(/helpsudo):(.*)$",
		"^###cb:(/helpsudofa):(.*)$",
		"^###cb:(/helpmedia):(.*)$",
		"^###cb:(/helpmediafa):(.*)$",
		"^###cb:(/helpfun):(.*)$",
		"^###cb:(/helpfunfa):(.*)$",
		"^###cb:(/helpport):(.*)$",
		"^###cb:(/helpportfa):(.*)$",
		"^###cb:(/helpadd):(.*)$",
		"^###cb:(/helpaddfa):(.*)$",
		"^###cb:(/helpmod):(.*)$",
		"^###cb:(/helpmodfa):(.*)$",
		"^###cb:(/helpclean):(.*)$",
		"^###cb:(/helpcleanfa):(.*)$",
		"^###cb:(/cleansilentlist):(.*)$",
		"^###cb:(/link):(.*)$",
		"^###cb:(/rules):(.*)$",
		"^###cb:(/cleanrules):(.*)$",
		"^###cb:(/exit):(.*)$",
		"^###cb:(/whitelists):(.*)$",
		"^###cb:(/cleanwhitelists):(.*)$",
		"^###cb:(/showwlc):(.*)$",
		"^###cb:(/cleanwlcmsg):(.*)$",

	},
	run=run,
	pre_process=pre_process
}
