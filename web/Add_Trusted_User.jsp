<%--
  Created by IntelliJ IDEA.
  User: kojiminamisawa
  Date: 2018/04/11
  Time: 0:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="cs5530.*"%>
<html>
<head>
    <title>Add Trusted Users</title>

    <script LANGUAGE="javascript">
        function myEnter(){
            var myRet = confirm("Do you confirm to record this ride?");
            if (myRet === true ){
                // alert("Confirmed.");
                return true;
            }else{
                // alert("Cancelled.");
                return false;
            }
        }

        function cancel_reservation(){
            var cancel_confirmation = confirm("Are you sure you want to go back to the the main menu? You cannot undo this action.");
            if ( cancel_confirmation === true ){
                // alert("Reservation Cancelled.");
                return true;
            }else{
                // alert("Reservation Cancelled");
                return false;
            }
        }

        function goBack() {
            window.history.back();
        }
    </script>

</head>
<body>
    <h1 style="text-align: center;"><span style="color: #ff6600;"><strong>UUber Trusted User</strong></span></h1>
<%
    Connector2 con = new Connector2();
    UUser user = (UUser) session.getAttribute("user");
    String TRUSTED_ID = request.getParameter("TRUSTED_ID");
    String TRUST_OP = request.getParameter("TRUST_OP");
    Boolean has_trusted = (Boolean) session.getAttribute("Add_Trusted_User_has_trusted");

    if(TRUSTED_ID == null || TRUSTED_ID.isEmpty()){
%>


    <div style="text-align:center">
        <form name="trust_user" method=get onsubmit="return myEnter()" action="Add_Trusted_User.jsp">
            <%
                session.setAttribute("Add_Trusted_User_has_trusted", true);
            %>
            <p><strong>Login ID of Trusted/Un-Trusted User:</strong>
                <input name="TRUSTED_ID" type="text" required pattern=".*\S+.*">
            </p>

            <strong>Do You Trust or Un-Trust the User:</strong>
            <select name="TRUST_OP" >
                <option>Trust</option>
                <option>Un-Trust</option>
            </select><br>

            <p><input type=submit value="Submit"></p>
        </form>
    </div>
<%
    }else if (has_trusted != null && has_trusted){
        boolean sql_executed = false;
        if (user.getLogin_ID().compareTo(TRUSTED_ID) == 0){
%>
    <h2 style="text-align: center;"><span style="color: #ff0000; background-color: #000000;">You cannot trust or un-trust yourself.</span></h2>

<%
        }else{
            if(TRUST_OP != null && TRUST_OP.compareTo("Trust") == 0){
                sql_executed = API.Add_Trusted_User(user.getLogin_ID(), TRUSTED_ID, 1, con.stmt);
                if(sql_executed) {
%>

    <h2 style="text-align: center;"><span style="color: #0000ff;"><strong>The user is successfully trusted.</strong></span></h2>
<%
            }else{
%>

    <h2 style="text-align: center;"><span style="color: #ff0000; background-color: #000000;">This user is already trusted/un-trusted by you or does not exist.</span></h2>

<%
            }
        }else if(TRUST_OP != null && TRUST_OP.compareTo("Un-Trust") == 0){
            sql_executed = API.Add_Trusted_User(user.getLogin_ID(), TRUSTED_ID, 0, con.stmt);
                if(sql_executed){


%>

    <h2 style="text-align: center;"><span style="color: #0000ff;"><strong>The user is successfully un-trusted.</strong></span></h2>
<%
            }else{
%>
    <h2 style="text-align: center;"><span style="color: #ff0000; background-color: #000000;">This user is already trusted/un-trusted by you or does not exist.</span></h2>
<%
                }
            }
        }
    }
%>

    <div style="text-align:center">
        <form name="back_to_menu" method=get action="User_Login.jsp">
            <input type=submit value="Back to the Main Menu">
        </form>
    </div>

<%
    con.closeConnection();
%>
</body>
</html>
