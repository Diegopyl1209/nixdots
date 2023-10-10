import OverviewButton from './buttons/OverviewButton.js';
import Workspaces from './buttons/Workspaces.js';
import FocusedClient from './buttons/FocusedClient.js';
import MediaIndicator from './buttons/MediaIndicator.js';
import DateButton from './buttons/DateButton.js';
import NotificationIndicator from './buttons/NotificationIndicator.js';
import SysTray from './buttons/SysTray.js';
import ColorPicker from './buttons/ColorPicker.js';
import SystemIndicators from './buttons/SystemIndicators.js';
import PowerMenu from './buttons/PowerMenu.js';
import Separator from '../misc/Separator.js';
import ScreenRecord from './buttons/ScreenRecord.js';
import BatteryBar from './buttons/BatteryBar.js';
import SubMenu from './buttons/SubMenu.js';
const { Window, CenterBox, Box, Label } = ags.Widget;
const { SystemTray } = ags.Service;


const submenuItems = ags.Variable(1);
SystemTray.instance.connect('changed', () => {
    submenuItems.setValue(SystemTray.items.length + 1);
});

const SeparatorDot = (service, condition) => Separator({
    orientation: 'vertical',
    valign: 'center',
    connections: service && [[ags.Service[service], dot => {
        dot.visible = condition(ags.Service[service]);
    }]],
});

const Start = () => Box({
    className: 'start',
    vertical: true,
    children: [
        OverviewButton(),
        Workspaces(),
        //SeparatorDot(),
        //FocusedClient(),
        //Box({ hexpand: true }),
    ],
});

const Center = () => Box({
    className: 'center',
    vertical: true,
    homogeneous: false,

    children: [
    	NotificationIndicator(),
    	//SeparatorDot('Notifications', n => n.notifications.length > 0 || n.dnd),
        DateButton(),
        SeparatorDot('Mpris', m => m.players.length > 0),
        MediaIndicator(),
        Box({ hexpand: true }),
    ],
});

const End = () => Box({
    className: 'end',
    vertical: true,
    homogeneous: false,
    children: [
    	Box({ vexpand: true }),
        SubMenu({
            items: submenuItems,
            children: [
                SysTray(),
               // ColorPicker(),
            ],
        }),
                
        
        SeparatorDot(),
        ScreenRecord(),
        SeparatorDot('Recorder', r => r.recording),
        SystemIndicators(),
        SeparatorDot(),
        PowerMenu(),
    ],
});

export default monitor => Window({
    name: `bar${monitor}`,
    exclusive: true,
    monitor,
    anchor: 'top left bottom',
    child: CenterBox({
        className: 'panel',
        vertical: true,
        startWidget: Start(),
        centerWidget: Center(),
        endWidget: End(),
    }),
});

