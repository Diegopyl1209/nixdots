import Clock from '../../misc/Clock.js';
import PanelButton from '../PanelButton.js';
import { App, Widget } from '../../imports.js';

export default ({ format = '%I\n ··\n%M' } = {}) => PanelButton({
    className: 'dashboard panel-button',
    onClicked: () => App.toggleWindow('dashboard'),
    connections: [[App, (btn, win, visible) => {
        btn.toggleClassName('active', win === 'dashboard' && visible);
    }]],
    child: Widget.Box({
        className: 'date-button',
        vertical: true,
        children: [
            Clock({format:'%I'}),
            Widget.Label({
                label:'··',
            }),
            Clock({format:'%M'}),
        ],
    
    }),
});
