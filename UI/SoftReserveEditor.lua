-------------------------------------------------
-- Soft Reserve Editor (The Add / Edit Form)
--
-- The form the Summary window's "Add Soft Reserve" and
-- per-player "Edit" buttons open, in place of the reserve
-- cards (same window, same pane -- not a popup). It only
-- ever edits one player's entry in the window's DRAFT; the
-- real reserve list isn't touched until Save on the main
-- reserve page (see SummaryWindow:SaveEdits).
--
-- Fields: name, optional note, class, optional spec, and
-- the items -- found with the same search the loot panel
-- uses, narrowed by a raid and a difficulty dropdown (each
-- difficulty of an item has its own item ID, so picking the
-- raid + difficulty is what makes the stored ID the right
-- one).
-------------------------------------------------

ImpLoot.UI = ImpLoot.UI or {}
ImpLoot.UI.SoftReserveEditor = ImpLoot.UI.SoftReserveEditor or {}
local Editor = ImpLoot.UI.SoftReserveEditor

local SEARCH_ROWS = 6
local SEARCH_ROW_HEIGHT = 18
local ITEM_ROW_HEIGHT = 20

-- Row heights follow the text, not a fixed size: a long item name
-- wraps onto a second line, and the row has to grow by that line or
-- it crowds the next one. Height = the text's own height + a fixed
-- padding, so a two-line row has exactly the same clearance below
-- it as a one-line row.
local SEARCH_ROW_PADDING = 6
local ITEM_ROW_PADDING = 8

-- The results panel floats over the chosen-items list; this keeps
-- it clear of the message line and Done / Cancel below.
local MAX_RESULTS_HEIGHT = 138

local function TextHeight(fontString)

    local height = fontString:GetStringHeight()

    -- Not measurable yet (font not loaded): assume one line
    if not height or height < 8 then
        return 12
    end

    return height

end
local RIGHT_COLUMN_X = 196

-------------------------------------------------
-- Helpers
-------------------------------------------------

local function ColorText(text, r, g, b)

    return string.format(
        "|cff%02x%02x%02x%s|r",
        math.floor((r or 1) * 255 + 0.5),
        math.floor((g or 1) * 255 + 0.5),
        math.floor((b or 1) * 255 + 0.5),
        text
    )

end

local function ClassText(class)

    local r, g, b = ImpLoot.Theme:GetClassColor(class)

    return ColorText(class, r, g, b)

end

