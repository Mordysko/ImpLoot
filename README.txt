ImpLoot v1.0.0-beta.15
=======================

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


BEFORE YOU START: HOW YOUR DATA GETS SAVED
---------------------------------------------

Wishlists, priority lists, and everything else ImpLoot saves are
only written to disk on a proper logout, /reload, or exiting
normally through the game menu. This is how WoW's SavedVariables
system works for every addon (including Blizzard's own UI
settings), not something specific to ImpLoot.

Alt-F4 or a crash skips that save step entirely -- so anything
created since your last logout/reload won't be there next time
you log in. A quick /reload after finishing something you don't
want to risk losing (like building out a priority list) is a
cheap safety net.


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
   Clicking Stop yourself always assigns the item straight to
   whoever's currently winning (if anyone's rolled), regardless of
   your Auto Assign setting -- that setting only ever governs what
   happens when the timer runs out on its own, not a moment where
   you've actively stepped in to end the roll yourself.

5. If the timer runs out on its own and Auto Assign is on, the
   item goes to the winner automatically. If the timer runs out
   with Auto Assign off, or nobody rolled at all, it sits in
   "awaiting assignment" for you to hand out manually -- including
   to a disenchanter, if you've set one up and nobody rolled.

   Only /roll 1-100 or /roll 1-99 ever count toward the standings
   -- any other range (a typo, or someone rolling something custom)
   is silently ignored rather than treated as a real participant.

6. Loot Council items skip the roll/timer step entirely --
   they're resolved by vote or by a pre-built priority list
   instead, from the Priority Lists window.

7. The Summary window keeps a running log of everything resolved
   this session, exportable to paste into a spreadsheet.

Everything above has more detail available in-game: check each
options category's own description, the About tab, and the root
ImpLoot settings page (/il help) for the full slash command list.


ASSIGNING TO SOMEONE NOT PRESENT
-----------------------------------

Assigning an item -- through any mode, including the Sole Reserver
shortcut above -- only hands it out through the game's own Master
Loot system if the winner is actually a valid recipient for that
loot window right now (in the raid, in range of the corpse). If
they're not -- offline, not on that raid night, out of range,
whatever the reason -- the addon doesn't error or get stuck. It
still records them as the winner and marks the item resolved, but
flags it "(trade it)" next to their name in the queue, and the chat
message reads "Recorded -- trade this item to <name>" instead of
confirming an actual hand-off. That's your cue that this one needs
manually trading (or mailing) to them yourself once they're around
to receive it -- the addon can't do that part for you.


SOFT RESERVE: SOLE RESERVER SHORTCUT
---------------------------------------

