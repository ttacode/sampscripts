SCRIPT_VERSION =  "2.5"

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
345677,
47,
2822001,
808080,
757000,
2825477,
211,
661453,
40,
1228,
2705882,
2825392,
2826008,
252550,
5557,
2823996,
2817862,
166665,
7333,
2888,
153153,
2232348,
86,
700001,
45,
776777,
38,
200202,
779,
733337,
3111,
5568,
456356,
2734390,
700,
474,
233333,
31,
555655,
9874,
2775306,
717777,
158888,
2709983,
9876,
91,
7071,
888666,
121,
4448,
344,
4777,
9871,
400,
332,
295,
774,
2675151,
3883,
7007,
2807842,
776677,
898,
2444,
4944,
330330,
2612264,
9200,
666777,
521555,
667,
9222,
9600,
210012,
939,
2714287,
888188,
343,
196,
900777,
7180,
2210,
999960,
884488,
133144,
448,
266666,
282828,
79,
4222,
899,
9997,
9909,
921421,
2748513,
770777,
2749093,
464444,
665,
111999,
557,
2826325,
111323,
8800,
333000,
2825223,
308,
350035,
2605114,
888,
770,
666999,
202021,
75,
1559907,
370,
2825700,
2241772,
2825409,
2803349,
2825890,
2811609,
633,
2525,
2825430,
990799,
815,
2826541,
2825376,
2825083,
1315,
2696465,
88,
666666,
730000,
2825859,
690,
170602,
111001,
333002,
999969,
2824599,
440,
111167,
1911,
902,
130370,
507777,
2517025,
444441,
3233,
148867,
3033,
2822011,
138877,
888887,
2817674,
201369,
431,
963,
2815357,
279,
119,
138138,
101011,
2798554,
484444,
371,
404,
2810671,
2807878,
111151,
234,
3737,
232,
551,
299999,
769,
123,
937999,
661,
335,
1133,
322,
1551,
6767,
552,
566,
112,
2802298,
3636,
2546775,
2817793,
151,
424,
555005,
7272,
966969,
4090,
404040,
2000197,
2305964,
866666,
1337,
555888,
878888,
80,
2818267,
383838,
111011,
7535,
152200,
333300,
5792,
855558,
204700,
2795291,
2824639,
4989,
5115,
54,
130037,
2825188,
2727,
775677,
152,
1281997,
756756,
2135514,
2232,
131555,
808707,
833383,
313133
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
	sampSendChat('/sms ' .. findValue[znach] .. ' tasks')
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
	sampSendChat('/sms ' .. dopValue[znach] .. ' Привет, улыбнись!')
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
