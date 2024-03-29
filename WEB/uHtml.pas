unit uHtml;

interface
const
    cstHTMLCss = '<!--body'
                    +'{'
                  +'margin: 0;'
                  +'padding: 0;'
                  +'display: flex;'
                  +'justify-content:center;'
                  +'align-items: center;'
                  +'min-height: 100vh;'
                  +'background: #060c21;'
                  +'font-family: ''poppins'',sans-serif;'
                +'}'
                +'.box{'
                  +'position:'
                  +'   '
                +'relative;'
                  +'width: 550px;'
                  +'height: 300px;'
                  +'display: flex;'
                  +'justify-content: center;'
                  +'align-items: center;'
                  +'background: #060c21;'
                +'}'
                +'  '
                +'.box:before{'
                  +'content:'''';'
                  +'position: absolute;'
                  +'top: -2px;'
                  +'left: -2px;'
                  +'right: -2px;'
                  +'bottom: -2px;'
                  +'background:#fff;'
                  +'z-index:-1;'
                +'}'

               +'   '
                +'.box:after{'
                  +'content:'''';'
                  +'position: absolute;'
                  +'top: -2px;'
                  +'left: -2px;'
                  +'right: -2px;'
                  +'bottom: -2px;'
                  +'background:#fff;'
                  +'z-index:-2;'
                  +'filter: blur(40px);'
                +'}'

                +'     '
                +'.box:before,'
                +'.box:after{'
                  +'background:linear-gradient(235deg,#89ff00,#060c21,#00bcd4);'
                +'}'
                +'         '
                +'.content{'
                  +'text-align:Left;'
                  +'padding: 20px;'
                  +'box-sizing: border-box;'
                  +'color:#fff;'
                +'  '
                +'}'
              +'.text{'
              +'font-size: 2em;'
              +'font-weight: bold;'
              +'fill: none;'
              +'stroke-width: 2px;'
              +'stroke-dasharray: 90 310;'
              +'animation: stroke 6s infinite linear;'
          +'}'
          +'.text-1{'
              +'stroke: #3498db;'
              +'text-shadow: 0 0 5px #3498db;'
              +'animation-delay: -1.5s;'
          +'}'
          +'.text-2{'
              +'stroke: #f39c12;'
              +'text-shadow: 0 0 5px #f39c12;'
              +'animation-delay: -3s;'
          +'}'
          +'.text-3{'
              +'stroke: #e74c3c;'
              +'text-shadow: 0 0 5px #e74c3c;'
              +'animation-delay: -4.5s;'
          +'}'
          +'.text-4{'
              +'stroke: #9b59b6;'
              +'text-shadow: 0 0 5px #9b59b6;'
              +'animation-delay: -6s;'
          +'}'
          +'@keyframes stroke {'
            +'100% {'
              +'stroke-dashoffset: -400;'
            +'}'
          +'}'
          +'.arrow_box{animation: glow 800ms ease-out infinite alternate; }'
          +'@keyframes glow {'
              +'0% {'
                  +'border-color: #393;'
                  +'box-shadow: 0 0 5px rgba(0,255,0,.2), inset 0 0 5px rgba(0,255,0,.1), 0 1px 0 #393;'
              +'}'
              +'100% {'
                  +'border-color: #6f6;'
                  +'box-shadow: 0 0 20px rgba(0,255,0,.6), inset 0 0 10px rgba(0,255,0,.4), 0 1px 0 #6f6;'
              +'}'
          +'}';
    cstHTMLBegin = '<html lang="en">'
                  +'<head>'
                  +'<meta charset="UTF8">'
                  +'<meta name="viewport" content="width=device-width, initial-scale=1.0">'
                  +'<meta http-equiv="X-UA-Compatible" content="ie=edge">'
                  +'<meta name="description" content="pricing static web pages">'
                  +'<title>YxCisSvr</title> '
                  +'<style type="text/css">'
                 +cstHTMLCss
              +'</style> '
              +'</head>'
              +'<body>'
                +'<div class="arrow_box">'
                +'<div class="box">'
                +'<div class="content">'
                +'<svg style="width:500px;height:50px">'
                +'<text text-anchor="middle" x="50%" y="50%" class="text text-1">'
                    +'Welcome mORMot WebBroker'
                +'</text>'
                +'<text text-anchor="middle" x="50%" y="50%" class="text text-2">'
                    +'Welcome mORMot WebBroker'
                +'</text>'
                +'<text text-anchor="middle" x="50%" y="50%" class="text text-3">'
                    +'Welcome mORMot WebBroker'
                +'</text>'
                +'<text text-anchor="middle" x="50%" y="50%" class="text text-4">'
                    +'Welcome mORMot WebBroker'
                +'</text>'
            +'</svg>';
    cstHTMLEnd = '</div>'
                +'</div>'
                +'</div>'
              +'</body>'

              +'</html>';
implementation

end.
