import icons from '../../icons.js';
import PowerMenu from '../../services/powermenu.js';
import Theme from '../../services/theme/theme.js';
import Lockscreen from '../../services/lockscreen.js';
import Avatar from '../../misc/Avatar.js';
import { uptime } from '../../variables.js';
import { Widget } from '../../imports.js';

export default () => Widget.Box({
    className: 'header',
    children: [
        Avatar(),
        Widget.Box({
            className: 'system-box',
            vertical: true,
            hexpand: true,
            children: [
                Widget.Box({
                    children: [
                        Widget.Button({
                            valign: 'center',
                            onClicked: () => Theme.openSettings(),
                            child: Widget.Icon(icons.settings),
                        }),
                        Widget.Label({
                            className: 'uptime',
                            hexpand: true,
                            valign: 'center',
                            connections: [[uptime, label => {
                                label.label = `uptime: ${uptime.value}`;
                            }]],
                        }),
                        Widget.Button({
                            valign: 'center',
                            onClicked: () => Lockscreen.lockscreen(),
                            child: Widget.Icon(icons.lock),
                        }),
                        Widget.Button({
                            valign: 'center',
                            onClicked: () => PowerMenu.action('shutdown'),
                            child: Widget.Icon(icons.powermenu.shutdown),
                        }),
                    ],
                })
            ],
        }),
    ],
});
