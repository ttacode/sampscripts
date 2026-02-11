SCRIPT_VERSION =  "3.4"

local sampev = require("lib.samp.events")

local requests = require("requests")

require "moonloader"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8
local function safeDecode(str)
    if str and type(str) == "string" then
        return u8:decode(str)
    else
        return ""
    end
end

title = safeDecode(title)

local bn = 0
local ln = 0
local sn = 0
local sdelay = 990

local UPDATE_URL = "https://raw.githubusercontent.com/ttacode/sampscripts/refs/heads/main/tnumb.lua"
local VERSION_URL = "https://raw.githubusercontent.com/ttacode/sampscripts/refs/heads/main/version.txt"

local findValue = {}

local dopValue = {
603,
555572,
2828381,
771,
9889,
2803400,
3030,
250,
2828006,
195,
244411,
555657,
100,
2829303,
121,
2825370,
2578833,
930,
911999,
78,
441,
557755,
2826835,
2714287,
7000,
2077625,
4944,
212,
1829438,
8800,
2828621,
1980347,
2709983,
400005,
2826328,
79,
25,
898,
5454,
31,
444,
1122,
570,
7474,
202021,
200000,
2527805,
3343,
708708,
158888,
3883,
992999,
299999,
888188,
343,
113011,
777977,
757,
555655,
890,
2080039,
779,
966969,
2827182,
541111,
6866,
303003,
666999,
66,
845,
500355,
2829292,
210,
669999,
45,
7373,
2810695,
512593,
123654,
424,
2710225,
2775306,
2756161,
770,
2606306,
370,
3999,
3500,
2444,
234,
132611,
112,
16,
123,
100000,
49,
335,
920,
551,
332,
3636,
3737,
884,
2546775,
555050,
999969,
2824830,
2815353,
566,
665,
552,
9900,
952,
2825720,
484444,
770700,
1551,
116611,
431,
232,
54,
661453,
400,
223332,
295000,
100002,
446444,
333002,
89,
494,
225,
336,
2004,
1228,
2823804,
232425,
1315,
2494900,
3200,
2827321,
2827318,
747,
2802699,
555888,
2612264,
1462122,
2824446,
507777,
554450,
6789,
560,
224444,
123452,
789,
2787544,
7007,
2717203,
666666,
2825686,
88,
2816245,
40,
388338,
2826817,
316,
1515,
6363,
2333,
119,
2750627,
2795657,
312,
2813775,
2829228,
662664,
9292,
904,
1555,
800100,
2810769,
4308,
7010,
2808240,
27,
101101,
3939,
2030,
292222,
150505,
2829335,
600700,
345,
9200,
311113
}


local function checkForUpdate()
    local ok, res = pcall(function()
        return requests.get(VERSION_URL)
    end)

    if not ok or not res or res.status_code ~= 200 then
        return
    end

    local remoteVersion = res.text:gsub("%s+", "")
    if remoteVersion == SCRIPT_VERSION then
		sampAddChatMessage("[TNUMB] Обновление не найдено", 0xA9A9A9)
        return
    end

    sampAddChatMessage("[TNUMB] Найдена свежая версия", 0x00FFCC)

    local file = requests.get(UPDATE_URL)
    if not file or file.status_code ~= 200 then
        sampAddChatMessage("[TNUMB] Ошибка загрузки файла", 0xA9A9A9)
        return
    end

    local f = io.open(thisScript().path, "w")
    if not f then
        sampAddChatMessage("[TNUMB] Не удалось перезаписать файл", 0xA9A9A9)
        return
    end

    f:write(u8:decode(file.text))
    f:close()

    sampAddChatMessage("[TNUMB] Скрипт обновлён, перезагрузка...", 0x00FFCC)
    thisScript():reload()
end

function main()
  repeat wait(0) until isSampAvailable()
  sampRegisterChatCommand("tnumb", cmd_tnumb)
  sampRegisterChatCommand("snumb", cmd_snumb)
  sampRegisterChatCommand("smsdelay", cmd_smsdelay)
	sampRegisterChatCommand("update", checkForUpdate)
	while not isSampAvailable() do wait(100) end
end



function sampev.onShowDialog(id, style, title, b1, b2, text)

if title:find('Сотрудники онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('.*_.*[%d+].*%d+.*{99b3ff}%d+') then
tnumber = line:match('.*_.*[%d+].*%d+.*{99b3ff}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Врачи онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Лицензеры онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Адвокаты онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end
end



function tnumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not findValue[znach] or bn == 0 then
			break
		end
	sampSendChat('/sms ' .. findValue[znach] .. ' task')
		wait(sdelay)
	end
end)
end

function snumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not dopValue[znach] or sn == 0 then
			break
		end
	sampSendChat('/sms ' .. dopValue[znach] .. ' task')
		wait(sdelay)
	end
end)
end

function cmd_tnumb(arg)
	if bn == 0 then
		bn = 1
		printStringNow('TASK NUMBERFIND ON', 1000)
	else
		bn = 0
		printStringNow('TASK NUMBERFIND OFF', 1000)
	end
end

function cmd_snumb(arg)
	if sn == 0 then
		sn = 1
		snumb()
		printStringNow('TASK FRESHNUMBER ON', 1000)
	else
		sn = 0
		printStringNow('TASK FRESHNUMBER OFF', 1000)
	end
end


function cmd_smsdelay(param)
		if tonumber(param) ~= nil then
			param = tonumber(param)
				if param < 500 or param > 5000 then
					sampAddChatMessage("Укажи корректную задержку (500-5000)", -1)
				else
					sampAddChatMessage('Delay '.. param .. ' ms', -1)
					sdelay = param
				end
		else
			sampAddChatMessage("Укажи задержку", -1)
		end
end