-- A comparable summary of a form: used to tell whether
-- Done actually changed anything (so opening Edit and
-- immediately pressing Done doesn't count as an edit), and
-- whether closing the window would throw something away.
local function Signature(name, note, class, spec, items)

    local ids = {}

    for _, item in ipairs(items) do
        table.insert(ids, tostring(item.ItemID))
    end

    table.sort(ids)

    return table.concat({
        name or "", note or "", class or "", spec or "",
        table.concat(ids, ","),
    }, "|")

end

-------------------------------------------------
-- Initialize
-------------------------------------------------

function Editor:Initialize(window, parent)

    self.Window = window

    local frame = CreateFrame("Frame", "ImpLootSREditorFrame", parent)
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -34)
    frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
    frame:Hide()

    self.Frame = frame

    local function MakeLabel(text, x, y)

        local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("TOPLEFT", frame, "TOPLEFT", x, y)
        label:SetText(text)

        return label

    end

    local function MakeEditBox(name, x, y, width)

        local box = CreateFrame("EditBox", name, frame, "InputBoxTemplate")
        box:SetAutoFocus(false)
        box:SetSize(width, 20)
        box:SetPoint("TOPLEFT", frame, "TOPLEFT", x + 6, y)
        box:SetMaxLetters(64)
        box:SetScript("OnEscapePressed", function(b) b:ClearFocus() end)

        return box

    end

    -- Dropdowns use WoW's own template, same as the options
    -- panel. `choices()` returns { { Text, Value }, ... }.
    local function MakeDropdown(name, x, y, width, choices, getValue, onSelect)

        local dropdown = CreateFrame("Frame", name, frame, "UIDropDownMenuTemplate")
        dropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", x - 16, y)

        UIDropDownMenu_SetWidth(dropdown, width)

        UIDropDownMenu_Initialize(dropdown, function(_, level)

            for _, choice in ipairs(choices()) do

                local info = UIDropDownMenu_CreateInfo()

                info.text = choice.Text
                info.checked = (getValue() == choice.Value)

                info.func = function()
                    onSelect(choice.Value)
                    UIDropDownMenu_SetText(dropdown, choice.Text)
                end

                UIDropDownMenu_AddButton(info, level)

            end

        end)

        return dropdown

    end

    -------------------------------------------------
    -- Name / Note
    -------------------------------------------------

    MakeLabel("Name", 0, 0)
    self.NameBox = MakeEditBox("ImpLootSREditorNameBox", 0, -14, 176)

    MakeLabel("Note (optional)", RIGHT_COLUMN_X, 0)
    self.NoteBox = MakeEditBox("ImpLootSREditorNoteBox", RIGHT_COLUMN_X, -14, 176)

    -------------------------------------------------
    -- Class / Spec
    -------------------------------------------------

    MakeLabel("Class", 0, -42)

    self.ClassDropdown = MakeDropdown(
        "ImpLootSREditorClassDropdown", 0, -54, 140,
        function() return self:GetClassChoices() end,
        function() return self.Form and self.Form.Class end,
        function(class) self:SetClass(class) end
    )

    MakeLabel("Specialization (optional)", RIGHT_COLUMN_X, -42)

    self.SpecDropdown = MakeDropdown(
        "ImpLootSREditorSpecDropdown", RIGHT_COLUMN_X, -54, 140,
        function() return self:GetSpecChoices() end,
        function() return self.Form and self.Form.Spec end,
        function(spec) self.Form.Spec = spec end
    )

    -------------------------------------------------
    -- Raid / Difficulty (these narrow the item search)
    -------------------------------------------------

    MakeLabel("Raid", 0, -90)

    self.RaidDropdown = MakeDropdown(
        "ImpLootSREditorRaidDropdown", 0, -102, 140,
        function() return self:GetRaidChoices() end,
        function() return self.Form and self.Form.Raid end,
        function(raid)
            self.Form.Raid = raid
            self:UpdateSearch()
        end
    )

    MakeLabel("Difficulty", RIGHT_COLUMN_X, -90)

    self.DifficultyDropdown = MakeDropdown(
        "ImpLootSREditorDifficultyDropdown", RIGHT_COLUMN_X, -102, 140,
        function() return self:GetDifficultyChoices() end,
        function() return self.Form and self.Form.Difficulty end,
        function(key)
            self.Form.Difficulty = key
            self:UpdateSearch()
        end
    )

    -------------------------------------------------
    -- Item Search
    -------------------------------------------------

    self.ItemsLabel = MakeLabel("Soft reserves", 0, -138)

    local searchBox = MakeEditBox("ImpLootSREditorSearchBox", 0, -152, 364)
    self.SearchBox = searchBox

    searchBox:SetScript("OnTextChanged", function()
        self:UpdateSearch()
    end)

    searchBox:SetScript("OnEnterPressed", function()

        local first = self.CurrentResults and self.CurrentResults[1]

        if first then
            self:AddItem(first)
        end

    end)

    searchBox:SetScript("OnEscapePressed", function(box)
        box:SetText("")
        box:ClearFocus()
    end)

    self.SearchHint = MakeLabel("Type at least 2 letters of an item's name", 4, -176)
    self.SearchHint:SetTextColor(0.6, 0.6, 0.6)

    -------------------------------------------------
    -- Chosen Items (scrolls if the limit is high)
    -------------------------------------------------

    local itemsScroll = CreateFrame(
        "ScrollFrame",
        "ImpLootSREditorItemsScroll",
        frame,
        "UIPanelScrollFrameTemplate"
    )

    itemsScroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -176)
    itemsScroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -22, 56)

    local itemsChild = CreateFrame("Frame", nil, itemsScroll)
    itemsChild:SetWidth(352)
    itemsChild:SetHeight(1)

    itemsScroll:SetScrollChild(itemsChild)

    ImpLoot.Theme:ApplyDrawerStyleScrollIndicators(itemsScroll)

    itemsScroll:EnableMouseWheel(true)

    itemsScroll:SetScript("OnMouseWheel", function(sf, delta)

        local newPosition = sf:GetVerticalScroll() - (delta * 20)
        local maximum = sf:GetVerticalScrollRange()

        if newPosition < 0 then newPosition = 0 end
        if newPosition > maximum then newPosition = maximum end

        sf:SetVerticalScroll(newPosition)

        if sf.UpdateScrollIndicators then
            sf:UpdateScrollIndicators()
        end

    end)

    self.ItemsScroll = itemsScroll
    self.ItemsChild = itemsChild
    self.ItemRows = {}

    -------------------------------------------------
    -- Search Results (floats over the chosen items)
    -------------------------------------------------

    local results = CreateFrame("Frame", nil, frame)
    results:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -174)
    results:SetSize(364, (SEARCH_ROWS * SEARCH_ROW_HEIGHT) + 8)
    results:SetFrameLevel(frame:GetFrameLevel() + 20)
    results:Hide()

    ImpLoot.Theme:ApplyPanelStyle(results)

    self.Results = results
    self.ResultRows = {}

    local emptyText = results:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    emptyText:SetPoint("TOPLEFT", results, "TOPLEFT", 8, -8)
    emptyText:SetText("No matching items for this raid, difficulty and class.")
    emptyText:SetTextColor(0.6, 0.6, 0.6)
    emptyText:Hide()

    self.EmptyText = emptyText

    for i = 1, SEARCH_ROWS do

        local row = CreateFrame("Button", nil, results)
        row:SetHeight(SEARCH_ROW_HEIGHT)
        row:SetPoint("TOPLEFT", results, "TOPLEFT", 4, -4 - ((i - 1) * SEARCH_ROW_HEIGHT))
        row:SetPoint("RIGHT", results, "RIGHT", -4, 0)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

        local bossText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        bossText:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        bossText:SetJustifyH("RIGHT")
        bossText:SetTextColor(0.6, 0.6, 0.6)

        local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        nameText:SetPoint("LEFT", row, "LEFT", 4, 0)
        nameText:SetWidth(220)
        nameText:SetJustifyH("LEFT")

        row.NameText = nameText
        row.BossText = bossText

        row:SetScript("OnClick", function()
            if row.Result then
                self:AddItem(row.Result)
            end
        end)

        row:Hide()

        self.ResultRows[i] = row

    end

    -------------------------------------------------
    -- Message Line / Buttons
    -------------------------------------------------

    local message = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    message:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 28)
    message:SetWidth(364)
    message:SetJustifyH("LEFT")

    self.Message = message

    local doneButton = ImpLoot.Theme:CreateMenuButton(frame)
    doneButton:SetSize(80, 22)
    doneButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
    doneButton:SetText("Done")
    doneButton:SetScript("OnClick", function() self:Done() end)

    local cancelButton = ImpLoot.Theme:CreateMenuButton(frame)
    cancelButton:SetSize(80, 22)
    cancelButton:SetPoint("LEFT", doneButton, "RIGHT", 6, 0)
    cancelButton:SetText("Cancel")
    cancelButton:SetScript("OnClick", function() self:Close() end)

