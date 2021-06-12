<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="cp1251" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
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

        $(document).ready(function () {

            $("#but_upload").click(function () {

                var fd = new FormData();
                var files = $('#cmPhotoId')[0].files[0];
                fd.append('file', files);

                $.ajax({
                    url: '/ajax',
                    type: 'post',
                    data: fd,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response != 0) {
                            $("#img").attr("src", response);
                            $(".preview img").show(); // Display image element
                        } else {
                            alert('file not uploaded');
                        }
                    },
                });
            });
        });

        function validate() {
            var valuea = $('#name').val(),
                valueb = $('#cmCity').val(),
                valuec = $('#cmMark').val(),
                valued = $('#cmModel').val(),
                valuee = $('#cmYear').val(),
                valuef = $('#cmPrice').val(),
                valueg = $('#descriptions').val(),
                result = false;
            if (valuea == '') {
                alert($('#name').attr('title'));
            } else if (valueb == '') {
                alert($('#cmCity').attr('title'));
            } else if (valuec == '') {
                alert($('#cmMark').attr('title'));
            } else if (valued == '') {
                alert($('#cmModel').attr('title'));
            } else if (valuee == '') {
                alert($('#cmYear').attr('title'));
            } else if (valuef == '') {
                alert($('#cmPrice').attr('title'));
            } else if (valueg == '') {
                alert($('#descriptions').attr('title'));
            }
            else {
                result = true;
            }
            return result;
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
        <li class="nav-item" style="float: right; text-align: right;">
            <a class="nav-link" type="hidden" value="${user.id}">
            </a>
        </li>
        <li class="nav-item" style="float: right; text-align: right;">
            <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp">
                <c:out value="${user.name}"/> | Выйти</a>
        </li>
    </ul>
</nav>

<div class="container-left" style="background-color:white;padding:10px">

    <div class="container" style="padding-top: 20px; padding-bottom: 20px">
        <div class="card-body">
            <form action="/ajax" method="post" enctype="multipart/form-data">
                <div class="check-box" align="center">
                    <td>
                        <tr>
                            <input type="file" id="cmPhotoId" name="cmPhotoId"/>
                        </tr>
                    </td>
                </div>
                </br>
                <input type="button" class="button" value="Upload" id="but_upload">
            </form>
            <form action="/advertisement.do" method="post">
                <table width="100%" cellspacing="10px">
                    <tr>
                        <td>
                            <table width="100%">
                                <tr>
                                    <td><b>Наименование Объявления:</b></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" id="name" name="name"
                                               title="Название Объявления" placeholder="Название Объявления"/>
                                        <input type="hidden" class="form-control" id="userId" name="userId"
                                               value="${user.id}"/>
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Город</b></td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <select class="form-control" id="cmCity" name="cmCity" title="Город">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Марка</b></td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <select class="form-control" id="cmMark" name="cmMark" title="Марка">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Модель</b></td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <select class="form-control" id="cmModel" name="cmModel" title="Модель">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <br>
                                    <td><b>Описание объявления:</b></td>
                                </tr>
                                <tr>
                                    <td>
                                        <textarea rows="3" class="form-control" id="descriptions" name="descriptions"
                                                  title="Описание объявления" maxlength="500"
                                                  placeholder="Максимальная длина 500 символов"></textarea>
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
                                                                <input type="number" id="cmYear" name="cmYear"
                                                                       title="Год выпуска машины"
                                                                       placeholder="Год выпуска машины">
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
                                                                <input type="number" id="cmPrice" name="cmPrice"
                                                                       title="Цена" placeholder="Цена" width="70px">
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
                            </table>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

</body>
</html>