<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 02.05.2021
  Time: 23:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>Error 404 (Page Not Found))!!!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.0/normalize.min.css" />
    <style>
        html, body{
            height: 100%;
            font-size: 62.5%;
            font-family: Verdana, sans-serif;
        }
        .container {
            position: relative;
            height: 100%;
            width: 100%;
        }
        .inner {
            position: absolute;
            max-width: 960px;
            top: 30%;
            left: 20%;
            right: 0;
        //margin-top: -9px;
            font-size: 13px;
            font-weight: 400;
        }
        .grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
        }
        .cell {
            box-sizing: border-box;
            flex-shrink: 0;
            width: calc(100% * 5 / 12);
        }
        img {
            height: 100%;
            width: 100%;
        }
        @media only screen and (max-width:600px) {
            .inner {
                left: 10%;
            }
            .cell {
                width: 100%;
            }
            img {
                padding-top: 50px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="inner">
        <div class="grid">
            <div class="cell" id="write"></div>
            <div class="cell"><img src="https://i.imgur.com/4LsiZPo.jpg" /></div> <!-- https://i.imgur.com/tMJkbbq.png -->
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/typeit/5.10.6/typeit.min.js"></script>
<script>
    new TypeIt('#write', {
        strings: ["<b>404.</b> That’s an error.","", "The requested URL /s.html was not found on this server.", "That’s all we know."],
        speed: 50,
        autoStart: false
    });
</script>
</body>
</html>