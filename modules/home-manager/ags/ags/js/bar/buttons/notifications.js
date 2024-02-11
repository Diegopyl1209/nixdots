import Service from 'resource:///com/github/Aylur/ags/service.js';
import { exec, subprocess } from 'resource:///com/github/Aylur/ags/utils.js';


class NotificationsService extends Service {
    
    static {
        Service.register(
            this,
            {
                'notification-changed': ['string'],
            },
            {
                // 'kebab-cased-name': [type as a string from GObject.TYPE_<type>, 'r' | 'w' | 'rw']
                // 'r' means readable
                // 'w' means writable
                // guess what 'rw' means
                'notification-value': ['string', 'r'],
            },
        );
    }

    #proc = null
    #notificationValue = '';

    constructor() {
        super();

        subprocess(
            ['swaync-client', '--subscribe-waybar'],
            (output) => {
                console.log(output);
                this.#notificationValue = output;
                this.#onChange();
            },
            (err) => logError(err),
        )

        console.log("aaaaaaaaaaaaaa")

        // initialize
        this.#onChange();
    }


    #onChange() {
        
        this.emit('changed'); // emits "changed"
        this.notify('notification-value'); // emits "notify::screen-value"


        this.emit('notification-changed', this.#notificationValue);
    }

}

const service = new NotificationsService();

// export to use in other modules
export default service;