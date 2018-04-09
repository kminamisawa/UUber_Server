<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/02
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>
    <h1 style="text-align: center;"><span style="color: #ff6600;"><img src="https://html-online.com/editor/tinymce4_6_5/plugins/emoticons/img/smiley-cool.gif" alt="cool" /> Welcome to U-UBER<img src="https://html-online.com/editor/tinymce4_6_5/plugins/emoticons/img/smiley-cool.gif" alt="cool" /></span></h1>
</div>
<div style="text-align: center;"><form action="login.jsp" method="get" name="UserIDInfo">
    <%--<p>&lt;%--<input name="searchAttribute" type="hidden" value="login" />--%&gt;</p>--%>
    <p><strong>Login ID:</strong>&nbsp;<input name="UserID" type="text" /></p>
    <p><strong>Password:</strong>&nbsp;<input name="Password" type="password" /></p>
        <p style="text-align: center;"><select id="ddlViewBy">
            <option value="User">User</option>
            <option value="Driver">Driver</option>
        </select></p>
    <p><input type="submit" value="Login"/></p>
</form></div>
<div>
    <p style="text-align: center;">&nbsp;</p>
</div>
<div>
    <h4 style="text-align: center;"><span style="color: #ff6600;">Create a New Account</span></h4>
</div>
<div>
    <p style="text-align: center;"><strong> Login id:&nbsp;</strong><input maxlength="20" name="login" size="15" type="text" placeholder="username" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>Password:&nbsp;</strong><input maxlength="4" name="pass" size="15" type="text" placeholder="password" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>Name:&nbsp;</strong><input maxlength="20" name="name" size="15" type="text" placeholder="name" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>Street:&nbsp;</strong><input maxlength="4" name="street" size="15" type="text" placeholder="street" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>City:&nbsp;</strong><input maxlength="20" name="city" size="15" type="text" placeholder="city" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>State:&nbsp;</strong><input maxlength="4" name="state" size="15" type="text" placeholder="state" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>Zip:&nbsp;</strong><input maxlength="4" name="zip" size="15" type="text" placeholder="84000" /></p>
</div>
<div>
    <p style="text-align: center;"><strong>Phone:&nbsp;</strong><input maxlength="4" name="phone" size="15" type="text" placeholder="8011234567" /></p>
</div>
<div>
    <p style="text-align: center;"><select>
        <option value="User">User</option>
        <option value="Driver">Driver</option>
    </select></p>
</div>
<div><form action="http://google.com">
    <p style="text-align: center;"><input type="submit" value="Register" /></p>
</form></div>