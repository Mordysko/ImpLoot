<img width="1672" height="941" alt="ChatGPT Image Oct 5, 2026, 06_08_18 PM" src="https://github.com/user-attachments/assets/fc959020-fcf2-4cd4-8aef-ecfe6aa30379" />

# ImpLoot

A raid loot management addon for **World of Warcraft: Wrath of the Lich King (3.3.5a)**: loot planning, wishlists and priority lists, Loot Master rolls, and built-in Soft Reserve support.

> **This is a beta.** Expect rough edges. See [Feedback](#feedback) for where to report problems.

## Contents

- [Installation](#installation)
- [Good to know](#good-to-know)
- [For every player](#for-every-player)
- [A typical raid night](#a-typical-raid-night)
- [Assigning to someone who isn't present](#assigning-to-someone-who-isnt-present)
- [The Summary window](#the-summary-window)
- [Soft Reserves](#soft-reserves)
- [Loot Priority lists](#loot-priority-lists)
- [Other Loot Master features](#other-loot-master-features)
- [Slash commands](#slash-commands)
- [Feedback](#feedback)

## Installation

1. Copy the **ImpLoot** folder (the one containing `ImpLoot.toc`) into your WoW installation's `Interface\AddOns\` directory, so you end up with `Interface\AddOns\ImpLoot\ImpLoot.toc`. That folder is all the game needs; anything else in the download (such as a `.github` folder) is just for the GitHub page.
2. Enable **ImpLoot** from the AddOns list on the character select screen.
3. Log in. You'll see a brief "ImpLoot loaded successfully" message in chat.

## Good to know

### Master Looter

The Loot Master features (the queue, rolls, countdown timer, announcements, assignment) only activate for whoever is set as **Master Looter** through the raid's normal Loot Method options. ImpLoot doesn't grant or check this for you. If you're not the Master Looter, the Loot Master window simply won't appear when loot drops. That's expected.

### Hotkey (optional)

ImpLoot has no keybind setting of its own. Like any addon action, it's set through WoW's Key Bindings menu:

`Escape` → `Key Bindings` → `ImpLoot` → `Toggle Loot Master Window`

The window also opens automatically for the Master Looter when loot drops.

### How your data gets saved

Wishlists, priority lists, imported reserves and everything else ImpLoot stores are only written to disk on a proper logout, `/reload`, or exiting through the game menu. That's how WoW's SavedVariables work for every addon. Alt-F4 or a crash skips the save, so anything created since your last logout or reload would be lost. A quick `/reload` after finishing something you don't want to risk (like building a priority list) is a cheap safety net.

## For every player

You don't need to be the Master Looter to use ImpLoot. Everything in this section works for any player, on any character.

### Browsing loot

<img width="828" height="543" alt="Main Browsing Window" src="https://github.com/user-attachments/assets/e28943c2-4637-46ed-83b9-dea68f9b6b69" />

Open ImpLoot with `/il` (or left-click the minimap button). Pick a raid, then a difficulty (10, 25, 10 Heroic or 25 Heroic) and a boss to see everything it drops. The search box finds an item by name across every raid; click a result to jump straight to the boss that drops it. Within each section, gear you can equip is listed first, then tokens and other items, then quest items, then mounts, alphabetically in each.

Under the raid list are two buttons: raid size (**10 Man / 25 Man**) and difficulty (**Normal / Heroic**). They're in the same place for every raid; on raids with no Heroic mode the difficulty button stays greyed out on Normal. Trial of the Crusader, and Koralon in Vault of Archavon, drop different loot for each faction, so they also show a **Horde / Alliance** button beside the "Bosses" title.

Trial of the Crusader covers Heroic (Trial of the Grand Crusader) as well, including the **Argent Crusade Tribute** chest, listed after Anub'arak while Heroic is selected. Items that can drop from any boss, such as Runed Orbs in Ulduar or Trophies of the Crusade in Trial, are under the **Extra Drops** button below the boss list. In Vault of Archavon each boss has a **Mount** heading with both the Alliance and Horde mammoth.

### What you can do with an item

These work on any item in the loot list:

| Click | What it does |
|-------|--------------|
| `Shift`+click | Link the item in chat |
| `Ctrl`+click | Try it on in the dressing room |
| `Alt`+click | Add it to your active wishlist |

### Wishlists

<img width="227" height="373" alt="Wishlist Creation" src="https://github.com/user-attachments/assets/5bc4edf4-4ad1-40bc-8de9-dcb607dbb6b1" />
<img width="617" height="243" alt="Wishlist 1" src="https://github.com/user-attachments/assets/d81b3a06-0b0c-42c9-a87d-2aeb4e7335f0" />
<img width="617" height="243" alt="Wishlist 2" src="https://github.com/user-attachments/assets/a8b22c9b-ad56-4e7e-9e61-e31396dd179a" />

Open the planning tab on the right edge of the window and choose **Wishlist**.

- Make as many named wishlists as you like (for example "Ulduar - Discipline"), and rename or delete them whenever you want.
- Click a wishlist's name to make it your **active** one, marked with `>`. That's the one `Alt`+click adds to.
- An item added more than once shows its count (for example `x2`). `Alt`+click an item in the wishlist to remove one copy. Click an item to jump to the boss that drops it.
- Switch between **All Items**, **By Raid** (grouped by raid and difficulty, such as "Icecrown Citadel 10 - Heroic") and **By Slot**.

### Characters

The **Characters** page lists every character you've logged in with ImpLoot. Pick one to view and edit its wishlists from any character, which is handy for planning an alt's gear without logging onto it. Choosing a character here only changes which wishlist you're looking at; it never affects the character you're actually playing.

### Raid Planner

<img width="572" height="235" alt="Raid Planner" src="https://github.com/user-attachments/assets/f22b4753-f5d2-4f3e-b473-8e630336add2" />

The **Raid Planner** page answers "which raids do I still need to run?". It's a read-only list of everything you're after across **all** of the selected character's wishlists, grouped by raid (in release order), then difficulty, then boss in the order you fight them, with Trash and Extra Drops last. It doesn't use lockout data, so it shows everything you want rather than what you've already cleared this week.

### Compare

<img width="240" height="374" alt="Compare Window" src="https://github.com/user-attachments/assets/48deb25a-bf78-4052-b0fd-0d92c35bd23a" />

The **Compare** drawer is the tab on the left edge of the window. It holds two items side by side and shows the stat difference between them.

- While the drawer is open, `Alt`+click on an item in the loot list fills **slot 1**, and `Alt`+right-click fills **slot 2**. (This replaces `Alt`+click adding to your wishlist for as long as the drawer is open.)
- Click a slot to **lock** it so it isn't replaced, and click again to unlock. Right-click a slot to remove its item (a locked slot has to be unlocked first). `Ctrl`+click a slot to try the item on.
- Items have to fit the same slot to be compared. Main-hand, one-hand and two-hand weapons can be compared with each other.

### Raid Notes

The **Raid Notes** page keeps named, free-text notes for each character, handy for boss strategy reminders or your raid assignments. Create, rename and delete them like wishlists; the active note is edited in its own window.

### The "this one's yours" popup

<img width="252" height="117" alt="This Is Yours - Wishlist" src="https://github.com/user-attachments/assets/851bd951-5bc9-48bc-a2b0-09fb6248dfb7" />
<img width="244" height="116" alt="This Is Yours - Soft Reserve" src="https://github.com/user-attachments/assets/534aa780-f9ca-4795-9feb-5ea47c963dfb" />

When the Master Looter announces an item that's one of your Soft Reserves, or an open-roll item that's on one of your wishlists, a small popup appears with **Roll**, **Off-Spec Roll** and **Pass**. Roll makes a real roll for you, exactly as if you'd typed it (main spec 1-100, off spec 1-99). It only appears for items that matter to you, and several in a row wait their turn rather than stacking. The Master Looter needs to be running ImpLoot too for this to work.

## A typical raid night

*The rest of this guide, up to Slash commands, is for whoever is running loot as Master Looter.*

1. **Before raid:** if you're running Soft Reserves, open ImpLoot (`/il`), open the Soft Reserve window (the **Soft Reserve** button in the Loot Master window), click **Import CSV** and paste your SoftRes.it export. Both current SoftRes.it CSV formats are supported.
2. **Loot drops.** As Master Looter, the Loot Master window opens with the items in the queue. Nobody else in the raid sees it.
3. **Click Open Roll** on an item (**Announce** if it's Soft Reserved). This announces it to the raid, with the reserver names for a Soft Reserved item, and starts the roll timer. A live countdown shows next to the button.
4. **End the roll.** Let the timer run out, or click **Stop** to end it early. The winner is announced the moment the roll ends. Clicking Stop yourself always assigns the item to whoever is currently winning (if anyone has rolled), regardless of your Auto Assign setting.
5. **If the timer runs out on its own:** with Auto Assign on, the item goes to the winner automatically. With it off, or if nobody rolled, the item waits in "awaiting assignment" for you to hand out manually, including to a disenchanter if you've set one up.
6. **Loot Council items** skip the roll step. They're resolved by vote or by a pre-built priority list from the Priority Lists window.
7. **The Summary window** keeps a running log of everything resolved this session.

Only `/roll 1-100` (main spec) and `/roll 1-99` (off spec) count toward the standings. Any other range is ignored, and main spec always outranks off spec regardless of the number rolled.

**One roll at a time:** while an item is being rolled for, the **Open Roll** / **Announce** buttons on every other item are greyed out, and only that item's own **Stop** (or its timer) ends the roll. Copies of the same item rolled together count as one roll.

**Ties:** if two or more players share the best roll when the roll ends (or you click Stop), nobody wins yet. ImpLoot announces the tie and the tied players, and only they, roll again with a fresh timer; the Loot Master window shows *Tie reroll: …*. Another tie rerolls again. With several copies, players who clearly won a copy keep it and only the ones tied for the last copy reroll. The message is **Roll Tie (Reroll)** in **Options → Announcements**.

More detail is available in-game: each options category has its own description, and the About tab and `/il help` open the settings.

## Assigning to someone who isn't present

An item is only handed out through WoW's Master Loot system if the winner can actually receive it right now (in the raid and in range of the corpse). If they can't, ImpLoot doesn't error or get stuck: it records them as the winner, marks the item resolved, and flags it **(trade it)** in the queue. The chat message reads `Recorded -- trade this item to <name>.` That's your cue to trade or mail it to them yourself later.

## The Summary window

Open it with the **Summary** button on the Loot Master window. It opens to **Who won what**: a read-only table of Item / Winner / Roll, grouped by boss in that raid's encounter order. The Roll column shows `SR` for a Soft Reserve win, `LC` for Loot Council, `DE` for an item nobody rolled on that went to the disenchanter, or the winner's roll type (`MS` / `OS`) for an Open Roll. It fills itself in and updates as items resolve.

Winners are shown in their class colour. Hover a row for its details: how it was won (e.g. *Rolled 95 (MS)*, *Loot priority (Any Warrior)*, *Disenchant (no rolls)*), the boss, the raid with its size and difficulty (e.g. *Icecrown Citadel 25H*), the date and time, and who recorded it if that wasn't you. Entries saved before this version only have what was recorded at the time.

ImpLoot also reads the raid's "receives loot" chat lines (epic and better, inside a raid; emblems, Abyss Crystals, Frozen Orbs and Shadowfrost Shards are skipped), so the list builds up in everyone's copy of ImpLoot, not just the loot master's:

- An item ImpLoot assigned is marked as received once it's in the winner's bags (*Received* in the tooltip).
- Loot that didn't go through ImpLoot (a Need/Greed win, an item handed out by hand) is added, noted *Looted directly*, under the boss that drops it. If the item drops from more than one boss, the boss just killed is used. Anything no boss drops is listed as *Trash*.
- You only see chat lines for loot handed out near you, so a raider who was far away or disconnected can miss some.
- Turn it off in **Options → Loot Master → Record raid loot seen in chat**.

- **Post to raid** sends the list to raid chat.
- **Clear** starts a fresh *Who won what* for the next session. Nothing is lost: every entry stays in the loot history (see below).
- **Export** opens a small copyable box (`Ctrl+C`; WoW has no clipboard access). While it's open, the button at the bottom right switches between **Text** (grouped by boss, `Item - Winner (MS)`) and **CSV** (`Boss,Item,ItemID,Winner,Result`, for a spreadsheet). **Back** returns to the list.
- **History** turns this window into the loot history. Its **Back** button turns it back into *Who won what*.

The **Soft Reserve** button on the Loot Master window opens the same window straight to the soft reserve view instead: one card per player with their class-coloured spec and reserved items. The **By Player** / **By Boss** button next to **Import CSV** switches to one card per boss, in raid order, listing each reserved item with its reservers (class coloured, `x2` for a double reserve) underneath. A tier token appears under every boss that drops it. ImpLoot remembers which view you used last; editing always shows players. There's no Back button. That same button, or the window's close button, is the way out.

### The loot history

Everything ImpLoot has recorded, from every raid, not just the current session. Open it with **History** on the *Who won what* window (the window turns into the loot history, and **Back** turns it back) or `/il history`.

- Columns: Date, Item, Winner (class coloured), Result (`MS` / `OS` / `SR` / `LC` / `DE`), Boss and Raid. Click a column title to sort; click it again to reverse.
- **Search** finds an item, player, boss, raid, result or note. The two dropdowns filter by raid (e.g. *Icecrown Citadel 25H*) and period (today, last 7 or 30 days).
- Hover a row for its details. `Shift`+click it to link the item in chat.
- Right-click a row to change the winner, edit the note, set the Result tag, or delete it. An edited entry remembers who it was first recorded for, and when it was edited.
- **Export**: what's shown, one line per item. While the export is open, the **Export** button switches between **Text** and **CSV** (`Date,Time,Raid,Size,Difficulty,Boss,Item,ItemID,Winner,Result,Note`), and **Back** returns to the list. `Ctrl+C` to copy.
- **Delete...**: everything older than 30 days, or everything. It always says how many entries first and asks.

#### Sync

ImpLoot syncs your history with the raid by itself: it fills in loot from the last 7 days that other raiders running ImpLoot recorded and you missed (disconnected, too far away to see it, or joined late). The two raiders with the most entries send theirs.

- It only runs in a raid group (never a party): shortly after you log in, `/reload` or join a raid, then every 60 minutes while you're in one, never during combat. Set the minutes (0 = off) in **Options → Loot Master → Sync loot history every**. While it runs, the history window shows its progress next to the item count.
- Anything you already have isn't added again, even if it was recorded separately on both sides. Two copies won by the same player stay two entries.
- If someone changed an entry (winner, note, result), the most recent change wins.
- Entries you deleted aren't brought back (for 30 days).
- Right-click an entry and untick **Share in sync** to keep it to yourself.
- Only raiders on this version or newer can share history.

## Soft Reserves

### Importing

<img width="399" height="419" alt="Soft Reserves" src="https://github.com/user-attachments/assets/76542161-f4f6-4f2b-ac43-f03f708977df" />

- Open the Soft Reserve window and click **Import CSV** (top left; it is hidden while you are editing) and paste your SoftRes.it export. A counter under the button shows how many reserves are loaded and the date of the last import (the date you imported it in-game, not anything from the file). If you edit the list afterwards, the counter also shows the date of the last edit.
- The imported list is saved across reloads and logouts. Re-importing replaces it, while the session's win history is kept.
- Right after a successful import, ImpLoot offers to reload so the list is written to disk straight away. With **Options → Soft Reserve → Clear Who won what when reloading after an import** ticked (off by default), **Reload Now** also starts a fresh *Who won what*, like its **Clear** button. Nothing is lost: every entry stays in the loot history.

### Editing by hand

<img width="399" height="419" alt="Edit Soft Reserves" src="https://github.com/user-attachments/assets/e1cf58c4-2984-4d2a-a235-a3f2d351fd6d" />

The loot master can add, change and remove reserves without a new import: a late joiner, a wrong item, a change of mind. Open the Soft Reserve window and click **Edit Soft Reserves**.

- **Add Soft Reserve** and **Save** appear below the title, and every player's card gets an **Edit** button.
- Add / Edit open a form in the same window: name, optional note, class, optional specialization, and the items.
- Find items by typing part of the name, the same search the loot panel uses; click a match to add it. The **Raid** and **Difficulty** dropdowns narrow the search, and they matter: each difficulty of an item has a different item ID, so they decide which one gets reserved. They start on the raid and difficulty most current reserves are from. The search also follows the class you've picked: a tier token only shows for the class that can turn it in (a Druid is only offered the Vanquisher token), and class-locked gear only shows for its own class. With no class chosen yet, everything shows. Click the **x** on a row to take an item off.
- **Done** returns to the reserve page with that player updated; **Cancel** returns without changing anything. Taking every item off an existing player and pressing Done removes them.
- **Nothing is applied until you click Save** on the reserve page. Add and edit as many players as you like first. Save applies everything at once and shows a single reload prompt (WoW only writes saved data on a reload or logout), rather than one after every player. Afterwards the extra buttons disappear, leaving just **Edit Soft Reserves**.
- Unsaved changes are lost if you close the window; it warns you first. Importing a new CSV also discards unsaved edits, since they'd be based on the list it replaced.

The maximum number of items per player is a setting (**Options → Soft Reserve → Max reserves per player**, default 3, or *No limit*) because it differs from guild to guild. Match whatever your SoftRes.it page was set up with. It only applies to manual edits; an imported CSV is never checked against it. **Allow multiple reserves per item** is respected too: with it off, the form won't take the same item twice for one player.

### Sole reserver shortcut

When all of a Soft Reserved item's remaining reserves belong to one person (one slot or several via a Plus reserve), there's nothing to roll for. The queue row shows a one-click **Assign** instead of Announce. It still announces to chat first, so the raid knows who got it and why, and then assigns like any other winner (legendary confirmation included). As soon as a second person reserves the same item, it goes back to the normal Announce / roll flow.

### Multiple copies dropping together

When two or more copies of the same item drop from the same corpse, ImpLoot compares how many distinct people reserved it against how many copies dropped (this applies with **Allow multiple reserves** off):

- **Reservers ≤ copies:** no roll. One click assigns one copy to each reserver, with a single combined announcement. Any leftover copy is released to a plain Open Roll.
- **Reservers > copies:** one combined roll covering every copy, announced once as `[Item] x2` with one shared timer. Each person rolls once, and when the roll ends the top N different rollers (N = number of copies) each get one copy. Clicking **Stop** on any copy ends the roll for all of them.
- A **Plus** reserve counts as one extra chance to roll for that person, not an extra distinct reserver, so it never changes the comparison.

With **Allow multiple reserves** on, none of this applies: each copy is handled completely on its own, since the point of that setting is letting the same person win more than one copy.

Copies nobody reserved work the same way as a combined roll: the row shows *No SoftRes (2 copies -- one roll for all)*, and **Open Roll** on either copy starts one roll for both. For example, if Brad rolls 95, Moradladdy 80 and Knightdeath 40, Brad gets the first copy and Moradladdy the second.

### Absent reservers

Only people actually in the raid count as reservers: for the sole-reserver shortcut, the multiple-copies comparison, and the "Reserved by" text in the Loot Master window. Offline still counts as present (they're in the group and may reconnect). A sole reserver who is absent, or an item where every reserver is absent, falls back to a plain Open Roll. The chat announcement is the one place absent reservers are still named, marked like "Alice & (Carol - Absent) & Bob".

## Loot Priority lists

### The Loot Council / Priority window

Which list loot uses is chosen in the Loot Master window, with the button next to **Priority Lists**: pick a list, or **None** (it shows *No priority list*). With None, no item is handled by a priority list. Use that when raiding with a group your lists weren't made for. Choosing a list in the Loot Council / Priority window only picks which one you're editing; the one in use is marked *(active)* there. Items still waiting in the queue are sorted again when you change it.

The list controls run across the top: pick a **List**, create a **New list**, and **Add Item** / **Import Text** / **Export Text**. Below them, the list's items are on the left (icon and item name in its quality colour, then the mode and candidates) and the editor for the selected item is on the right. The item being edited is highlighted, with its names in gold.

**Add Item** opens a small panel:

- Type at least 2 letters of an item's name and matching items appear underneath, the same as adding a soft reserve. Each version is its own line with its boss and size (e.g. *Mimiron  25*, *… 25H*), and items from the raid this list is for come first; ones already on the list say so. Click one to add it, or press `Enter` for the top match. It opens straight in the editor so you can set its candidates.
- An item ID, or an item `Shift`+clicked into the box, is added with `Enter`.
- **Add multiple items...** opens the raid browser: alt-click items to add them to the list, then confirm.

Under the editor are two lists that belong to the list being edited: **Loot Council** (who gets the vote popup and can vote) and **Disenchanter** (who gets an item nobody rolled on: the first one listed who's in the raid, so they're numbered). Whichever list is active in the Loot Master window brings its own council and disenchanters with it; with no list active there's no council and no disenchanter. Each **Add** opens a small panel listing everyone in the group who isn't on that list yet, class coloured; typing narrows it down. Click a name, or press `Enter` for the top match. Someone not in the group can be added by typing their full name and pressing `Enter`. Remove someone with the ×.

### Class slots ("Any Warrior")

When the next slot on a **Priority** item is a class, clicking **Assign** opens a list beside the Loot Master window of every player of that class in the raid. Click a name to give them the item.

- The class stays at the top until every one of them has the item, so the next copy goes to another Warrior. Anyone who already has one is greyed out.
- Once every Warrior in the raid has one, Warrior is removed from that item's list and the next slot (e.g. *Any Hunter*) moves up.
- **Skip Warriors** removes the class early, for example if the rest pass.
- This only changes the list for the current raid. **Clear Raid History** puts it back.

For example, with *Any Warrior > Any Hunter* and Brad and Knightdeath as the raid's Warriors: the first copy goes to whichever you pick, the second to the other, and the third is picked from the Hunters.

### Class spec labels

A *Class* candidate in the Loot Council / Priority editor can optionally carry a spec (e.g. "Mage - Fire"): hover the class in the dropdown for a pullout of its specs. This is descriptive only. WotLK gives addons no reliable way to know another player's spec, so it's a note for whoever is assigning.

### Text import / export

Besides building a list in-game (**Add Item**), you can import one from plain text: built by hand, generated by a spreadsheet, or shared by another officer without opening the game. The Loot Council / Priority window's **Import Text** and **Export Text** buttons work on whichever list is selected.

**Format**, one item per line (or all on one line), each ended with a semicolon, up to 5 candidates per item:

```
itemID, mode, candidate, candidate, ...;
```

For example, Dark Edge of Depravity (item 45533) in Priority mode, first candidate the player Moradladdy, second any Hunter:

```
45533, prio, Moradladdy, hunter;
39633, vote, Brad;
```

**Fields**

- **itemID**: the item's numeric ID, not its name. The same name can exist under different IDs across Normal and Heroic, which a name-based format couldn't tell apart.
- **mode**: one of the following (case doesn't matter):

  | Value | Mode |
  |-------|------|
  | `prio` | Priority |
  | `vote` | Vote |
  | `fun` | Funnel |
  | `pres` | Preselected |

- **candidates**: up to 5, comma-separated. Each is either a player name or a class name meaning "any *class*" (Warrior, Paladin, Hunter, Rogue, Priest, Death Knight, Shaman, Mage, Warlock, Druid; `deathknight` and `dk` also work). Case doesn't matter. A candidate is only read as a class if it matches one of those names exactly, so a player literally named "Hunter" would be read as the class. That's the one real edge case.
- **spec** (optional, class candidates only): write `class-spec`, e.g. `mage-fire` or `hunter-beast mastery`. Only the first hyphen separates class from spec. It's descriptive only, and only counts if both halves match a known class and one of its specs. Otherwise the whole token is read as a player name, so a pasted `Name-Realm` isn't mistaken for a spec label.

Bad entries (unknown item ID, unknown mode, more than 5 candidates) are skipped individually with a clear message instead of stopping the whole import.

## Other Loot Master features

### Posting the boss's loot

When you open a boss's loot as Master Looter, on the corpse or in a chest, ImpLoot lists what dropped in raid chat, e.g. *Loot from Lord Marrowgar: [item] [item] [item]* (over several lines if needed). Reopening the same corpse or chest doesn't post it again. Turn it off, reword it or change its channel in **Options → Announcements → Boss Loot Posted**.

Chest loot (Gunship, Dreamwalker, the Ulduar keepers...) is filed under the boss that drops it, so reopening the chest doesn't add its items to the queue twice.

Walking away from a boss and reopening its loot later keeps the queue as it was, rolls in progress included, whatever you have targeted. If a roll ends while the loot is closed, the item is marked as won but not yet handed over (*open the loot to hand it over*): reopening the loot hands it to the winner (with Auto-assign on) or shows **Assign**. If you trade it instead, click **Traded**. With **Options → Loot Master → Auto-clear the queue when the next boss is looted** on, the queue is only cleared for a different boss, and never while a roll or vote is still running (it tells you so).

### Manual items: `/il <item>`

`/il` followed by an item link or name adds it to the Loot Master queue by hand, for anything that didn't come through the loot window (a trade, a BoE someone wants rolled on). Shift-click the item to paste its link, which is far more reliable than typing the name. By default it waits in the queue for you to click Announce.

**Options → Loot Master →** "`/il <item>` immediately starts its roll/announcement" skips that click: the item goes straight to whatever its mode calls for (Soft Reserve, Loot Priority, or an open roll). It's off by default. A Soft Reserved item with only one reserver still resolves as a direct assignment either way.

### Minimum quality filter

**Options → Loot Master → Minimum quality to queue** controls what gets queued. Anything already spoken for elsewhere (on a Priority list in any mode, or Soft Reserved) is always queued regardless. The filter only applies to items that would otherwise fall through to an unassigned Open Roll. Set it to Epic and an unclaimed green or blue never appears in the Loot Master window. The default is *All qualities (no filter)*.

### Legendary item safeguards

Legendary drops (Fragment of Val'anyr and similar) can't be undone once looted or traded, so they get extra protection:

- The item's row in the queue has an **orange border**.
- Assigning one, whether you click Assign or Auto-Assign picks a winner, **always pauses for a confirmation popup**. Auto-Assign still picks the winner; it just won't commit without you. Every other item assigns immediately as normal.
- For Loot Council Priority-mode items, each candidate's name shows how many of that exact item they've already won this session (e.g. "Brad (2 so far)").

## Slash commands

| Command | What it does |
|---------|--------------|
| `/il` | Open or close the ImpLoot window |
| `/il config`, `/il options`, `/il help` | Open the settings |
| `/il <item>` | Add an item to the Loot Master queue by hand |
| `/il history` | Open or close the loot history |
| `/il reset` | Reset all settings to their defaults. Asks you to confirm with `/il reset confirm`. Wishlists, raid notes and the loot council roster are not affected. |

## Feedback

This is a beta. If something breaks, behaves oddly, or you have a suggestion, please report it here:

**implootCC@gmail.com**

Not yet built, or intentionally left as-is for now:

- A "Rules" announcement feature (posting loot rules to the raid on demand) was discussed but not built.
