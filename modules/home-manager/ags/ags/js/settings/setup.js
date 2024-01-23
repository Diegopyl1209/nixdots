// @ts-nocheck
import options from '../options.js';
import icons from '../icons.js';
import { reloadScss, scssWatcher } from './scss.js';
import { globals } from './globals.js';

export function init() {
    globals();
    scssWatcher();
    dependandOptions();

    reloadScss();
}

function dependandOptions() {
    options.bar.style.connect('changed', ({ value }) => {
        if (value !== 'normal')
            options.desktop.screen_corners.setValue(false, true);
    });
}

