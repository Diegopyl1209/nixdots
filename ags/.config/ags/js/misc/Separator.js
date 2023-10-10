import Gtk from 'gi://Gtk';

export default ({ orientation = 'horizontal', ...rest } = {}) => ags.Widget({
    ...rest,
    type: Gtk.Separator,
    orientation: Gtk.Orientation[orientation.toUpperCase()],
});
