<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <style>
        #email {
            width: 300px; /* Ширина поля в пикселах */
        }

        #name {
            width: 300px; /* Ширина поля в пикселах */
        }

        #pwd1 {
            width: 300px; /* Ширина поля в пикселах */
        }

        #pwd2 {
            width: 300px; /* Ширина поля в пикселах */
        }
    </style>
    <title>Create Account</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        function validate() {
            if (document.getElementById("email").value == '') {
                alert("Почта не может быть пустым")
                return false;
            }
            if (document.getElementById("name").value == '') {
                alert("Имя не может быть пустым")
                return false;
            }
            if (document.getElementById("pwd1").value == '') {
                alert("Пароль не может быть пустым")
                return false;
            }
            if (document.getElementById("pwd1").value != document.getElementById("pwd2").value) {
                alert("Пароли не совпадают")
                return false;
            }
            return true;
        }

        function doRegistration() {
            if (!validate()) return false;
            $.ajax("./ajax", {
                    method: "post",
                    data: {
                        command: "registration",
                        login: document.getElementById("email").value,
                        name: document.getElementById("name").value,
                        password: document.getElementById("pwd1").value
                    },
                    success: function () {
                        window.location = "ad.html";
                    }
                }
            );
        }

        function doCancel() {
            window.location = "index.html";
        }
    </script>
</head>
<body>

<div class="container">
    <h2>Регистрация</h2>
    <form action="<%=request.getContextPath()%>/reg.do" method="post">
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" placeholder="Введите email" name="email">
        </div>
        <div class="form-group">
            <label for="name">Имя:</label>
            <input type="name" class="form-control" id="name" placeholder="Введите имя" name="name">
        </div>
        <div class="form-group">
            <label for="pwd1">Пароль:</label>
            <input type="password" class="form-control" id="pwd1" placeholder="Введите пароль" name="pswd">
        </div>
        <div class="form-group">
            <label for="pwd2">Пароль еще раз:</label>
            <input type="password" class="form-control" id="pwd2" placeholder="Повторите пароль" name="pswd">
        </div>

        <button type="submit" class="btn btn-primary" style="border-radius:5px; float:left"> <!-- type="button" onclick="doRegistration();"-->
            Зарегистрировать
        </button>
        <button type="reset" class="btn btn-warning" style="border-radius:5px; float:left; margin-left:10px">
            Очистить
        </button>
        <button type="button" onclick="doCancel();" class="btn btn-danger"
                style="border-radius:5px; float:left; margin-left: 10px">
            Отмена
        </button>
    </form>
</div>
</body>
</html>