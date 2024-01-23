import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
import PowerMenu from '../../services/powermenu.js';
import Lockscreen from '../../services/lockscreen.js';
import Avatar from '../../misc/Avatar.js';
import icons from '../../icons.js';
import { uptime } from '../../variables.js';

export default () => Widget.Box({
    class_name: 'header horizontal',
    children: [
        Avatar(),
        Widget.Box({
            hpack: 'end',
            vpack: 'center',
            hexpand: true,
            children: [
                Widget.Label({
                    class_name: 'uptime',
                    label: uptime.bind().transform(v => `up: ${v}`),
                }),
                Widget.Button({
                    on_clicked: () => Lockscreen.lockscreen(),
                    child: Widget.Icon(icons.lock),
                }),
                Widget.Button({
                    on_clicked: () => PowerMenu.action('shutdown'),
                    child: Widget.Icon(icons.powermenu.shutdown),
                }),
            ],
        }),
    ],
});