When a Soft Reserved item's remaining reserve slots all belong to
the same one person (whether they hold one slot or several via a
Plus reserve), there's no real contest to run -- so instead of
Announce/roll, the queue row shows a one-click Assign straight to
that person. This still announces to chat first (so the raid knows
who got it and why, even though there's no roll to watch), then
assigns exactly like any other winner would be, legendary
confirmation included.

The moment a second person reserves the same item, this reverts to
the normal Announce/roll flow automatically.


SUMMARY WINDOW: "WHO WON WHAT" TABLE, WITH SOFT RESERVES ONE CLICK AWAY
---------------------------------------------------------------------

The Summary window opens to "Who won what" by default -- a plain,
read-only table (Item / Winner / Roll), not an editable text box.
It's grouped by boss, in that raid's own real encounter order
(Boss.Index, the same source of truth the Raid Planner uses), not
the order items happened to resolve in. The Roll column shows "SR"
for a Soft Reserve win, "LC" for Loot Council, or the winner's own
roll type (MS/OS) for an Open Roll win. It populates itself
automatically -- nothing to click to generate it, and it updates
whenever an item resolves while the window's open.

Post to raid and Clear sit alongside it, operating on that same
data. The SR view itself -- one card per player, their class-
colored spec, and the items they've reserved with icons, with its
own Back button to return -- is reached from a "Soft Reserve"
button on the main Loot Master window, alongside Summary/Priority
Lists/Clear All, opening straight to it without going through "Who
won what" first. (An earlier pass also had a second copy of this
button inside the Summary window itself; that's been removed as
redundant now that the Loot Master window's own button covers it.)

"Export" (originally called "Copy CSV" while this was being built)
opens a small, separate copyable text box (Ctrl+C, WoW has no
clipboard API) with one plain comma-separated line per item --
Item,Winner,Roll -- meant for pasting into a spreadsheet, kept
deliberately separate from the visual table above it.

Also fixed in this pass:

- Resolutions were being logged twice into this same data, once
  directly the moment an item was assigned and once again when
  that same addon message echoed back to the loot master's own
  client (a known WoW quirk -- broadcasting to your own raid/party
  channel delivers the message back to you too) -- every entry in
  "Who won what" was effectively doubled. Fixed both by recognizing
  and ignoring a message that's just your own broadcast coming
  back, and by a second, independent safety check in the logging
  itself that skips an exact repeat of the most recent entry within
  a few seconds -- genuinely different wins, including the same
  item won again much later, are unaffected either way.

- A long item name wrapping to two lines within its column no
  longer overlaps the row placed underneath it -- each row's actual
  rendered height is measured and accounted for now, rather than
  assuming every row is exactly one line tall.

- Reopening the window via the Loot Master window's "Summary"
  button now always lands back on "Who won what", even if the
  window had last been left open on the Soft Reserve view or the
  Export text -- previously it would keep showing whichever of
  those was last visible until a full /reload.


SOFT RESERVE: ABSENT RESERVERS
-----------------------------------

Everywhere the addon reasons about who's reserved an item -- the
Sole Reserver shortcut, the multiple-copies comparison, and the
Loot Master window's own "Reserved by" text -- only counts someone
who's actually in the raid right now. Offline still counts as
present (they're still in the group, just disconnected, and might
reconnect); only genuinely not being in the raid at all doesn't.
A sole reserver who turns out to be absent falls back to a plain
Open Roll rather than offering a one-click Assign to someone who
can't actually receive it, and the same applies if every reserver
on an item is absent. The Loot Master window's own reserver list
leaves absent people off entirely, since there's nothing useful in
naming someone who isn't eligible for the loot anyway.

The chat announcement sent to the raid is the one place absent
reservers are still named -- but marked, e.g. "Alice & (Carol -
Absent) & Bob" -- so nobody's left wondering why an item is being
rolled for by fewer people than reserved it.


SOFT RESERVE: MULTIPLE COPIES DROPPING TOGETHER
---------------------------------------------------

When two or more copies of the same item drop from the same corpse
at once, the addon compares how many distinct people reserved it
against how many copies actually dropped (this only applies with
"Allow multiple reserves" off -- see below):

- Reservers <= copies: no roll needed at all. One click assigns one
  copy to each reserver, with a single combined chat announcement
  naming everyone who's getting one. If there are fewer reservers
  than copies, the leftover copy (or copies) is released to plain
  Open Roll and handled from there exactly like any other unreserved
  item -- it's no longer treated as Soft Reserved at all.

- Reservers > copies: still needs a roll, but as one combined event
  covering every copy together -- a single announcement, and every
  copy's roll timer starting from the same click, rather than having
  to click Announce on each copy separately (previously, clicking
  Announce on only one copy left any other copy sitting un-announced
  with no roll data of its own for the whole roll period -- a real
  bug). Rolling once already counted toward every copy's standings,
  and assigning one copy already excluded that winner from the
  others' -- both unchanged; this only fixes how the group of copies
  gets started in the first place. The top N rollers (N = number of
  copies) each end up with one.

A Plus reserve (an extra roll on the same item) counts as one extra
chance to roll for that person, not an extra distinct reserver --
it never changes this comparison.

With "Allow multiple reserves" ON, none of the above applies: each
copy is deliberately handled completely on its own, with no
combined announcement and no exclusion between copies, since the
whole point of that setting is letting the same person legitimately
win more than one copy.


