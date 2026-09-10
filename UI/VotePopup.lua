-------------------------------------------------
-- Loot Council Vote Popup
--
-- Shown only to actual council members -- Comms.lua
-- already checked membership before firing
-- "ShowVotePopup". One button per candidate slot
-- (up to 5); clicking one casts the vote and closes.
-- Class-type slots show as "Any <Class>" since there's
-- no specific player attached to that slot.
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.VotePopup = ImpLoot.UI.VotePopup or {}
local VotePopup = ImpLoot.UI.VotePopup

-------------------------------------------------
-- Initialize
-------------------------------------------------

function VotePopup:Initialize()

    self.Pending = {}

    local frame = CreateFrame("Frame", "ImpLootVotePopup", UIParent)
    self.Frame = frame

    frame:SetSize(220, 180)
    frame:SetPoint("TOP", 0, -340)
    frame:SetFrameStrata("DIALOG")

    ImpLoot.Theme:ApplyPanelStyle(frame)

    frame:Hide()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -10)
    title:SetTextColor(
        ImpLoot.Theme.Colors.Text[1],
        ImpLoot.Theme.Colors.Text[2],
        ImpLoot.Theme.Colors.Text[3]
    )
    self.TitleText = title

    local reasonText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    reasonText:SetPoint("TOP", title, "BOTTOM", 0, -6)
    reasonText:SetText("Loot Council vote -- pick a winner:")
    self.ReasonText = reasonText

    self.CandidateButtons = {}

    for i = 1, 5 do

        local button = ImpLoot.Theme:CreateMenuButton(frame)
        button:SetSize(180, 22)

        if i == 1 then
            button:SetPoint("TOP", reasonText, "BOTTOM", 0, -10)
        else
            button:SetPoint("TOP", self.CandidateButtons[i - 1], "BOTTOM", 0, -4)
        end

        button:Hide()

        self.CandidateButtons[i] = button

    end

    ImpLoot.Events:Register("ShowVotePopup", function(itemID, voteID, callerName, candidates)
        self:Enqueue(itemID, voteID, callerName, candidates)
    end)

end

-------------------------------------------------
-- Enqueue / Show Next
-------------------------------------------------

function VotePopup:Enqueue(itemID, voteID, callerName, candidates)

    table.insert(self.Pending, {
        ItemID = itemID,
        VoteID = voteID,
        CallerName = callerName,
        Candidates = candidates,
    })

    if not self.Frame:IsShown() then
        self:ShowNext()
    end

end

-------------------------------------------------
-- Candidate Display Label
-------------------------------------------------

local function candidateLabel(candidate)

    if candidate.Type == "Class" then
        return "Any " .. candidate.Value
    end

    return candidate.Value

end

function VotePopup:ShowNext()

    local next = table.remove(self.Pending, 1)

    if not next then
        self.Frame:Hide()
        return
    end

    self.Current = next

    local cached = ImpLoot.ItemCache:GetItem(next.ItemID)
    local displayName = (cached and cached.Name) or ("Item " .. next.ItemID)

    local r, g, b = ImpLoot.Theme:GetQualityColor(cached and cached.Quality)
    self.TitleText:SetText(displayName)
    self.TitleText:SetTextColor(r, g, b)

    for i, button in ipairs(self.CandidateButtons) do

        local candidate = next.Candidates[i]

        if candidate then

            button:SetText(candidateLabel(candidate))
            button:Show()

            button:SetScript("OnClick", function()
                self:CastVoteAndDismiss(candidate)
            end)

        else

            button:Hide()

        end

    end

    self.Frame:Show()

end

-------------------------------------------------
-- Cast Vote And Dismiss
-------------------------------------------------

function VotePopup:CastVoteAndDismiss(candidate)

    local current = self.Current

    if current then

        ImpLoot.Comms:SendVoteCast(
            current.VoteID,
            current.CallerName,
            candidate.Type,
            candidate.Value
        )

    end

    self:Dismiss()

end

function VotePopup:Dismiss()
    self.Current = nil
    self:ShowNext()
end
