-- Required libraries
local sqlite3 = require("sql")
local mq = require("mq")

-- Database connection
local db = sqlite3.open("quests.db")

-- Function to retrieve all quests from the quests table
local function getQuests()
    local query = [[
        SELECT * FROM quests
    ]]
    local stmt = db:prepare(query)
    local quests = {}
    while stmt:step() == sqlite3.ROW do
        local quest = {
            id = stmt:get_value(1),
            npcName = stmt:get_value(2),
            npcX = stmt:get_value(3),
            npcY = stmt:get_value(4),
            npcZ = stmt:get_value(5),
            zoneName = stmt:get_value(6),
            invisRequired = stmt:get_value(7) == 1,
            ivuRequired = stmt:get_value(8) == 1,
            sosRequired = stmt:get_value(9) == 1,
            requestPhrase = stmt:get_value(10)
        }
        table.insert(quests, quest)
    end
    stmt:finalize()
    return quests
end

-- Function to check if a quest is completed
local function isQuestCompleted(questId)
    local query = [[
        SELECT COUNT(*) FROM completed_quests WHERE questId = ?
    ]]
    local stmt = db:prepare(query)
    stmt:bind_values(questId)
    local count = stmt:step() == sqlite3.ROW and stmt:get_value(0) or 0
    stmt:finalize()
    return count > 0
end

-- Function to mark a quest as completed
local function markQuestAsCompleted(questId)
    local query = [[
        INSERT INTO completed_quests (questId) VALUES (?)
    ]]
    local stmt = db:prepare(query)
    stmt:bind_values(questId)
    stmt:step()
    stmt:finalize()
end

-- Function to retrieve the prerequisites for a quest
local function getPrerequisites(questId)
    local query = [[
        SELECT prerequisiteId FROM quest_prerequisites WHERE questId = ?
    ]]
    local stmt = db:prepare(query)
    stmt:bind_values(questId)
    local prerequisites = {}
    while stmt:step() == sqlite3.ROW do
        table.insert(prerequisites, stmt:get_value(0))
    end
    stmt:finalize()
    return prerequisites
end

-- Add your logic to move to NPC and claim rewards
local function MoveToNpcAndClaimReward(quest)
    -- Implement your code here
    -- Use the quest object to access the quest information (npcName, npcX, npcY, etc.)
    -- Move to the NPC location and claim the rewards
end

-- Main loop
while true do
    -- Retrieve all quests from the database
    local quests = getQuests()

    -- Iterate over the quests
    for _, quest in ipairs(quests) do
        -- Check if the quest is completed
        local isCompleted = isQuestCompleted(quest.id)

        -- Check if all prerequisites are completed
        local prerequisites = getPrerequisites(quest.id)
        local allPrerequisitesCompleted = true
        for _, prerequisiteId in ipairs(prerequisites) do
            if not isQuestCompleted(prerequisiteId) then
                allPrerequisitesCompleted = false
                break
            end
        end

        -- If the quest is not completed and all prerequisites are completed, execute the logic
        if not isCompleted and allPrerequisitesCompleted then
            -- Execute the logic for the quest
            MoveToNpcAndClaimReward(quest)

            -- Mark the quest as completed
            markQuestAsCompleted(quest.id)
        end
    end

    -- Wait for a certain interval before checking again
    mq.wait(60)  -- Wait for 60 seconds
end
