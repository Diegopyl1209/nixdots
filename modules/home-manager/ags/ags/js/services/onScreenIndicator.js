import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Service from 'resource:///com/github/Aylur/ags/service.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import icons from '../icons.js';
import { getAudioTypeIcon } from '../utils.js';

class Indicator extends Service {
    static {
        Service.register(this, {
            'popup': ['double', 'string'],
        });
    }

    #delay = 1500;
    #count = 0;

    /**
     * @param {number} value - 0 < v < 1
     * @param {string} icon
     */
    popup(value, icon) {
        this.emit('popup', value, icon);
        this.#count++;
        Utils.timeout(this.#delay, () => {
            this.#count--;

            if (this.#count === 0)
                this.emit('popup', -1, icon);
        });
    }

    speaker() {
        this.popup(
            Audio.speaker?.volume || 0,
            getAudioTypeIcon(Audio.speaker?.icon_name || ''),
        );
    }


    connect(event = 'popup', callback) {
        return super.connect(event, callback);
    }
}

export default new Indicator();
