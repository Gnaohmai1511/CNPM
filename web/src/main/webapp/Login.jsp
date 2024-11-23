<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
</head>
<body>
    <h1>Login</h1>
    <form action="/web/LoginServlet" method="post">
        <label>Email </label>
        <input type="email" id="email" name="email" placeholder="Enter your email"><br>
        <label>Password </label>
        <input type="password" id="password" name="password" placeholder="Enter your password"><br>
        <a href="Register.jsp">Don't have an account? Register here!</a><br>
        <a href="ForgotPW.jsp">Forgot password?</a><br>
        <input type="submit" name="submit" value="Login">
    </form>

    <!-- Google Login Link -->
    <a href="javascript:void(0);" class="google-login" onclick="onSignIn()">Login with Google</a>

    <script>
        // This function is called when the user clicks the login link
        function onSignIn() {
            gapi.auth2.getAuthInstance().signIn().then(function(googleUser) {
                var id_token = googleUser.getAuthResponse().id_token;

                // Send the ID token to your backend for verification
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '/web/GoogleLoginServlet');
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function() {
                    console.log('Signed in as: ' + xhr.responseText);
                };
                xhr.send('idtoken=' + id_token);
            });
        }

        // Load Google auth2 library after the page is loaded
        function startApp() {
            gapi.load('auth2', function() {
                gapi.auth2.init({
                    client_id: 'YOUR_CLIENT_ID.apps.googleusercontent.com',
                });
            });
        }
        
        startApp();
    </script>
</body>
</html>
