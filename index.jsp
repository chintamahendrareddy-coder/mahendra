<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>
<style>
body {
  font-family: 'Poppins', sans-serif;
  background-image: url('https://www.freepik.com/free-vector/digital-indian-rupee-rise-up-arrow-background-trading-concept_36813897.htm#fromView=keyword&page=1&position=0&uuid=41e5efba-e252-472e-8dc3-204a0c7d341a&query=Banking+background');
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  height: 100vh;
  margin: 0;
  display: flex;
  justify-content: center;
  align-items: center;
}

/* Semi-transparent overlay for better readability */
.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
  z-index: 0;
}

/* Centered login form */
form {
  position: relative;
  z-index: 1;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  padding: 40px;
  width: 320px;
  border-radius: 15px;
  box-shadow: 0 4px 30px rgba(0,0,0,0.3);
  text-align: center;
}

/* Heading style */
h2 {
  color: #ffffff;
  text-align: center;
  margin-bottom: 20px;
  font-weight: 600;
  text-shadow: 0 0 10px rgba(0,0,0,0.5);
}

/* Input fields */
input {
  width: 85%;
  padding: 10px;
  margin: 10px 0;
  border: none;
  border-radius: 6px;
  background: rgba(255,255,255,0.8);
  outline: none;
  font-size: 14px;
}

/* Button style */
button {
  background: #00bfa5;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  transition: background 0.3s ease;
}
button:hover {
  background: #008e76;
}
</style>
</head>
<body>

<div class="overlay"></div>

<div>
  <h2>🏦 Admin Login</h2>
  <form action="login.jsp" method="post">
    <input type="text" name="username" placeholder="Username" required><br>
    <input type="password" name="password" placeholder="Password" required><br>
    <button type="submit">Login</button>
  </form>
</div>

</body>
</html>
