from libqtile.config import Group

groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
group_labels = ["", "󰨞", "", "󰉓", "", "󰙯", "", "󱓞", "󰆋" , "󰂺"]
group_layouts = ["max", "monadtall", "monadtall", "monadtall", "monadtall", "max", "monadtall", "monadtall", "max", "monadtall"]

# Add group names, labels, and default layouts to the groups object.
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

