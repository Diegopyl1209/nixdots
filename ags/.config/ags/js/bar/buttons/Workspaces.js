const { Hyprland } = ags.Service;
const { Box, Button, EventBox, Label, CenterBox } = ags.Widget;
const { execAsync } = ags.Utils;
import options from '../../options.js';

export default ({ workspaces = options.workspaces } = {}) => CenterBox({
    className: 'workspaces panel-button ',
    vertical: false,
    centerWidget: Box({
        children: [EventBox({
            onScrollUp: () => execAsync('hyprctl dispatch workspace +1'),
            onScrollDown: () => execAsync('hyprctl dispatch workspace -1'),
            className: 'eventbox',
            child: Box({
            	vertical: true,
            	spacing: 8,
                children: Array.from({ length: workspaces }, (_, i) => i + 1).map(i => Button({
                    onClicked: () => execAsync(`hyprctl dispatch workspace ${i}`).catch(print),
                    child: Label({
                        label: `${i}`,
                        className: 'indicator',
                        valign: 'center',
                    }),
                    connections: [[Hyprland, btn => {
                        const occupied = Hyprland.getWorkspace(i)?.windows > 0;
                        btn.toggleClassName('active', Hyprland.active.workspace.id === i);
                        btn.toggleClassName('occupied', occupied);
                    }]],
                })),
            }),
        })],
    }),
});
