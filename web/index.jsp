<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/02
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <h1 style="text-align: center;"><span style="color: #ff6600;"><img src="https://html-online.com/editor/tinymce4_6_5/plugins/emoticons/img/smiley-cool.gif" alt="cool" />
      Welcome to U-UBER<img src="https://html-online.com/editor/tinymce4_6_5/plugins/emoticons/img/smiley-cool.gif" alt="cool" /></span></h1>
    <p style="text-align: center;"><strong> Login id:&nbsp;</strong><input maxlength="20" name="name" size="15" type="text" /></p>
    <p style="text-align: center;"><strong>Password:&nbsp;</strong><input maxlength="4" name="pass" size="15
          " type="password" /></p>
    <p style="text-align: center;"><select>
      <option value="User">User</option>
      <option value="Driver">Driver</option>
    </select></p>
    <form action="login.jsp">
      <p style="text-align: center;"><input type="submit" value="Login" /></p>
    </form>
    <p style="text-align: center;">&nbsp;</p>
    <h4 style="text-align: center;"><span style="color: #ff6600;">Create a New Account</span></h4>
    <p style="text-align: center;"><strong> Login id:&nbsp;</strong><input maxlength="20" name="name" size="15" type="text" placeholder="username" /></p>
    <p style="text-align: center;"><strong>Password:&nbsp;</strong><input maxlength="4" name="pass" size="15" type="text" placeholder="password" /></p>
    <p style="text-align: center;"><strong>Name:&nbsp;</strong><input maxlength="20" name="name" size="15" type="text" placeholder="name" /></p>
    <p style="text-align: center;"><strong>Street:&nbsp;</strong><input maxlength="4" name="pass" size="15" type="text" placeholder="street" /></p>
    <p style="text-align: center;"><strong>City:&nbsp;</strong><input maxlength="20" name="name" size="15" type="text" placeholder="city" /></p>
    <p style="text-align: center;"><strong>State:&nbsp;</strong><input maxlength="4" name="pass" size="15" type="text" placeholder="state" /></p>
    <p style="text-align: center;"><strong>Zip:&nbsp;</strong><input maxlength="4" name="pass" size="15" type="text" placeholder="84000" /></p>
    <p style="text-align: center;"><strong>Phone:&nbsp;</strong><input maxlength="4" name="pass" size="15" type="text" placeholder="8011234567" /></p>
    <p style="text-align: center;"><select>
      <option value="User">User</option>
      <option value="Driver">Driver</option>
    </select></p>
    <form action="http://google.com">
      <p style="text-align: center;"><input type="submit" value="Register" /></p>
    </form>
</html>
