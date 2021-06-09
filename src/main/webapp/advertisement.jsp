<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="cp1251" %>
<html lang="en">
<head>
    <title>Car Market | Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function loadCities() {
            $.ajax("./ajax", {
                    method: "get",
                    data: {operation: "cities"},
                    complete: function (data) {
                        if (data.responseText.length > 0) {
                            var items = JSON.parse(data.responseText);
                            var result = "";
                            for (var i = 0; i < items.length; i++) {
                                var item = items[i];
                                result += "<option value=" + item.id + ">" + item.name + "</option>\n";
                            }
                            document.getElementById("cmCity").innerHTML = result;
                        }
                    }
                }
            )
        }

        $(document).ready(function () {
            $.ajax("./ajax", {
                method: "get",
                data: {operation: "brand"},
                complete: function (data) {
                    if (data.responseText.length > 0) {
                        var items = JSON.parse(data.responseText);
                        var result = "";
                        for (var i = 0; i < items.length; i++) {
                            var item = items[i];
                            result += "<option value=" + item.id + ">" + item.name + "</option>\n";
                        }
                        document.getElementById("cmMark").innerHTML = result;
                    }
                }
            });

            $('#cmMark').change(function () {
                $('#iModel').find('option').remove();
                $('#iModel').append('<option>Select Model</option>');

                let mid = $('#cmMark').val();

                $.ajax("./ajax", {
                        method: "get",
                        data: {
                            operation: "model",
                            id: mid
                        },
                        complete: function (data) {
                            if (data.responseText.length > 0) {
                                var items = JSON.parse(data.responseText);
                                var result = "";
                                for (var i = 0; i < items.length; i++) {
                                    var item = items[i];
                                    result += "<option value=" + item.id + ">" + item.name + "</option>\n";
                                }
                                document.getElementById("cmModel").innerHTML = result;
                            }
                        }
                    }
                )
            });
        });

        function doLogout() {
            window.location = "index.jsp";
        }

        loadCities();
    </script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <!-- Brand -->
    <a class="navbar-brand" id="navbar" href="#">Car Market</a>

    <!-- Links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">Главная страница</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp"> <c:out
                    value="${user.name}"/> | Выйти</a>
        </li>
    </ul>
</nav>

<div class="container-left" style="background-color:white;padding:10px">

    <div class="container" style="padding-top: 20px; padding-bottom: 20px">
        <form action="/carseller/ajax" method="post" enctype="multipart/form-data">
            <table width="100%" cellspacing="10px">
                <tr>
                    <td>
                        <table width="100%">
                            <div>
                                <tr>
                                    <td><b>Наименование Объявления:</b></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input class="form-control" id="name" name="name"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Город</b></td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <select class="form-control" id="cmCity" name="cmCity">
                                        </select>
                                        <input type="text" style="width:100%" id="iCity" name="iCity" hidden/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Марка</b></td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <select class="form-control" id="cmMark" name="cmMark">
                                        </select>
                                        <input type="text" style="width:100%" id="iMark" name="iMark" hidden/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Модель</b></td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <select class="form-control" id="cmModel" name="cmModel">
                                        </select>
                                        <input type="text" style="width:100%" id="iModel" name="iModel" hidden/>
                                    </td>
                                </tr>
                                <tr>
                                    <br>
                                    <td><b>Описание объявления:</b></td>
                                </tr>
                                <tr>
                                    <td>
                                        <area rows="2" class="form-control" id="descriptions" name="descriptions"
                                              maxlength="500"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td><b>Год выпуска</b></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="number" id="iYear" name="iYear">
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td><b>Цена</b></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="number" id="iPrice" name="iPrice"
                                                                       width="70px">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br>
                                        <input type="file" id="iFile" name="iFile">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br>
                                        <button type="submit" class="btn btn-primary" style="float:left;
                                       margin-right:10px" onclick="return validate();">Принять
                                        </button>
                                    </td>
                                    <td>
                                        <br>
                                        <button type="button" onclick="doCancel();" class="btn btn-danger"
                                                style="float:right">Отмена
                                        </button>
                                    </td>
                                </tr>
                            </div>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<table class="table table-striped" id="table">
</table>


</body>
</html>