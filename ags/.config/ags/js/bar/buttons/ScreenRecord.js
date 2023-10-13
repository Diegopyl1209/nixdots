import PanelButton from '../PanelButton.js';
import Recorder from '../../services/screenrecord.js';
import icons from '../../icons.js';
import { Widget } from '../../imports.js';

export default () => PanelButton({
    className: 'recorder',
    onClicked: () => Recorder.stop(),
    binds: [['visible', Recorder, 'recording']],
    child: Widget.Box({
    	vertical: true,
        children: [
            Widget.Icon(icons.recorder.recording),
            Widget.Label({
            	style: `
					font-size: 16px;
					padding-top: 5px;
					font-weight: bold;
					font-family: FiraCode Nerd Font Mono;
					margin:0;
        		`,
                binds: [['label', Recorder, 'timer', time => {
                    const sec = time % 60;
                    const min = Math.floor(time / 60);
                    return `${min < 10 ? '0' + min : min}\n··\n${sec < 10 ? '0' + sec : sec}`;
                }]],
            }),
        ],
    }),
});
