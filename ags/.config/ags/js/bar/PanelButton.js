const { Button, Box } = ags.Widget;

export default ({ className, content, ...rest }) => Button({
    className: `panel-button ${className}`,
    child: Box({ vertical:true, homogeneous: false, children: [content] }),
    ...rest,
});