MANUAL ITEMS: /il <item>
--------------------------

Typing /il followed by an item link or name (shift-click the item
to paste its link, which is far more reliable than typing the
name) adds it to the Loot Master queue by hand -- useful for
anything that didn't come through the normal loot window (a trade,
a BoE someone wants rolled on, etc). By default it's added the same
way any other item is, waiting there for you to click Announce when
ready.

Options -> Loot Master has a checkbox, "/il <item> immediately
starts its roll/announcement", for skipping that manual click: with
it on, /il goes straight to whatever announcement the item's actual
mode calls for (Soft Reserve, Loot Priority, or an open roll) the
moment it's added, the same as clicking Announce yourself would.
Off by default, so /il behaves exactly as it always has unless you
turn this on.

A Soft Reserve item that turns out to have only one person on it
(see below) still resolves as a direct assignment either way --
this setting only changes whether the announcement/roll step for
everything else starts immediately or waits for you.


MINIMUM QUALITY FILTER
------------------------

Options -> Loot Master has a "Minimum quality to queue" dropdown.
Anything already spoken for elsewhere in the addon -- on the
Priority list in any mode, or Soft Reserved -- always gets queued
regardless of this setting; it only has any say over an item that
would otherwise just fall through to an unassigned Open Roll. Set
it to, say, Epic, and an unclaimed green or blue item never shows
up in the Loot Master window at all -- it's silently skipped rather
than needing a manual pass or disenchant click. Defaults to "All
qualities (no filter)", which behaves exactly as the addon always
has.


SOFT RESERVE IMPORT: PERSISTENCE, RELOAD PROMPT, AND MULTI-COPY DROPS
-----------------------------------------------------------------------

A few reliability improvements to the CSV import:

- The imported reserve list itself now actually persists across
  reloads and logouts, the same as everything else the addon saves.
  It previously did not, regardless of how cleanly you reloaded --
  a genuine bug, not something specific to crashing.

- Re-importing a CSV now correctly refreshes who's shown as having
  reserved each item. Previously, an item's reserver list was only
  ever computed once and then cached from then on -- so if that
  item had been seen in an earlier import (a previous raid night,
  say), re-importing a fresh CSV wouldn't update it: it would keep
  showing the old reserver names, including people who'd reserved
  it before but not this time, while missing anyone who'd reserved
  it since. A genuine bug, now fixed -- every re-import rebuilds
  each item's reserver list from that import's actual data. Each
  raid night's own win history is untouched by this and still
  carries through a re-import, same as before.

- Right after a successful import, the addon prompts you to reload
  immediately. WoW only ever writes SavedVariables to disk during
  an actual logout or reload, so a crash between an import and your
  next natural one of those could still lose it -- reloading right
  away closes that window.

- A counter next to the Import CSV button shows how many SRs are
  currently loaded and the date of the last import in brackets, so
  it's obvious at a glance without opening the dialog. The date
  shown is when the CSV was imported in-game, not anything from the
  file itself -- SoftRes.it's own Date column is a per-reservation
  submission timestamp (when each player individually reserved),
  not a single date for the whole raid.

- When the same item drops twice from the same boss at once, the
  addon now correctly tracks both copies separately (previously the
  second copy silently overwrote the first in the queue). Since
  players naturally roll once for a shot at either copy rather than
  rolling per copy, a single roll counts toward both copies'
  standings -- and once you assign the first copy to the top
  roller, the second copy's standings automatically exclude them,
  so its own top spot becomes whoever rolled second. The second
  copy always still needs its own explicit Assign click, regardless
  of whether Auto-Assign To Roll Winner is turned on.


LOOT PRIORITY: CLASS SPEC LABELS
----------------------------------

