import Clock from '../../misc/Clock.js';
import PanelButton from '../PanelButton.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

export default ({ format = '%I:%M %p - %A %e.' } = {}) => PanelButton({
    class_name: 'dashboard panel-button',
    on_clicked: () => Utils.execAsync('swaync-client -t'),
    window: 'dashboard',
    content: Clock({ format }),
});
