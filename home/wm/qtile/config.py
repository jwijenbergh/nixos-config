import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from wmenv import colors

mod = "mod4"
terminal = "st"
launcher = "rofi -show run"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "j", lazy.layout.up(),
        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "control"], "j", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle tiled/floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawn(launcher), desc="Open rofi"),
    Key([mod], "w", lazy.to_screen(0), desc="Focus screen 0"),
    Key([mod], "e", lazy.to_screen(1), desc="Focus screen 1"),
    Key([mod, "shift"], "w", lazy.window.toscreen(0), desc="Move window to screen 0"),
    Key([mod, "shift"], "e", lazy.window.toscreen(1), desc="Move window to screen 1"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(toggle=False),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

# Add help key
keys_str = ""
for key in keys:
    keypress = key.modifiers + [key.key]
    keypress_str = "-".join(keypress)
    keys_str += keypress_str + ": " + key.desc + "\n"

help_desc = "Show qtile keys in rofi"
help_key = "p"
keys_str += f"{mod}-{help_key}: {help_desc}"

def get_rofi_command(s, prompt):
    return {
        "shell": True,
        "cmd":f"echo -en '{s}' | rofi -dmenu -p '{prompt}'",
    }

keys.extend([
    Key([mod], help_key, lazy.spawn(**get_rofi_command(keys_str, "Qtile keys")), desc=help_desc),
])

default_layout_settings = {
    "margin": 15,
    "ratio": 0.55,
    "border_width": 4,
    "border_focus": colors["border-focus"],
    "border_normal": colors["border-normal"],
}

layouts = [
    layout.MonadTall(**default_layout_settings),
    layout.MonadWide(**default_layout_settings),
    layout.Floating(**default_layout_settings),
]

widget_defaults = dict(
    margin=8,
    font='Iosevka Term',
    fontsize=18,
    padding=0,
)
extension_defaults = widget_defaults.copy()

has_battery = False

if len(os.listdir('/sys/class/power_supply')) > 0:
    has_battery = True

base_widgets = [
    widget.CurrentLayoutIcon(
        scale=0.6,
        padding=8,
    ),
    widget.GroupBox(
        hide_unused=True,
        disable_drag=True,
        active=colors["bar-widget-group-active"],
        inactive=colors["bar-widget-group-inactive"],
        this_current_screen_border=colors["bar-accent"],
        highlight_color=[colors["bar-bg"], colors["bar-bg"]],
        highlight_method="line",
    )]

widgets = base_widgets + [
    widget.Prompt(),
    widget.Spacer(),
    widget.Chord(
        chords_colors={
            'launch': ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    widget.Pomodoro(
        fontsize=24,
        background=colors["bar-widget-pomodoro"],
        color_active=colors["bar-bg"],
        color_break=colors["bar-bg"],
        color_inactive=colors["bar-bg"],
        timer_visible=False,
        prefix_active=" ",
        prefix_break=" ",
        prefix_inactive="",
        prefix_long_break=" ",
        prefix_paused="",
        padding=10,
    ),
    widget.TextBox(
        text="  ",
        background=colors["bar-widget-time"],
        foreground=colors["bar-bg"],
        fontsize=28,
    ),
    widget.Clock(
        background=colors["bar-widget-time"],
        foreground=colors["bar-bg"],
        format='%Y-%m-%d %a %I:%M %p  '),
]
if has_battery:
    widgets += [
        widget.TextBox(
            text="  ",
            background=colors["bar-widget-bat"],
            foreground=colors["bar-bg"],
            fontsize=28,
        ),
        widget.Battery(
            background=colors["bar-widget-bat"],
            foreground=colors["bar-bg"],
            format='{percent:2.0%}  '
        )
    ]

widgets += [
    widget.TextBox(
        text="  ",
        foreground=colors["bar-bg"],
        background=colors["bar-widget-pin"],
        fontsize=28,
    ),
    widget.Systray(
        background=colors["bar-widget-pin"],
    ),
    widget.TextBox(
        background=colors["bar-widget-pin"],
        text=" ",
    )
]

screens = [
    Screen(
        top=bar.Bar(widgets,
                    34,
                    background=colors["bar-bg"],
                    foreground=colors["bar-fg"],
                    margin=[0, 0, 0, 0]),
    ),
    Screen(
        top=bar.Bar(base_widgets,
                    34,
                    background=colors["bar-bg"],
                    foreground=colors["bar-fg"],
                    margin=[0, 0, 0, 0]),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "qtile"

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])
