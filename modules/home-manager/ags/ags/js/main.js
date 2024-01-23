import Applauncher from './applauncher/Applauncher.js';
import FloatingDock from './dock/FloatingDock.js';
import Lockscreen from './lockscreen/Lockscreen.js';
import OSD from './osd/OSD.js';
import Overview from './overview/Overview.js';
import PowerMenu from './powermenu/PowerMenu.js';
import QuickSettings from './quicksettings/QuickSettings.js';
import ScreenCorners from './screencorner/ScreenCorners.js';
import TopBar from './bar/TopBar.js';
import Verification from './powermenu/Verification.js';
import { init } from './settings/setup.js';
import { forMonitors } from './utils.js';
import options from './options.js';

const windows = () => [
    forMonitors(FloatingDock),
    forMonitors(Lockscreen),
    forMonitors(OSD),
    forMonitors(ScreenCorners),
    forMonitors(TopBar),
    Applauncher(),
    Overview(),
    PowerMenu(),
    QuickSettings(),
    Verification(),
];

export default {
    onConfigParsed: init,
    windows: windows().flat(1),
    maxStreamVolume: 1.05,
    cacheNotificationActions: false,
    closeWindowDelay: {
        'quicksettings': options.transition.value,
    },
};
