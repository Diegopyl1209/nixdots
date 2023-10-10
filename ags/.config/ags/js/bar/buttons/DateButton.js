import Clock from '../../misc/Clock.js';
import PanelButton from '../PanelButton.js';
const { Label } = ags.Widget;
const { DateTime } = imports.gi.GLib;

export default ({ format = '%I\n··\n%M', interval = 1000 } = {}) => PanelButton({
    className: 'dashboard panel-button',
    style: `
    	margin: 8px;
		background-color: #212121;
    `,
    onClicked: () => ags.App.toggleWindow('dashboard'),
    connections: [[ags.App, (btn, win, visible) => {
        btn.toggleClassName('active', win === 'dashboard' && visible);
    }]],
    child: Label({
        className: 'clock date-button',
        style: `
			padding: 8px;
			font-size: 18px;
			font-weight: bold;
			font-family: FiraCode Nerd Font Mono;
			margin:0;
        `,
        connections: [[interval, label =>
            label.label = DateTime.new_now_local().format(format),
        ]],
    }),
});

