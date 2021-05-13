<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Authorization page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<style>
    #email, #password {
        width: 300px; /* Ширина поля в пикселах */
    }
</style>
<script>
    function validate() {
        if (document.getElementById("email").value == '') {
            alert("Логин не может быть пустым")
            return false;
        }
        if (document.getElementById("password").value == '') {
            alert("Пароль не может быть пустым")
            return false;
        }
        return true;
    }

    function doCancel() {
        window.location = "index.jsp";
    }

    function doRegistration() {
        window.location = "reg.do";
    }
</script>
<div class="container pt-3">
    <div class="row">
        <div class="card"
             style="position: center; margin-left: auto; margin-right: auto; left: 0; right: 0;">
            <div class="card-header">
                Авторизация
            </div>
            <div class="card-body">
                <form action="<%=request.getContextPath()%>/auth.do" method="post">
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" placeholder="Введите email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="password">Пароль:</label>
                        <input type="password" class="form-control" id="password" placeholder="Введите пароль"
                               name="password">
                    </div>

                    <button type="submit" class="btn btn-primary" onclick="validate();"
                            style="border-radius:5px; float:left; margin-right:10px">
                        Войти
                    </button>
                    <button type="button" onclick="doCancel();" class="btn btn-danger"
                            style="border-radius:5px; float:left; margin-right:10px">
                        Отмена
                    </button>
                    <br/>
                    <br/>
                    <button type="button" onclick="doRegistration();" class="btn btn-success"
                            style="border-radius:5px;float:left">Регистрация
                    </button>
                    <button type="reset" class="btn btn-warning"
                            style="border-radius:5px; float:left; margin-left:10px">
                        Очистить
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>