A Class candidate in the Loot Priority editor can optionally be
labeled with a specific spec (e.g. "Mage - Fire") -- hover the
class in the dropdown for a pullout menu of its specs. This is
descriptive only, not mechanically enforced: WotLK has no reliable
way for an addon to passively know another player's current spec,
so it's a note for whoever's assigning to use their own judgement
with, the same way a bare Class candidate already relies on the
loot master to manually confirm someone's actual class.


LEGENDARY ITEM SAFEGUARDS
--------------------------

Legendary-quality drops (Fragment of Val'anyr and similar) get a
few extra safeguards, since accidentally awarding one to the
wrong person can't be undone once it's looted/traded:

- The item's row in the Loot Master queue gets an orange border,
  so it's visibly flagged before you click anything.
- Assigning one -- whether you click Assign yourself, or
  Auto-Assign To Roll Winner picks a winner automatically --
  always pauses for a manual confirmation popup first. Auto-Assign
  still picks the winner for you; it just won't commit the award
  without you clicking through. Every other item is unaffected and
  still assigns immediately, same as before.
- For Loot Council Priority-mode items specifically, each
  candidate's name shows how many of that exact item they've
  already won this session (e.g. "Rad (2 so far)"), so you have
  that context in view without needing to check the Summary
  window separately.


PRIORITY LIST TEXT IMPORT/EXPORT FORMAT
------------------------------------------

Besides building a Loot Priority list in-game (Populate Item
List), you can also import one from a plain text string -- built
by hand, generated by a spreadsheet, or shared by another
officer/guild without them ever needing to open the game. The
Loot Priority window's "Import Text" and "Export Text" buttons
both work against whichever list is currently selected.

FORMAT

    itemID, mode, candidate, candidate, ...;

One item per line (or all on one line -- both work), each ended
with a semicolon. Up to 5 candidates per item.

Example -- Dark Edge of Depravity (item 45533), Priority mode,
first candidate is the player Mordality, second is any Hunter:

    45533, prio, Mordality, hunter;

Multiple items:

    45533, prio, Mordality, hunter;
    39633, vote, Rad;

FIELDS

- itemID: the item's numeric ID, not its name. This is
  deliberate -- the same item name can exist under different IDs
  across Normal and Heroic versions, which a name-based format
  couldn't tell apart.

- mode: one of
      prio  = Priority
      vote  = Vote
      fun   = Funnel
      pres  = Preselected
  Case doesn't matter (PRIO/Prio/prio all work).

- candidates: up to 5, separated by commas. Each one is either a
  player name, or a class name to mean "any \<class\>" (Warrior,
  Paladin, Hunter, Rogue, Priest, Death Knight, Shaman, Mage,
  Warlock, Druid -- "deathknight" and "dk" also work for Death
  Knight). Case doesn't matter here either. A candidate is only
  ever treated as a class if it matches one of those names
  exactly -- a player literally named e.g. "Hunter" would be
  read as the class instead, which is the one real edge case in
  this format.

- spec (optional, class candidates only): write it as
  "class-spec" instead of a bare class name, e.g. "mage-fire" or
  "hunter-beast mastery" (a spec name with its own space still
  works fine -- only the FIRST hyphen is treated as the
  class/spec separator). Same as the in-game spec label, this is
  descriptive only and not mechanically verified. Only resolves
  as class-spec if both halves actually match a known class and
  one of its specs; otherwise the whole token is read as a plain
  player name, so a pasted "Name-Realm" isn't misread as a spec
  label.

Bad entries (an unrecognized item ID, an unknown mode, more than
5 candidates) are skipped individually with a clear message,
rather than stopping the whole import.


THIS IS A BETA
---------------

Expect rough edges. If something breaks, behaves oddly, or you
have a suggestion, please report it here:

    implootCC@gmail.com

Known things already on the radar, not yet built or intentionally
left as-is for now:
- Loot Council items won by a Class-type slot (e.g. "Any
  Warrior") still need the Master Looter to manually pick who
  gets it -- no automatic class-based detection yet.
- A "Rules" announcement feature (posting loot rules to the raid
  on demand) was discussed but not built.
