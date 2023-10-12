import HoverRevealer from '../../misc/HoverRevealer.js';
import * as mpris from '../../misc/mpris.js';
import options from '../../options.js';
import { Widget, Mpris} from '../../imports.js';

export const getPlayer = (name = options.preferredMpris) =>
    Mpris.getPlayer(name) || Mpris.players[0] || null;

const MediaController = ({player} = {}) => Widget.Box({
    vertical: true,
    children: [
        Widget.Box({
            className: 'media panel-button',
            style: "border:0;",
            vertical: true,
            children: [
                PreviousButton(player),
                PlayPauseButton(player),
                NextButton(player),
            ],
        }),
        Widget.Box({
            className: `media-icon panel-button ${player.name}`,
            vertical: true,
            child: mpris.PlayerIcon(player),
        
        }),
    ],
});


export default ({ direction } = {}) => Widget.Box({
    connections: [[Mpris, box => {
        const player = getPlayer();
        box.visible = !!player;

        if (!player) {
            box._player = null;
            return;
        }

        if (box._player === player)
            return;

        box._player = player;
        //box.children = [Indicator({ player, direction })];
        box.children = [MediaController({ player })];
    }, 'notify::players']],
});


const PlayerButton = ({ player, items, onClick, prop, canProp, cantValue }) => Widget.Button({
    child: Widget.Stack({
        items,
        binds: [['shown', player, prop, p => `${p}`]],
    }),
    onClicked: player[onClick].bind(player),
    binds: [['visible', player, canProp, c => c !== cantValue]],
});


const playerButtonStyle = "font-family: FiraCode Nerd Font Mono; font-size: 34px; margin-bottom: -10px;  margin-top: -10px;";

const PlayPauseButton = player => PlayerButton({
    player,
    items: [
        ['Playing', Widget.Label({
            style: playerButtonStyle,
            className: 'playing',
            label: '󰏦',
        })],
        ['Paused', Widget.Label({
            style: playerButtonStyle ,
            className: 'paused',
            label: '',
        })],
        ['Stopped', Widget.Label({
            style: playerButtonStyle,
            className: 'stopped',
            label: '',
        })],
    ],
    onClick: 'playPause',
    prop: 'play-back-status',
    canProp: 'can-play',
    cantValue: false,
});


const PreviousButton = player => PlayerButton({
    player,
    items: [
        ['true', Widget.Label({
            style: playerButtonStyle + "font-size:20px;",
            justification: "left",
                wrap: true,
    useMarkup: false,
            className: 'previous',
            label: '󰒮',
        })],
    ],
    onClick: 'previous',
    prop: 'can-go-prev',
    canProp: 'can-go-prev',
    cantValue: false,
});

const NextButton = player => PlayerButton({

    player,
    items: [
        ['true', Widget.Label({
            style: playerButtonStyle + "font-size:20px;",
            className: 'next',
            label: "󰒭",
        })],
    ],
    onClick: 'next',
    prop: 'can-go-next',
    canProp: 'can-go-next',
    cantValue: false,
});