end

-------------------------------------------------
-- Dropdown Choices
-------------------------------------------------

function Editor:GetClassChoices()

    local choices = {}

    for _, class in ipairs(ImpLoot.SoftReserve.ClassOrder) do
        table.insert(choices, { Text = ClassText(class), Value = class })
    end

    return choices

end

function Editor:GetSpecChoices()

    local choices = { { Text = "None", Value = "" } }

    local form = self.Form
    local class = form and form.Class
    local specs = class and ImpLoot.SoftReserve.ClassSpecs[class] or {}

    local seen = {}

    for _, spec in ipairs(specs) do
        seen[spec] = true
        table.insert(choices, { Text = spec, Value = spec })
    end

    -- An imported spec we don't have in our list (the CSV's
    -- own wording) stays selectable rather than being lost.
    if form and form.Spec and form.Spec ~= "" and not seen[form.Spec] then
        table.insert(choices, { Text = form.Spec, Value = form.Spec })
    end

    return choices

end

function Editor:GetRaidChoices()

    local choices = { { Text = "All raids", Value = false } }

    for _, raid in ipairs(ImpLoot.Data or {}) do
        table.insert(choices, { Text = raid.Name, Value = raid })
    end

    return choices

end

function Editor:GetDifficultyChoices()

    local choices = {}

    for _, choice in ipairs(ImpLoot.SoftReserve.DifficultyChoices) do
        table.insert(choices, { Text = choice.Label, Value = choice.Key })
    end

    return choices

