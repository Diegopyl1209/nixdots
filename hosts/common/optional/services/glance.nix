{
  config,
  lib,
  ...
}: {
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        port = 8070;
        assets-path = "${config.server.dataDir}/Glance/Assets";
      };
      pages = [
        {
          name = "Search";
          width = "slim";
          #hide-desktop-navigation = true;
          center-vertically = true;
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  autofocus = true;
                }
                {
                  type = "monitor";
                  cache = "1m";
                  title = "Services";
                  sites = [
                    {
                      title = "Jellyfin";
                      url = "http://localhost:8096";
                      icon = "si:jellyfin";
                    }
                    {
                      title = "QBittorrent";
                      url = "http://localhost:9092";
                      icon = "si:qbittorrent";
                    }
                    {
                      title = "Sonarr";
                      url = "http://localhost:8989";
                      icon = "si:sonarr";
                    }
                    {
                      title = "Vaultwarden";
                      url = "http://100.64.0.3:8222";
                      icon = "si:vaultwarden";
                    }
                    {
                      title = "Freshrss";
                      url = "http://100.64.0.3:8220";
                      icon = "si:rss";
                    }
                  ];
                }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "General";
                      links = [
                        {
                          title = "Gmail";
                          url = "https://mail.google.com/mail/u/0/";
                        }
                        {
                          title = "Github";
                          url = "https://github.com/";
                        }
                      ];
                    }
                    {
                      title = "Entertainment";
                      links = [
                        {
                          title = "Youtube";
                          url = "https://www.youtube.com/";
                        }
                      ];
                    }
                    {
                      title = "Social";
                      links = [
                        {
                          title = "Reddit";
                          url = "https://www.reddit.com/";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
          ];
        }
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {type = "calendar";}
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 3;
                  cache = "3h";
                  feeds = [
                    {url = "https://ciechanow.ski/atom.xml";}
                    {
                      url = "https://www.joshwcomeau.com/rss.xml";
                      title = "Josh Comeau";
                    }
                    {url = "https://samwho.dev/rss.xml";}
                    {url = "https://awesomekling.github.io/feed.xml";}
                    {
                      url = "https://ishadeed.com/feed.xml";
                      title = "Ahmad Shadeed";
                    }
                  ];
                }
              ];
            }

            {
              size = "full";
              widgets = [
                {
                  type = "hacker-news";
                  comments-url-template = "https://www.hckrnws.com/stories/{POST-ID}";
                }
                {
                  type = "videos";
                  channels = [
                    "UCGsVaz3QTFdspLqt79jIuPA" # Guinxu
                    "UCroqqI7XwD828o0rAvAF8iw" # Hunter-R.
                    "UCXtxgWwk55kVJo9lCCZRdmg" # VeritasiumES
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "selfhosted";
                    }
                    {
                      type = "reddit";
                      subreddit = "gamingnews";
                      show-thumbnails = true;
                    }
                  ];
                }
              ];
            }

            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  location = "Santiago, Chile";
                }
                {
                  type = "twitch-channels";
                  channels = [
                    "penguinz0"
                    "theprimeagen"
                    "asmongold"
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
