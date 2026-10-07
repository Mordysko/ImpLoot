ImpLoot
=======

A raid loot management addon for World of Warcraft: Wrath of the Lich
King (3.3.5a): loot planning, wishlists and priority lists, Loot Master
rolls, and built-in Soft Reserve support.

NOTE: This is a beta. Expect rough edges. See Feedback for where to
      report problems.

CONTENTS
--------

- Installation
- Good to know
- For every player
- A typical raid night
- Assigning to someone who isn't present
- The Summary window
- Soft Reserves
- Loot Priority lists
- Other Loot Master features
- Slash commands
- Feedback

INSTALLATION
------------

1. Copy the ImpLoot folder (the one containing ImpLoot.toc) into your
   WoW installation's Interface\AddOns\ directory, so you end up with
   Interface\AddOns\ImpLoot\ImpLoot.toc. That folder is all the game
   needs; anything else in the download (such as a .github folder) is
   just for the GitHub page.
2. Enable ImpLoot from the AddOns list on the character select screen.
3. Log in. You'll see a brief "ImpLoot loaded successfully" message in
   chat.

GOOD TO KNOW
------------

Master Looter
~~~~~~~~~~~~~

The Loot Master features (the queue, rolls, countdown timer,
announcements, assignment) only activate for whoever is set as Master
Looter through the raid's normal Loot Method options. ImpLoot doesn't
grant or check this for you. If you're not the Master Looter, the Loot
Master window simply won't appear when loot drops. That's expected.

Hotkey (optional)
~~~~~~~~~~~~~~~~~

ImpLoot has no keybind setting of its own. Like any addon action, it's
set through WoW's Key Bindings menu:

Escape -> Key Bindings -> ImpLoot -> Toggle Loot Master Window

The window also opens automatically for the Master Looter when loot
drops.

How your data gets saved
~~~~~~~~~~~~~~~~~~~~~~~~

Wishlists, priority lists, imported reserves and everything else ImpLoot
stores are only written to disk on a proper logout, /reload, or exiting
through the game menu. That's how WoW's SavedVariables work for every
addon. Alt-F4 or a crash skips the save, so anything created since your
last logout or reload would be lost. A quick /reload after finishing
something you don't want to risk (like building a priority list) is a
cheap safety net.

FOR EVERY PLAYER
----------------

You don't need to be the Master Looter to use ImpLoot. Everything in
this section works for any player, on any character.

Browsing loot
~~~~~~~~~~~~~

Open ImpLoot with /il (or left-click the minimap button). Pick a raid,
then a difficulty (10, 25, 10 Heroic or 25 Heroic) and a boss to see
everything it drops. The search box finds an item by name across every
raid; click a result to jump straight to the boss that drops it.

What you can do with an item
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These work on any item in the loot list:

Shift+click   Link the item in chat
Ctrl+click    Try it on in the dressing room
Alt+click     Add it to your active wishlist

Wishlists
~~~~~~~~~

Open the planning tab on the right edge of the window and choose
Wishlist.