end

-- The text shown on each dropdown for the form's current values
function Editor:RefreshDropdownTexts()

    local form = self.Form

    UIDropDownMenu_SetText(
        self.ClassDropdown,
        form.Class and ClassText(form.Class) or "Choose class"
    )

    UIDropDownMenu_SetText(
        self.SpecDropdown,
        (form.Spec and form.Spec ~= "") and form.Spec or "None"
    )

    UIDropDownMenu_SetText(
        self.RaidDropdown,
        form.Raid and form.Raid.Name or "All raids"
    )

    local difficultyText = form.Difficulty

    for _, choice in ipairs(ImpLoot.SoftReserve.DifficultyChoices) do

        if choice.Key == form.Difficulty then
            difficultyText = choice.Label
        end

    end

    UIDropDownMenu_SetText(self.DifficultyDropdown, difficultyText)

end

function Editor:SetClass(class)

    local form = self.Form
    local changed = (class ~= form.Class)

    -- A spec belongs to its class -- drop it when the class
    -- changes and it isn't one of the new class's. (Picking the
    -- same class again keeps whatever spec is there, including
    -- an imported one we don't have in our own list.)
    if changed then

        local valid = false

        for _, spec in ipairs(ImpLoot.SoftReserve.ClassSpecs[class] or {}) do
            if spec == form.Spec then valid = true end
        end

        if not valid then
            form.Spec = ""
        end

    end

    form.Class = class

    self:RefreshDropdownTexts()
    self:UpdateSearch()

end

-------------------------------------------------
-- Open
--
-- `existing` is the draft player being edited, or nil to
-- add someone new.
-------------------------------------------------

function Editor:Open(existing)

    local SoftReserve = ImpLoot.SoftReserve
    local draft = self.Window.Draft

    local form = {
        Existing = existing,
        Class = existing and existing.Class or nil,
        Spec = existing and existing.Spec or "",
        Items = {},
    }

    if existing then

        for _, item in ipairs(existing.Items) do

            table.insert(form.Items, {
                ItemID = item.ItemID,
                ItemName = item.ItemName,
                Boss = item.Boss,
                Plus = item.Plus,
                Date = item.Date,
            })

        end

    end

    -- Start the search where most of the current reserves are
    local raid, difficulty = SoftReserve:GuessRaidAndDifficulty(draft)

    form.Raid = raid or false
    form.Difficulty = difficulty or "10"

    self.Form = form

    self.NameBox:SetText(existing and existing.Player or "")
    self.NoteBox:SetText((existing and existing.Note) or "")
    self.SearchBox:SetText("")

    self.OriginalSignature = Signature(
        existing and existing.Player or "",
        (existing and existing.Note) or "",
        form.Class, form.Spec, form.Items
    )

    self.Message:SetText("")

    self.Window.Title:SetText(existing and "Edit soft reserve" or "Add soft reserve")

    self.Frame:Show()

    self:RefreshDropdownTexts()
    self:RefreshItems()
    self:UpdateSearch()

end

-------------------------------------------------
-- Name From The Box
--
-- Normalised the way a typed name should be -- except an
-- existing player's name left untouched, which stays exactly
-- as it was imported.
-------------------------------------------------

function Editor:GetName()

    local typed = self.NameBox:GetText() or ""
    local trimmed = typed:gsub("^%s+", "")
    trimmed = trimmed:gsub("%s+$", "")

    local form = self.Form

    if form and form.Existing and trimmed == form.Existing.Player then
        return trimmed
    end

    return ImpLoot.SoftReserve:NormalizeName(typed)

end

-------------------------------------------------
-- Has Changes
--
-- Whether the form differs from how it was opened.
-------------------------------------------------

function Editor:HasChanges()

    local form = self.Form

    if not form then
        return false
    end

    local current = Signature(
        self:GetName(),
        self.NoteBox:GetText(),
        form.Class, form.Spec, form.Items
    )

    return current ~= self.OriginalSignature

end

-------------------------------------------------
-- Search Hint
--
-- The "type 2+ letters" prompt sits where the first chosen
-- item would be, so it only shows while nothing's been chosen
-- yet and nothing's being searched for.
-------------------------------------------------

function Editor:UpdateHint()

    local text = self.SearchBox:GetText() or ""

    if #text < 2 and self.Form and #self.Form.Items == 0 then
        self.SearchHint:Show()
    else
        self.SearchHint:Hide()
    end

end

-------------------------------------------------
-- Item Search
-------------------------------------------------

function Editor:HideResults()

    self.CurrentResults = nil

    self.Results:Hide()
    self.EmptyText:Hide()

    for _, row in ipairs(self.ResultRows) do
        row:Hide()
    end

end

function Editor:UpdateSearch()

    if not self.Form then
        return
    end

    local text = self.SearchBox:GetText() or ""

    if #text < 2 then
        self:HideResults()
        self:UpdateHint()
        return
    end

    self.SearchHint:Hide()

    local raid = self.Form.Raid

    if not raid then
        raid = nil
    end

    local results = ImpLoot.SoftReserve:SearchItems(
        text, raid, self.Form.Difficulty, SEARCH_ROWS, self.Form.Class
    )

    self.CurrentResults = results

    self.Results:Show()

    if #results == 0 then
        self.EmptyText:Show()
    else
        self.EmptyText:Hide()
    end

    local y = 0
    local shown = 0

    for i, row in ipairs(self.ResultRows) do

        local result = results[i]
        local placed = false

        if result then

            local r, g, b = ImpLoot.Theme:GetQualityColor(result.Quality)
            row.NameText:SetText(result.ItemName)
            row.NameText:SetTextColor(r, g, b)
            row.BossText:SetText(result.Boss or "")

            local height = TextHeight(row.NameText) + SEARCH_ROW_PADDING

            -- Always show the first result; after that, only what
            -- fits above the buttons (refine the search for more).
            if shown == 0 or (y + height) <= MAX_RESULTS_HEIGHT then

                row.Result = result

                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", self.Results, "TOPLEFT", 4, -4 - y)
                row:SetPoint("TOPRIGHT", self.Results, "TOPRIGHT", -4, -4 - y)
                row:SetHeight(height)
                row:Show()

                y = y + height
                shown = shown + 1
                placed = true

            end

        end

        if not placed then
            row.Result = nil
            row:Hide()
        end

    end

    self.Results:SetHeight(math.max(y, SEARCH_ROW_HEIGHT) + 8)

end

-------------------------------------------------
-- Add / Remove Item
-------------------------------------------------

function Editor:AddItem(result)

    local SoftReserve = ImpLoot.SoftReserve
    local form = self.Form

    local max = SoftReserve:GetMaxReserves()

    if max > 0 and #form.Items >= max then
        self.Message:SetText("|cffff5555Limit reached -- " .. max .. " reserves per player.|r")
        return
    end

    if SoftReserve:GetSettings().AllowMultipleReserves == false then

        for _, item in ipairs(form.Items) do

            if item.ItemID == result.ItemID then
                self.Message:SetText("|cffff5555Already reserved -- reserving the same item more than once is turned off.|r")
                return
            end

        end

    end

    table.insert(form.Items, {
        ItemID = result.ItemID,
        ItemName = result.ItemName,
        Boss = result.Boss,
        Plus = 0,
    })

    self.Message:SetText("")
    self.SearchBox:SetText("")

    self:HideResults()
    self:RefreshItems()

end

function Editor:RemoveItem(index)

    table.remove(self.Form.Items, index)

    self.Message:SetText("")
    self:RefreshItems()

end

-------------------------------------------------
-- Chosen Items List
-------------------------------------------------

function Editor:AcquireItemRow(index)

    local row = self.ItemRows[index]

    if row then
        return row
    end

    row = CreateFrame("Frame", nil, self.ItemsChild)
    row:SetSize(352, ITEM_ROW_HEIGHT)

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(16, 16)
    icon:SetPoint("LEFT", row, "LEFT", 2, 0)
    row.Icon = icon

    local removeButton = ImpLoot.Theme:CreateMenuButton(row)
    removeButton:SetSize(20, 16)
    removeButton:SetPoint("RIGHT", row, "RIGHT", -2, 0)
    removeButton:SetText("x")
    removeButton:SetScript("OnClick", function()
        self:RemoveItem(row.Index)
    end)
    row.RemoveButton = removeButton

    local detailText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    detailText:SetPoint("RIGHT", removeButton, "LEFT", -6, 0)
    detailText:SetJustifyH("RIGHT")
    detailText:SetTextColor(0.6, 0.6, 0.6)
    row.DetailText = detailText

    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    nameText:SetPoint("LEFT", icon, "RIGHT", 4, 0)
    nameText:SetWidth(190)
    nameText:SetJustifyH("LEFT")
    row.NameText = nameText

    self.ItemRows[index] = row

    return row

end

function Editor:RefreshItems()

    local form = self.Form
    local max = ImpLoot.SoftReserve:GetMaxReserves()

    if max > 0 then
        self.ItemsLabel:SetText("Soft reserves (" .. #form.Items .. "/" .. max .. ")")
    else
        self.ItemsLabel:SetText("Soft reserves (" .. #form.Items .. ")")
    end

    for _, row in ipairs(self.ItemRows) do
        row:Hide()
    end

    local y = 0

    for i, item in ipairs(form.Items) do

        local row = self:AcquireItemRow(i)
        row.Index = i

        local cached = ImpLoot.ItemCache:GetItem(item.ItemID)

        if cached and cached.Texture then
            row.Icon:SetTexture(cached.Texture)
            row.Icon:Show()
        else
            row.Icon:Hide()
        end

        local r, g, b = ImpLoot.Theme:GetQualityColor(cached and cached.Quality)
        row.NameText:SetText(item.ItemName or (cached and cached.Name) or ("Item " .. item.ItemID))
        row.NameText:SetTextColor(r, g, b)

        -- Which raid and difficulty this is, so two versions of
        -- the same item can be told apart
        local known = ImpLoot.Database:FindItemByID(item.ItemID)
        local detail = ""

        if known and known.Raid then
            detail = known.Raid.Name .. (known.Difficulty and (" " .. known.Difficulty) or "")
        end

        row.DetailText:SetText(detail)

        local height = math.max(TextHeight(row.NameText) + ITEM_ROW_PADDING, 16)

        row:SetHeight(height)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", self.ItemsChild, "TOPLEFT", 0, -y)
        row:Show()

        y = y + height

    end

    if #form.Items == 0 and form.Existing then
        self.Message:SetText("|cffaaaaaaNo items left -- Done will remove this player.|r")
    end

    self:UpdateHint()

    self.ItemsChild:SetHeight(math.max(y, 1))

    if self.ItemsScroll.UpdateScrollChildRect then
        self.ItemsScroll:UpdateScrollChildRect()
    end

    if self.ItemsScroll.UpdateScrollIndicators then
        self.ItemsScroll:UpdateScrollIndicators()
    end

end

-------------------------------------------------
-- Done / Close
-------------------------------------------------

function Editor:Done()

    local SoftReserve = ImpLoot.SoftReserve
    local form = self.Form
    local draft = self.Window.Draft

    local entry = {
        Player = self:GetName(),
        Class = form.Class,
        Spec = form.Spec or "",
        Note = self.NoteBox:GetText() or "",
        Items = form.Items,
    }

    -- Taking every item off an existing player removes them --
    -- a name with nothing reserved is pointless.
    if form.Existing and #entry.Items == 0 then

        SoftReserve:DraftRemovePlayer(draft, form.Existing)
        self.Window:MarkDirty()
        self:Close()

        return

    end

    local ok, message = SoftReserve:ValidatePlayerEntry(draft, entry, form.Existing)

    if not ok then
        self.Message:SetText("|cffff5555" .. message .. "|r")
        return
    end

    if not form.Existing or self:HasChanges() then
        SoftReserve:DraftSetPlayer(draft, form.Existing, entry)
        self.Window:MarkDirty()
    end

    self:Close()

end

-- Back to the reserve page, whether Done applied something
-- or Cancel didn't.
function Editor:Close()

    self:Abort()
    self.Window:OnEditorClosed()

end

-- Drop the form without telling the window (used when the
-- window itself is closing or discarding everything).
function Editor:Abort()

    self.Form = nil

    if self.SearchBox then
        self.SearchBox:ClearFocus()
    end

    if self.Results then
        self:HideResults()
    end

    if self.Frame then
        self.Frame:Hide()
    end

end
