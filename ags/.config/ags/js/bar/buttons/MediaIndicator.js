import HoverRevealer from '../../misc/HoverRevealer.js';
import * as mpris from '../../misc/mpris.js';
import options from '../../options.js';
const { Box, Label, Button, Icon, Stack } = ags.Widget;
const { Mpris } = ags.Service;

export const getPlayer = (name = options.preferredMpris) =>
    Mpris.getPlayer(name) || Mpris.players[0] || null;

const Indicator = ({ player, direction = 'right' } = {}) => HoverRevealer({
    className: `media panel-button ${player.name}`,
    direction,
    onPrimaryClick: () => player.playPause(),
    onScrollUp: () => player.next(),
    onScrollDown: () => player.previous(),
    onSecondaryClick: () => player.playPause(),
    indicator: mpris.PlayerIcon(player),
    child: Label({
        vexpand: true,
        truncate: 'end',
        maxWidthChars: 40,
        connections: [[player, label => {
            label.label = `${player.trackArtists[0]} - ${player.trackTitle}`;
        }]],
    }),
    connections: [[player, revealer => {
        if (revealer._current === player.trackTitle)
            return;

        revealer._current = player.trackTitle;
        revealer.revealChild = true;
        ags.Utils.timeout(3000, () => {
            revealer.revealChild = false;
        });
    }]],
});

const PlayerButton = ({ player, items, onClick, prop, canProp, cantValue }) => Button({
    child: Stack({
        items,
        binds: [['shown', player, prop, p => `${p}`]],
    }),
    onClicked: player[onClick].bind(player),
    binds: [['visible', player, canProp, c => c !== cantValue]],
});

const playerButtonStyle = "font-family: FiraCode Nerd Font Mono; font-size: 34px; margin: -10px;";

const PlayPauseButton = player => PlayerButton({
    player,
    items: [
        ['Playing', Label({
            style: playerButtonStyle,
            className: 'playing',
            label: '󰏦',
        })],
        ['Paused', Label({
            style: playerButtonStyle ,
            className: 'paused',
            label: '',
        })],
        ['Stopped', Label({
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
        ['true', Label({
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
        ['true', Label({
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


const MediaController = ({player} = {}) => Box({
    vertical: true,
    children: [
        Box({
            className: 'media panel-button',
            style: "border:0;",
            vertical: true,
            children: [
                PreviousButton(player),
                PlayPauseButton(player),
                NextButton(player),
            ],
        }),
        Box({
            className: `media-icon panel-button ${player.name}`,
            vertical: true,
            child: mpris.PlayerIcon(player),
        
        }),
    ],
});

export default ({ direction } = {}) => Box({
    vertical: true,
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
    }]],
});
