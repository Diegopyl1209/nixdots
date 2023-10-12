import icons from '../../icons.js';
import HoverRevealer from '../../misc/HoverRevealer.js';
import { Widget, Notifications, Utils, App } from '../../imports.js';

export default ({ direction = 'left' } = {}) => Widget.Button({
    className: 'notifications panel-button',
    connections: [
        ['button-press-event', () => App.openWindow('dashboard')],
        [Notifications, box => box.visible =
            Notifications.notifications.length > 0 || Notifications.dnd],
    ],
    child: Widget.Icon({
        binds: [['icon', Notifications, 'dnd', dnd => dnd
            ? icons.notifications.silent
            : icons.notifications.noisy,
        ]],
    }),
});
