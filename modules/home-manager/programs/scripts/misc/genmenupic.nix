{config}: ''
  #!/bin/sh
  convert ${config.stylix.image} -define modulate:colorspace=HCL -resize 1920x1080 +repage -crop 380x570+600+310 -modulate 52 ~/.config/rofi/menu.png
''
