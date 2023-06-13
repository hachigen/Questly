local sqlite3 = require("lsqlite3")

-- Open the database or create it if it doesn't exist
local db = sqlite3.open("questly.db")

-- Create the NPCs table
local createNpcsTable = [[
    CREATE TABLE IF NOT EXISTS npcs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        zoneName TEXT,
        invisibility_required INTEGER DEFAULT 0,
        ivu_required INTEGER DEFAULT 0,
        sos_required INTEGER DEFAULT 0,
        invisibility_sufficient INTEGER DEFAULT 0,
        ivu_sufficient INTEGER DEFAULT 0,
        sos_sufficient INTEGER DEFAULT 0,
        invisibility_not_required INTEGER DEFAULT 0,
        ivu_not_required INTEGER DEFAULT 0,
        sos_not_required INTEGER DEFAULT 0
    )
]]
db:exec(createNpcsTable)

-- Insert NPC data into the NPCs table
local insertNpcData = [[
    INSERT INTO npcs (name, zoneName, invisibility_required, ivu_required, sos_required, invisibility_sufficient, ivu_sufficient, sos_sufficient, invisibility_not_required, ivu_not_required, sos_not_required)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
]]
local npcData = {
    { "Ruppoc Rockjumper", "thulehouse1", 1, 1, 1, 0, 0, 0, 0, 0, 0 },
    -- Add more NPCs here
}

for _, npc in ipairs(npcData) do
    db:exec(insertNpcData, npc)
end

-- Create the Quests table
local createQuestsTable = [[
    CREATE TABLE IF NOT EXISTS quests (
        id INTEGER PRIMARY KEY,
        name TEXT,
        npcId INTEGER,
        requestPhrase TEXT,
        prerequisiteQuestId INTEGER,
        stage INTEGER,
        FOREIGN KEY (npcId) REFERENCES npcs (id),
        FOREIGN KEY (prerequisiteQuestId) REFERENCES quests (id)
    )
]]
db:exec(createQuestsTable)

-- Insert Quest data into the Quests table
local insertQuestData = [[
    INSERT INTO quests (name, npcId, requestPhrase, prerequisiteQuestId, stage)
    VALUES (?, ?, ?, ?, ?)
]]
local questData = {
    { "Thinning Out Their Numbers: Bone Crafters and Quaking Haunts", 1, "bone crafters", nil, 0 },
    { "Thinning Out Their Numbers: Rotdogs and Snakes", 1, "snakes", nil, 0 },
    { "Thinning Out Their Numbers: Skeletons and Bone Golems", 1, "skeletons", nil, 0 },
    { "Thinning Out Their Numbers: Terror Guards", 1, "terror guards", nil, 0 },
    { "Thinning Out Their Numbers: Terror Spinners and Sleeper Cubes", 1, "terror spinners", nil, 0 },
    -- Add more quests here
}

for _, quest in ipairs(questData) do
    db:exec(insertQuestData, quest)
end

-- Close the database connection
db:close()
