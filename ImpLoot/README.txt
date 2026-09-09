ImpLoot v1.0.0-beta
====================

A raid loot management addon for World of Warcraft: Wrath of the
Lich King (client 3.3.5a), with built-in Soft Reserve support.


INSTALLATION
------------

1. Unzip this folder into your WoW installation's
   Interface\AddOns\ directory, so you end up with:
   Interface\AddOns\ImpLoot\ImpLoot.toc

2. Enable "ImpLoot" from the AddOns list on the character
   select screen.

3. Log in. You'll see a brief "ImpLoot loaded successfully"
   message in your chat window.


BEFORE YOU START: MASTER LOOTER
--------------------------------

The Loot Master features (the queue, rolls, countdown timer,
announcements, assignment) only activate for whoever is actually
set as Master Looter -- via the raid's own Loot Method options,
same as normal. ImpLoot does not grant or check this for you.

If you're not Master Looter, the Loot Master window simply won't
appear when loot drops -- that's expected, not a bug.


BEFORE YOU START: SET A HOTKEY (OPTIONAL)
-------------------------------------------

ImpLoot doesn't add its own in-addon keybind setting -- like any
other addon action, it's set through WoW's own Key Bindings menu:

    Escape -> Key Bindings -> ImpLoot -> Toggle Loot Master Window

This is entirely optional; the window also opens automatically
for the Master Looter when loot drops.


A TYPICAL RAID NIGHT, START TO FINISH
---------------------------------------

1. Before raid: if you're running Soft Reserves, open ImpLoot
   (/il), go to the Loot panel, click "Import CSV", and paste
   in your SoftRes.it export. Both current SoftRes.it CSV
   formats are supported.

2. As Master Looter, loot drops normally. If you're the Master
   Looter, the Loot Master window automatically opens showing
   the item(s) in queue -- nobody else in the raid sees this
   window.

3. Click "Open Roll" on an item. This announces it to the raid
   (with reserver names, if it's Soft Reserved) and starts the
   roll timer. A live countdown shows next to the button so you
   can see time remaining without waiting on chat reminders.

4. Let the timer run out, or click "Stop" to end it early --
   whichever comes first. The winner is announced the moment the
   roll ends, whether or not the item gets assigned right away.

5. If Auto Assign is on, the item goes to the winner
   automatically. If not (or if nobody rolled), it sits in
   "awaiting assignment" for you to hand out manually --
   including to a disenchanter, if you've set one up.

6. Loot Council items skip the roll/timer step entirely --
   they're resolved by vote or by a pre-built priority list
   instead, from the Priority Lists window.

7. The Summary window keeps a running log of everything resolved
   this session, exportable to paste into a spreadsheet.

Everything above has more detail available in-game: check each
options category's own description, the About tab, and the root
ImpLoot settings page (/il help) for the full slash command list.


THIS IS A BETA
---------------

Expect rough edges. If something breaks, behaves oddly, or you
have a suggestion, please report it here:

    [ADD YOUR FEEDBACK CHANNEL HERE -- Discord link, in-game
    contact, etc.]

Known things already on the radar, not yet built or intentionally
left as-is for now:
- Loot Council items won by a Class-type slot (e.g. "Any
  Warrior") still need the Master Looter to manually pick who
  gets it -- no automatic class-based detection yet.
- A "Rules" announcement feature (posting loot rules to the raid
  on demand) was discussed but not built.
