<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>{{title or "Untitled"}}</title>
        <meta name="description" content="">
        <meta name="author" content="ink, cookbook, recipes">
        <meta name="HandheldFriendly" content="True">
        <meta name="MobileOptimized" content="320">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

        <!-- Place favicon.ico and apple-touch-icon(s) here  -->

        <link rel="stylesheet" type="text/css" href="/static/css/ink-flex.min.css">
        <link rel="stylesheet" type="text/css" href="/static/css/font-awesome.min.css">

        <!-- load inks css for IE8 -->
        <!--[if lt IE 9 ]>
            <link rel="stylesheet" href="/static/css/ink-ie.min.css" type="text/css" media="screen" title="no title" charset="utf-8">
        <![endif]-->

        <script type="text/javascript" src="/static/js/mithril.js"></script>
        <script type="text/javascript" src="/static/js/app.js"></script>
        <!-- test browser flexbox support and load legacy grid if unsupported -->
        <script type="text/javascript" src="/static/js/modernizr.js"></script>
        <script type="text/javascript">
            Modernizr.load({
              test: Modernizr.flexbox,
              nope : '/static/css/ink-legacy.min.css'
            });
        </script>

        <style type="text/css">
            html, body {
                height: 100%;
                background: #f0f0f0;
            }
            .wrap {
                min-height: 100%;
                height: auto !important;
                height: 100%;
                margin: 0 auto -120px;
                overflow: auto;
            }
            .push, footer {
                height: 120px;
                margin-top: 0;
            }
            footer {
                background: #ccc;
                border: 0;
            }
            footer * {
                line-height: inherit;
            }
            .top-menu {
                background: #1a1a1a;
            }
        </style>
    </head>

    <body>

        <div class="wrap">
            <div class="top-menu">
                <nav class="ink-navigation ink-grid">
                    <ul class="menu horizontal black">
                        <li class="active"><a href="#">Feeds</a></li>
                    </ul>
                </nav>
            </div>

            <div class="ink-grid vertical-space">
                {{!base}}
            </div>
            <div class="push"></div>
        </div>

        <footer class="clearfix">
            <div class="ink-grid">
                <ul class="unstyled inline half-vertical-space">
                    <li class="active"><a href="#">About</a></li>
                </ul>
                <p class="note">TODO: fill this in</p>
            </div>
        </footer>

    </body>

</html>
