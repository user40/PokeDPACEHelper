
----------------------------------
-- Button
----------------------------------
local buttons = {
    -- constants
    duration = {stylus=2, button=2},
    topLeft = {x=45, y=60},
    buttonWidth = 33,
}
buttons.pos = {
    key0 = {"stylus", 0, 3},
    key1 = {"stylus", 0, 2},
    key2 = {"stylus", 1, 2},
    key3 = {"stylus", 2, 2},
    key4 = {"stylus", 0, 1},
    key5 = {"stylus", 1, 1},
    key6 = {"stylus", 2, 1},
    key7 = {"stylus", 0, 0},
    key8 = {"stylus", 1, 0},
    key9 = {"stylus", 2, 0},
    keyDot = {"stylus", 2, 3},
    keyC = {"stylus", 3, 0},
    keyAdd = {"stylus", 3, 1},
    keySub = {"stylus", 4, 1},
    keyMul = {"stylus", 3, 2},
    keyDiv = {"stylus", 4, 2},
    keyEq = {"stylus", 3, 3},
    keyX = {"button", "X"},
    keyY = {"button", "Y"},
    keyA = {"button", "A"},
    keyB = {"button", "B"},
    keyStart = {"button", "start"}
}

function buttons:click(key)
    if key == "nop" or key == nil then
        return
    end

    local pos = buttons.pos[key]
    if pos[1] == "stylus" then
        buttons.touch(pos)
    else
        buttons.push(pos)
    end
end

function buttons.push(pos)
    local tbl = {}
    tbl[pos[2]] = true
    joypad.set(tbl)
end

function buttons.touch(pos)
    local x = buttons.topLeft.x + pos[2] * buttons.buttonWidth
    local y = buttons.topLeft.y + pos[3] * buttons.buttonWidth
    stylus.write({x=x, y=y, touch=true})
end

----------------------------------
-- Interpreter
----------------------------------
local interpreter = {}
interpreter.dict = {
    ["1"] = "key1",
    ["2"] = "key2",
    ["0"] = "key0",
    ["3"] = "key3",
    ["4"] = "key4",
    ["5"] = "key5",
    ["6"] = "key6",
    ["7"] = "key7",
    ["8"] = "key8",
    ["9"] = "key9",
    ["."] = "keyDot",
    ["C"] = "keyC",
    ["+"] = "keyAdd",
    ["-"] = "keySub",
    ["*"] = "keyMul",
    ["/"] = "keyDiv",
    ["="] = "keyEq",
}
function interpreter.interpret(line, doRetire)
    if doRetire == nil then
        doRetire = true
    end

    local pat = "[^0-9%.C%+%-%*%/%=]"
    line = line:gsub(pat, "")

    local result = {}
    for i = 1, #line, 1 do
        local char = string.sub(line,i,i)
        result[4*i - 3] = interpreter.dict[char]
        result[4*i - 2] = interpreter.dict[char]
        result[4*i - 1] = "nop"
        result[4*i - 0] = "nop"
    end

    local len = #result
    result[len + 1] = "keyEq"
    result[len + 2] = "keyEq"
    result[len + 3] = "nop"
    result[len + 4] = "nop"
    
    if doRetire then
        local len = #result
        result[len + 1] = "keyX"
        result[len + 2] = "keyX"
        result[len + 3] = "nop"
        result[len + 4] = "nop"
        result[len + 5] = "keyA"
        result[len + 6] = "keyA"
        result[len + 7] = "nop"
        result[len + 8] = "nop"
        result[len + 9] = "keyA"
        result[len + 10] = "keyA"
        result[len + 11] = "nop"
        result[len + 12] = "nop"
    end

    return result
end
----------------------------------
-- Main
--------------------------------
local schedule = interpreter.interpret("12345678*12345678", false)

local function iter_factory(x)
    local pos = 0
    local length = #x
    return function()
        pos = pos + 1
        if pos > length then
            return nil
        else
            return x[pos]
        end
    end
end

local iter = iter_factory(schedule)

local function main()
    buttons:click(iter())
end

emu.registerbefore(main)