- Make as many named wishlists as you like (for example "Ulduar -
  Discipline"), and rename or delete them whenever you want.
- Click a wishlist's name to make it your active one, marked with >.
  That's the one Alt+click adds to.
- An item added more than once shows its count (for example x2).
  Alt+click an item in the wishlist to remove one copy. Click an item to
  jump to the boss that drops it.
- Switch between All Items, By Raid (grouped by raid and difficulty,
  such as "Icecrown Citadel 10 - Heroic") and By Slot.

Characters
~~~~~~~~~~

The Characters page lists every character you've logged in with ImpLoot.
Pick one to view and edit its wishlists from any character, which is
handy for planning an alt's gear without logging onto it. Choosing a
character here only changes which wishlist you're looking at; it never
affects the character you're actually playing.

Raid Planner
~~~~~~~~~~~~

The Raid Planner page answers "which raids do I still need to run?".
It's a read-only list of everything you're after across all of the
selected character's wishlists, grouped by raid (in release order), then
difficulty, then boss in the order you fight them, with Trash and Extra
Drops last. It doesn't use lockout data, so it shows everything you want
rather than what you've already cleared this week.

Compare
~~~~~~~

The Compare drawer is the tab on the left edge of the window. It holds
two items side by side and shows the stat difference between them.

- While the drawer is open, Alt+click on an item in the loot list fills
  slot 1, and Alt+right-click fills slot 2. (This replaces Alt+click
  adding to your wishlist for as long as the drawer is open.)
- Click a slot to lock it so it isn't replaced, and click again to
  unlock. Right-click a slot to remove its item (a locked slot has to be
  unlocked first). Ctrl+click a slot to try the item on.
- Items have to fit the same slot to be compared. Main-hand, one-hand
  and two-hand weapons can be compared with each other.

Raid Notes
~~~~~~~~~~

The Raid Notes page keeps named, free-text notes for each character,
handy for boss strategy reminders or your raid assignments. Create,
rename and delete them like wishlists; the active note is edited in its
own window.

The "this one's yours" popup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When the Master Looter announces an item that's one of your Soft
Reserves, or an open-roll item that's on one of your wishlists, a small
popup appears with Roll, Off-Spec Roll and Pass. Roll makes a real roll
for you, exactly as if you'd typed it (main spec 1-100, off spec 1-99).
It only appears for items that matter to you, and several in a row wait
their turn rather than stacking. The Master Looter needs to be running
ImpLoot too for this to work.

A TYPICAL RAID NIGHT
--------------------

The rest of this guide, up to Slash commands, is for whoever is running
loot as Master Looter.

1. Before raid: if you're running Soft Reserves, open ImpLoot (/il), go
   to the Loot panel, click Import CSV and paste your SoftRes.it export.
   Both current SoftRes.it CSV formats are supported.
2. Loot drops. As Master Looter, the Loot Master window opens with the
   items in the queue. Nobody else in the raid sees it.
3. Click Open Roll on an item (Announce if it's Soft Reserved). This
   announces it to the raid, with the reserver names for a Soft Reserved
   item, and starts the roll timer. A live countdown shows next to the
   button.
4. End the roll. Let the timer run out, or click Stop to end it early.
   The winner is announced the moment the roll ends. Clicking Stop
   yourself always assigns the item to whoever is currently winning (if
   anyone has rolled), regardless of your Auto Assign setting.
5. If the timer runs out on its own: with Auto Assign on, the item goes
   to the winner automatically. With it off, or if nobody rolled, the
   item waits in "awaiting assignment" for you to hand out manually,
   including to a disenchanter if you've set one up.
6. Loot Council items skip the roll step. They're resolved by vote or by
   a pre-built priority list from the Priority Lists window.
7. The Summary window keeps a running log of everything resolved this
   session.

Only /roll 1-100 (main spec) and /roll 1-99 (off spec) count toward the
standings. Any other range is ignored, and main spec always outranks off
spec regardless of the number rolled.

More detail is available in-game: each options category has its own
description, and the About tab and /il help open the settings.

ASSIGNING TO SOMEONE WHO ISN'T PRESENT
--------------------------------------

An item is only handed out through WoW's Master Loot system if the
winner can actually receive it right now (in the raid and in range of
the corpse). If they can't, ImpLoot doesn't error or get stuck: it
records them as the winner, marks the item resolved, and flags it (trade
it) in the queue. The chat message reads Recorded -- trade this item to
<name>. That's your cue to trade or mail it to them yourself later.

THE SUMMARY WINDOW
------------------

Open it with the Summary button on the Loot Master window. It opens to
Who won what: a read-only table of Item / Winner / Roll, grouped by boss
in that raid's encounter order. The Roll column shows SR for a Soft
Reserve win, LC for Loot Council, or the winner's roll type (MS / OS)
for an Open Roll. It fills itself in and updates as items resolve.

- Post to raid sends the list to raid chat.
- Clear empties the log.
- Export opens a small copyable box (Ctrl+C; WoW has no clipboard
  access) with one line per item as Item,Winner,Roll, ready to paste
  into a spreadsheet.

The Soft Reserve button on the Loot Master window opens the same window
straight to the soft reserve view instead: one card per player with
their class-coloured spec and reserved items. There's no Back button.
That same button, or the window's close button, is the way out.

SOFT RESERVES
-------------

Importing
~~~~~~~~~

- Click Import CSV on the Loot panel and paste your SoftRes.it export. A
  counter next to the button shows how many reserves are loaded and the
  date of the last import (the date you imported it in-game, not
  anything from the file).
- The imported list is saved across reloads and logouts. Re-importing
  replaces it, while the session's win history is kept.
- Right after a successful import, ImpLoot offers to reload so the list
  is written to disk straight away.

Editing by hand
~~~~~~~~~~~~~~~

The loot master can add, change and remove reserves without a new
import: a late joiner, a wrong item, a change of mind. Open the Soft
Reserve window and click Edit Soft Reserves.

- Add Soft Reserve and Save appear below the title, and every player's
  card gets an Edit button.
- Add / Edit open a form in the same window: name, optional note, class,
  optional specialization, and the items.
- Find items by typing part of the name, the same search the loot panel
  uses; click a match to add it. The Raid and Difficulty dropdowns
  narrow the search, and they matter: each difficulty of an item has a
  different item ID, so they decide which one gets reserved. They start
  on the raid and difficulty most current reserves are from. The search
  also follows the class you've picked: a tier token only shows for the
  class that can turn it in (a Druid is only offered the Vanquisher
  token), and class-locked gear only shows for its own class. With no
  class chosen yet, everything shows. Click the x on a row to take an
  item off.
- Done returns to the reserve page with that player updated; Cancel
  returns without changing anything. Taking every item off an existing
  player and pressing Done removes them.
- Nothing is applied until you click Save on the reserve page. Add and
  edit as many players as you like first. Save applies everything at
  once and shows a single reload prompt (WoW only writes saved data on a
  reload or logout), rather than one after every player. Afterwards the
  extra buttons disappear, leaving just Edit Soft Reserves.
- Unsaved changes are lost if you close the window; it warns you first.
  Importing a new CSV also discards unsaved edits, since they'd be based
  on the list it replaced.

The maximum number of items per player is a setting (Options -> Soft
Reserve -> Max reserves per player, default 3, or No limit) because it
differs from guild to guild. Match whatever your SoftRes.it page was set
up with. It only applies to manual edits; an imported CSV is never
checked against it. Allow multiple reserves per item is respected too:
with it off, the form won't take the same item twice for one player.

Sole reserver shortcut
~~~~~~~~~~~~~~~~~~~~~~

When all of a Soft Reserved item's remaining reserves belong to one
person (one slot or several via a Plus reserve), there's nothing to roll
for. The queue row shows a one-click Assign instead of Announce. It
still announces to chat first, so the raid knows who got it and why, and
then assigns like any other winner (legendary confirmation included). As
soon as a second person reserves the same item, it goes back to the
normal Announce / roll flow.

Multiple copies dropping together
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When two or more copies of the same item drop from the same corpse,
ImpLoot compares how many distinct people reserved it against how many
copies dropped (this applies with Allow multiple reserves off):

- Reservers <= copies: no roll. One click assigns one copy to each
  reserver, with a single combined announcement. Any leftover copy is
  released to a plain Open Roll.
- Reservers > copies: one combined roll covering every copy: a single
  announcement, and every timer starts from the same click. A single
  roll counts toward every copy's standings, and once a copy is
  assigned, that winner is excluded from the others. The top N rollers
  (N = number of copies) each get one. Clicking Stop on one copy also
  finalizes every other copy still rolling, each to its own top roller.
- A Plus reserve counts as one extra chance to roll for that person, not
  an extra distinct reserver, so it never changes the comparison.

With Allow multiple reserves on, none of this applies: each copy is
handled completely on its own, since the point of that setting is
letting the same person win more than one copy.

Absent reservers
~~~~~~~~~~~~~~~~

Only people actually in the raid count as reservers: for the
sole-reserver shortcut, the multiple-copies comparison, and the
"Reserved by" text in the Loot Master window. Offline still counts as
present (they're in the group and may reconnect). A sole reserver who is
absent, or an item where every reserver is absent, falls back to a plain
Open Roll. The chat announcement is the one place absent reservers are
still named, marked like "Alice & (Carol - Absent) & Bob".

LOOT PRIORITY LISTS
-------------------

Class spec labels
~~~~~~~~~~~~~~~~~

A Class candidate in the Loot Priority editor can optionally carry a
spec (e.g. "Mage - Fire"): hover the class in the dropdown for a pullout
of its specs. This is descriptive only. WotLK gives addons no reliable
way to know another player's spec, so it's a note for whoever is
assigning.

Text import / export
~~~~~~~~~~~~~~~~~~~~

Besides building a list in-game (Populate Item List), you can import one
from plain text: built by hand, generated by a spreadsheet, or shared by
another officer without opening the game. The Loot Priority window's
Import Text and Export Text buttons work on whichever list is selected.

Format, one item per line (or all on one line), each ended with a
semicolon, up to 5 candidates per item:

    itemID, mode, candidate, candidate, ...;

For example, Dark Edge of Depravity (item 45533) in Priority mode, first
candidate the player Mordality, second any Hunter:

    45533, prio, Mordality, hunter;
    39633, vote, Rad;

Fields

- itemID: the item's numeric ID, not its name. The same name can exist
  under different IDs across Normal and Heroic, which a name-based
  format couldn't tell apart.
- mode: one of the following (case doesn't matter):

  prio   Priority
  vote   Vote
  fun    Funnel
  pres   Preselected

- candidates: up to 5, comma-separated. Each is either a player name or
  a class name meaning "any class" (Warrior, Paladin, Hunter, Rogue,
  Priest, Death Knight, Shaman, Mage, Warlock, Druid; deathknight and dk
  also work). Case doesn't matter. A candidate is only read as a class
  if it matches one of those names exactly, so a player literally named
  "Hunter" would be read as the class. That's the one real edge case.
- spec (optional, class candidates only): write class-spec, e.g.
  mage-fire or hunter-beast mastery. Only the first hyphen separates
  class from spec. It's descriptive only, and only counts if both halves
  match a known class and one of its specs. Otherwise the whole token is
  read as a player name, so a pasted Name-Realm isn't mistaken for a
  spec label.

Bad entries (unknown item ID, unknown mode, more than 5 candidates) are
skipped individually with a clear message instead of stopping the whole
import.

OTHER LOOT MASTER FEATURES
--------------------------

Manual items: /il <item>
~~~~~~~~~~~~~~~~~~~~~~~~

/il followed by an item link or name adds it to the Loot Master queue by
hand, for anything that didn't come through the loot window (a trade, a
BoE someone wants rolled on). Shift-click the item to paste its link,
which is far more reliable than typing the name. By default it waits in
the queue for you to click Announce.

Options -> Loot Master -> "/il <item> immediately starts its
roll/announcement" skips that click: the item goes straight to whatever
its mode calls for (Soft Reserve, Loot Priority, or an open roll). It's
off by default. A Soft Reserved item with only one reserver still
resolves as a direct assignment either way.

Minimum quality filter
~~~~~~~~~~~~~~~~~~~~~~

Options -> Loot Master -> Minimum quality to queue controls what gets
queued. Anything already spoken for elsewhere (on a Priority list in any
mode, or Soft Reserved) is always queued regardless. The filter only
applies to items that would otherwise fall through to an unassigned Open
Roll. Set it to Epic and an unclaimed green or blue never appears in the
Loot Master window. The default is All qualities (no filter).

Legendary item safeguards
~~~~~~~~~~~~~~~~~~~~~~~~~

Legendary drops (Fragment of Val'anyr and similar) can't be undone once
looted or traded, so they get extra protection:

- The item's row in the queue has an orange border.
- Assigning one, whether you click Assign or Auto-Assign picks a winner,
  always pauses for a confirmation popup. Auto-Assign still picks the
  winner; it just won't commit without you. Every other item assigns
  immediately as normal.
- For Loot Council Priority-mode items, each candidate's name shows how
  many of that exact item they've already won this session (e.g. "Rad (2
  so far)").

SLASH COMMANDS
--------------

/il
    Open or close the ImpLoot window
/il config, /il options, /il help
    Open the settings
/il <item>
    Add an item to the Loot Master queue by hand
/il reset
    Reset all settings to their defaults. Asks you to confirm with /il
    reset confirm. Wishlists, raid notes and the loot council roster are
    not affected.

FEEDBACK
--------

This is a beta. If something breaks, behaves oddly, or you have a
suggestion, please report it here:

implootCC@gmail.com

Not yet built, or intentionally left as-is for now:

- Loot Council items won by a Class-type slot (e.g. "Any Warrior") still
  need the Master Looter to pick who gets it manually. There's no
  automatic class-based detection yet.
- A "Rules" announcement feature (posting loot rules to the raid on
  demand) was discussed but not built.
