package cs5530;


import java.sql.*;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by kojiminamisawa and Taku Sakikawa on 2018/03/11.
 */
public class API {

    public static boolean update(String sql, Statement stmt){
//        System.out.println("executing "+sql);
        try{
            stmt.executeUpdate(sql);
            return true;
        }
        catch(Exception e)
        {
            System.out.println("cannot execute the query" + e);
            return false;
        }
    }

    public static boolean ID_ISAvailable(String id, Statement stmt)
    {
        String sql = "select * from UU u where u.login = '" + id + "';";

        ResultSet rs = null;
        String loginID = "";

        try{
            rs = stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            while (rs.next()){
                loginID = rs.getString("login");
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        if(loginID == null || loginID.isEmpty()) {
            return true;
        }

        return false;
    }


    public static boolean Registration_UUser(UUser user, Statement stmt) {


        String sql="INSERT INTO UU VALUES ('"+ user.getLogin_ID() + "','" + user.getPw() + "','"
                +  user.getName() + "','" + user.getAddress() + "','" + user.getCity() + "','"
                + user.getState() + "','" + user.getPhone() + "');";
        System.out.println("Executed SQL: " + sql);
        return update(sql, stmt);

    }

    public static String[] Get_Available_Hours(String pid, Statement stmt)
    {
        String Available_Hours[] = new String[2];
        String sql = "select P.fromHour, P.toHour from Period P where P.pid = '" + pid + "';";

        ResultSet rs = null;

        try{
            rs = stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                Available_Hours[0] = rs.getString("fromHour");
                Available_Hours[1] = rs.getString("toHour");
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        if(Available_Hours[0] == null || Available_Hours[0].isEmpty()) {
            return new String[2];
        }

        return Available_Hours;
    }


    public static boolean Registration_UDriver(UD driver, Statement stmt) {
        String sql="INSERT INTO UD VALUES ('"+ driver.getLogin_ID() + "','" + driver.getPw() + "','"
                +  driver.getName() + "','" + driver.getAddress()+ "','"  + driver.getCity()+ "','"
                + driver.getState()+ "','" + driver.getPhone() + "');";
        System.out.println("Executed SQL: " + sql);
        return update(sql, stmt);
    }


    public static boolean Add_New_Car(UC car, Statement stmt) {
        String sql="INSERT INTO UC VALUES ('"+ car.getVin() + "','" +  car.getCategory() + "','"
                + car.getMake()+ "','" + car.getModel() + "','" + car.getYear() + "','" + car.getLogin() + "');";
        System.out.println("Executed SQL: " + sql);
        return update(sql, stmt);
    }


    public static void Update_UC_Info(UC car, Statement stmt, String col, String new_value) throws Exception{
        String sql = "";
        if (col == "year"){
            try {
                int new_year = Integer.parseInt(new_value);
                sql = "UPDATE UC SET " + col + " = " + new_year + " WHERE login = '" + car.getLogin() + "' and vin = '" + car.getVin() + "';";
            }catch (NumberFormatException e){
                System.err.println("The year must be typed in with numbers.");
                return;
            }
        }else{
            sql = "UPDATE UC SET " + col + " = '" + new_value + "' WHERE login = '" + car.getLogin() + "' and vin = '" + car.getVin() + "';";
        }

        System.out.println("Executed SQL: " + sql);
        if(stmt.executeUpdate(sql) <= 0){
            System.err.println("VIN number does not match. Please verify your vin number is correct.");
        }else{
            System.out.println("The " + car.getLogin() + "'s UC " + "modified: ");
        }
    }

    public static boolean Login_Vin_Matches(Statement stmt, String login, String vin) throws Exception{
        String UC_info[] = new String[2];
        String sql = "select C.login, C.vin from UC C where C.login = '" + login + "' AND C.vin = '" + vin + "';";
        System.out.println("Executed SQL: " + sql);

        String output="";
        ResultSet rs = null;

        try{
            rs = stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                UC_info[0] = rs.getString("login");
                UC_info[1] = rs.getString("vin");
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        if(UC_info[0] == null || UC_info[0].isEmpty()) {
            return false;
        }

        return true;
    }

    public static Person Login_User(boolean isUser, String login, String pw, Statement stmt)
    {
        Person person;
        String person_info[] = new String[7];

        String sql = "";
        if(isUser){
            sql = "select * from UU where login = '" + login + "' and pw = '"+ pw + "';";
        }else{
            sql = "select * from UD where login = '" + login + "' and pw = '"+ pw + "';";
        }

        String output="";
        ResultSet rs = null;
//        System.out.println("executing "+sql);
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                person_info[0] = rs.getString("login");
                person_info[1] = rs.getString("pw");
                person_info[2] = rs.getString("name");
                person_info[3] = rs.getString("address");
                person_info[4] = rs.getString("city");
                person_info[3] = rs.getString("state");
                person_info[4] = rs.getString("phone");
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        if(person_info[0] == null || person_info[0].isEmpty()) {
            return null; // When the given credential info doesn't match with DB.
        }

        if(isUser){
            person = new UUser(person_info[0],person_info[1],person_info[2],person_info[3],person_info[4], person_info[5], person_info[6]);

        }else{
            person = new UD(person_info[0],person_info[1],person_info[2],person_info[3],person_info[4], person_info[5], person_info[6]);

        }

        return person;
    }

    public static void Update_UD_OperationHour(int startHour , int endHour, String login, Statement stmt)
    {
        String sql="INSERT INTO Period (fromHour, toHour) VALUES (" + startHour +", " + endHour+ ");";
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);

        sql="INSERT INTO Available (login) VALUES ( '"+ login+ "' );";
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);
    }

    /**
     * Insert ther trust information into the Trust table in the databases
     *
     * @param login1 login id of the user who review the other user
     * @param login2 login id of the user who has been reviewed by other
     * @param Truested whether login2 is trueed by login1 or not (1: trusted 0:not trusted)
     * @param stmt
     */
    public static void Add_Trusted_User(String login1, String login2, int Truested, Statement stmt)
    {
        String sql="INSERT INTO Trust VALUES ('"+ login1 + "','" + login2 + "'," + Truested +");" ;
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);
    }

    /**
     * Insert the feedback into the Feedback table in the databases.
     *
     * @param score score of the ride
     * @param message short review for the ride
     * @param date date of the ride
     * @param login login id of the user
     * @param vin vin number of the car
     * @param stmt
     */
    public static void Add_Feedback(int score, String message, Date date, String login, String vin , Statement stmt)
    {
        String sql = "INSERT INTO Feedback (score, text, fbdate, login, vin ) VALUES ("+ score+", '"+message+"', '"+date+"', '"+login+"', '"+vin+"');" ;
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);

    }

    /**
     * Insert the rates infromation to the Rates table in the databases.
     *
     * @param rateFid rateFid
     * @param login login id of the user
     * @param rating whether the feedback was useful or not.
     * @param stmt
     */
    public static void ADD_Feedback_Rating(int rateFid, String login , String rating, Statement stmt)
    {
        String sql = "INSERT INTO Rates VALUES ("+ rateFid+", '"+login+"', '"+rating+"');" ;
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);


    }

    /**
     * get the list of the reservation in the past.
     *
     * @param login login information of the user
     * @param stmt
     * @return the list of the reservation in the past.
     */
    public static ArrayList<String[]> Show_Past_Reservation(String login,Statement stmt)
    {
        System.out.println("\t\tvin\tpid\tcost\tdate");

        Date currentDay = new Date(Calendar.getInstance().getTime().getTime());
        String sql = "select vin, pid, cost ,r.date from Reserve r where r.date < '"+currentDay.toString()+"' and login = '"+login+"' order by date desc;";
//        System.out.println(sql);

        ResultSet rs = null;

        ArrayList<String[]> result = new ArrayList<>();



        int count = 1 ;

//        System.out.println("executing "+sql);
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            while (rs.next()){
                String[] arr = new String[4];
                arr[0]= rs.getString("vin");
                arr[1]= rs.getString("pid");
                arr[2]= rs.getString("cost");
                arr[3]= rs.getString("date");

//                result.add(str1);
                System.out.println("No."+count+":\t"+arr[0]+"\t"+arr[1]+"\t$"+arr[2]+"\t"+arr[3]);
                result.add(arr);
                count++;
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close result set");
            }
        }

        return result;
    }

    /**
     * Get the starting hour and end hour based on the pid given.
     * @param pid pid
     * @param stmt
     * @return  the starting hour and end hour
     */
    public static String[] GetFromToHour(String pid, Statement stmt)
    {
        String result[] = new String[2];
        String sql= "select fromHour, toHour from Period where pid ="+pid+";";
        ResultSet rs = null;
//        System.out.println("executing "+sql);
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            while (rs.next()){

                result[0] =  rs.getString("fromHour");
                result[1] = rs.getString("toHour");
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }
        return result;


    }


    /**
     * Shows the availability of the car on the date.
     * @param vin vin numebr of the car
     * @param date date the user checks for the availability
     * @param stmt
     * @return the pid that this car is available on the date
     */
    public static ArrayList<String> Show_Avaliable(String vin, Date date, Statement stmt)
    {
        ArrayList<String> result = new ArrayList<>();
        String sql = "select a.pid from (" +
                "(select pid from Available where login = " +
                "(select login " +
                "from UC " +
                "where vin = '"+ vin+"')) as a) " +
                "left join (" +
                "(select pid " +
                "from Reserve " +
                "where date = '"+date.toString()+"' and vin = '"+ vin+"') as r)\n" +
                "on a.pid = r.pid\n" +
                "where r.pid is null;";

        ResultSet rs = null;
//        System.out.println("executing "+sql);
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                String str1 =  rs.getString("pid");
                result.add(str1);
                System.out.println( str1);


            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }
        return result;

    }


    /**
     * helper method to show the stats of the databases
     *
     * @param sql sql query
     * @param stmt
     * @param s1 first table column name
     * @param s2 second table column name
     * @param s3 third table column name 1
     */
    private static void Show_Stats_Helper(String sql, Statement stmt, String s1,String s2,String s3)
    {
        ResultSet rs = null;
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            while (rs.next()){
                String str1 =  rs.getString(s1);
                String str2 =  rs.getString(s2);
                String str3 =  rs.getString(s3);

                System.out.println( str1 + "\t" + str2 + "\t" + str3 );


            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }
    }

    /**
     * Shows the list of m highly rated UDs (defined by the average scores from all feedbacks a UD has received for all of his/her UCs) for each category
     * @param number number of highly rated drivers this user wants to see
     * @param stmt
     */
    public static void Show_Highly_Rated_UD(int number, Statement stmt )
    {
        System.out.println("login\tvin\tcategory");
        String sql = "select UC.login , UC.vin, UC.category from UC, ((SELECT a.vin, a.category FROM ((select vin, avgScore, category from UC c, ((select login,(sum(sum)/sum(count)) as avgScore from ((select count(*) as count, (avg(score) * count(*)) as sum, f.vin, c.login from Feedback f, UC c where c.vin = f.vin group by f.vin) as temp) group by login) temp2) where temp2.login = c.login) as a )\n" +
                "  LEFT JOIN ((select vin, avgScore, category from UC c, ((select login,(sum(sum)/sum(count)) as avgScore from ((select count(*) as count, (avg(score) * count(*)) as sum, f.vin, c.login from Feedback f, UC c where c.vin = f.vin group by f.vin) as temp) group by login) temp2) where temp2.login = c.login) as a2)\n" +
                "    ON a.category = a2.category AND a.avgScore <= a2.avgScore\n" +
                "GROUP BY a.vin\n" +
                "HAVING COUNT(*) <= "+number+"\n" +
                "ORDER BY a.category, a.avgScore DESC) as temp9) where UC.vin = temp9.vin order by UC.category;";

        Show_Stats_Helper(sql,stmt,"login","vin","category");

    }


    /**
     * Shows the list of m most expensive UCs (defined by the average cost of all rides on a UC) for each category
     * @param number number of expensive cars this user wants to see
     * @param stmt
     */
    public static void Show_Expensive_UC(int number, Statement stmt)
    {
        System.out.println("vin\tcategory\tavgCost");
        String sql = "SELECT a.* FROM ((select vin, category, avg(cost) as avgCost from ((select r.rid, r.cost, r.vin, r.login as user, c.category, c.login as driver from Ride r, UC c where r.vin = c.vin) as temp) group by vin) as a)\n" +
                "  LEFT JOIN ((select vin, category, avg(cost) as avgCost from ((select r.rid, r.cost, r.vin, r.login as user, c.category, c.login as driver from Ride r, UC c where r.vin = c.vin) as temp) group by vin) as a2)\n" +
                "    ON a.category = a2.category AND a.avgCost <= a2.avgCost\n" +
                "GROUP BY a.vin\n" +
                "HAVING COUNT(*) <= "+number+"\n" +
                "ORDER BY a.category, a.avgCost DESC;";

        Show_Stats_Helper(sql,stmt,"vin","category","avgCost");


    }


    /**
     * Shows the list of the m (say m = 5) most popular UCs (in terms of total rides) for each category,
     * @param number number of popular cars this user wants to see
     * @param stmt
     */
    public static void Show_Popular_UC(int number, Statement stmt)
    {
        System.out.println("total\tvin\tcategory");
        String sql = "SELECT a.* FROM ((select count(*) as total, vin, category from ((select r.rid, r.cost, r.vin, r.login as user, c.category, c.login as driver from Ride r, UC c where r.vin = c.vin) as temp) group by vin) as a)\n" +
                "  LEFT JOIN ((select count(*) as total, vin, category from ((select r.rid, r.cost, r.vin, r.login as user, c.category, c.login as driver from Ride r, UC c where r.vin = c.vin) as temp) group by vin) as a2)\n" +
                "    ON a.category = a2.category AND a.total <= a2.total\n" +
                "GROUP BY a.vin\n" +
                "HAVING COUNT(*) <= "+number+"\n" +
                "ORDER BY a.category, a.total DESC;";

        Show_Stats_Helper(sql,stmt,"total","vin","category");

    }

    /**
     * This method shows the infomation of useful users
     *
     * @param number umber of User information the admin user wants to see
     * @param stmt
     */
    public static void  Admin_Show_Useful_User(int number, Statement stmt)
    {
        System.out.println("login\tpw\tname\taddress\tcity\tstate\tphone");
        String sql ="select UU.* from UU, ((select f.login, avg(rating) as rate from Feedback f, Rates r where f.fid = r.fid group by f.login order by rate desc limit "+number+") as temp1) where temp1.login = UU.login;";
        Admin_Show_Helper(stmt, sql);
    }

    /**
     * This method shows the information of highly trusted users
     *
     * @param number number of User information the admin user wants to see
     * @param stmt
     */
    public static void Admin_Show_Trust_User(int number, Statement stmt)
    {
        System.out.println("login\tpw\tname\taddress\tcity\tstate\tphone");
        String sql = "select UU.* from\n" +
                "((select leftlog2, trustCount, COALESCE(login2, leftlog2) as login2, COALESCE(untrustcount, 0) as untrustcount from \n" +
                "((select login2 as leftlog2, count(*) as trustCount from Trust where isTrusted =1 group by login2) temp1) left join\n" +
                "((select login2, count(*) as untrustcount from Trust where isTrusted =0 group by login2) temp2) on \n" +
                "temp1.leftlog2 = temp2.login2\n" +
                "union\n" +
                "select COALESCE(leftlog2, login2) as leftlog2, COALESCE(trustCount, 0) as trustCount, login2, untrustcount from \n" +
                "((select login2 as leftlog2, count(*) as trustCount from Trust where isTrusted =1 group by login2) temp1) right join\n" +
                "((select login2, count(*) as untrustcount from Trust where isTrusted =0 group by login2) temp2) on \n" +
                "temp1.leftlog2 = temp2.login2) as temp3), UU where UU.login = leftlog2 order by (trustCount - untrustcount) desc limit "+number+";";

        Admin_Show_Helper(stmt, sql);
    }

    private static void Admin_Show_Helper(Statement stmt, String sql)
    {
        ResultSet rs = null;
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                String str1 =  rs.getString("login");
                String str2 =  rs.getString("pw");
                String str3 =  rs.getString("name");
                String str4 = rs.getString("address");
                String str5 = rs.getString("city");
                String str6 = rs.getString("state");
                String str7 = rs.getString("phone");
                System.out.println( str1 + "\t" + str2 + "\t" + str3 + "\t" + str4 + "\t" + str5+ "\t" + str6+"\t" + str7);
            }
            System.out.println();
            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }
    }

    /**
     * This method shows the user's desired number of useful feedback
     *
     * @param login login id of the user
     * @param number number of the feedback this user wants to see
     * @param stmt
     */
    public static void Show_Useful_Feedback(String login , int number, Statement stmt)
    {
        System.out.println("fid\tscore\ttext\tfbdate\tlogin\tvin");
        String sql = "select Feedback.fid, score, text, fbdate, login, vin " +
                "from Feedback, ((select fid, avg(rating) as avgUseful " +
                "from ((select f.fid, f.score, f.login as reviewer, f.vin, c.login as carower, r.rating " +
                "from Feedback f, UC c, Rates r where f.vin = c.vin and c.login = '"+login+"' and f.fid = r.fid) as god) group by fid order by avgUseful desc limit "+ number+") as temp)" +
                " where temp.fid = Feedback.fid;";

//        System.out.println("executing "+sql);

        show_Feedback_Helper(stmt, sql);
    }


    /**
     * Helper method to show feedbacks.
     *
     * @param stmt
     * @param sql sql query.
     */
    private static void show_Feedback_Helper(Statement stmt, String sql)
    {
        ResultSet rs = null;
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                String str1 =  rs.getString("fid");
                String str2 =  rs.getString("score");
                String str3 =  rs.getString("text");
                String str4 = rs.getString("fbdate");
                String str5 = rs.getString("login");
                String str6 = rs.getString("vin");
                System.out.println( str1 + "\t" + str2 + "\t" + str3 + "\t" + str4 + "\t" + str5+ "\t" + str6);


            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

    }

    /**
     * This method shows all of the feedback in the databases sorted by fid
     * @param stmt
     */
    public static void Show_Feedack( Statement stmt)
    {

        System.out.println("fid\tscore\ttext\tfbdate\tlogin\tvin");

        String sql = "select * from Feedback order by fid;";

        ResultSet rs = null;
        show_Feedback_Helper(stmt, sql);
    }

    /**
     * This method create a sql query and insert the information into the Favorite table in the databases
     *
     * @param vin favorite car's vin number
     * @param login login information of the user
     * @param date date that user enters this information
     * @param stmt
     */
    public static void Add_User_Favorite_Car(String vin, String login, Date date, Statement stmt)
    {
        String sql = "INSERT INTO Favorites VALUES ('"+ vin+"', '"+login+"', '"+date.toString()+"');" ;
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);

    }

    /**
     * This method create a sql query and insert the information into the Reserve table in the databases
     *
     * @param login login information of the user
     * @param vin vin number of the car
     * @param pid pid assosiated with starting time and end time
     * @param cost cost of the ride
     * @param date date of the ride
     * @param stmt
     */
    public static void User_Add_Reservation(String login, String vin, String pid, double cost, Date date, Statement stmt)
    {
        String sql = "INSERT INTO Reserve VALUES ('"+ login+"', '"+vin+"', '"+pid+"', "+cost+", '"+date.toString()+"');" ;
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);
    }


    /**
     * This method create a sql query and insert the information into the record table in the databases
     *
     * @param cost cost of the ride
     * @param date date of the ride
     * @param vin vin number of the car
     * @param login login information of the user
     * @param fromHour ride starting time
     * @param toHour ride end time
     * @param stmt
     */
    public static void User_Record_Ride(String cost,Date date,String vin,String login,Time fromHour,Time toHour, Statement stmt)
    {
        String sql = "INSERT INTO Ride (cost, date, vin, login, fromHour, toHour ) VALUES ("+ cost+", '"+date.toString()+"', '"+vin+"', '"+login+"', '"+fromHour.toString()+"', '"+toHour.toString()+"');" ;
        System.out.println("Executed SQL: " + sql);
        update(sql, stmt);
    }

    /**
     * Users may search for UCs, by asking conjunctive queries on the category, and/or address (at CITY or State level),
     * and/or model by keywords (e.g. BMW, Toyota, F150).
     * Your system should allow the user to specify that the results are to be sorted
     * (a) by the average numerical score of the feedbacks, or
     * (b) by the average numerical score of the trusted user feedbacks.
     * @param isAND
     * @param sortA
     * @param user
     * @param category
     * @param city
     * @param state
     * @param model
     * @param stmt
     * @return
     */
    public static ArrayList<String[]> UC_Browse(boolean isAND, boolean sortA, String user, String category, String city, String state, String model, Statement stmt){
        ArrayList<String[]> UC_Info_List = new ArrayList<>();
        String sql = "";

        if(sortA){
            sql = "select distinct c.vin, c.make, c.model, c.year, f.avg as avgScore from UD d, UC c ,(" +
                    "(select vin, avg(score) as avg from Feedback group by vin) " +
                    "as f) " +
                    "where f.vin = c.vin and d.login = c.login " +
                    "and (";
        }else{
            sql = "select distinct c.vin, c.make, c.model, c.year, temp2.avgScore from UD d, UC c, " +
                    "((select vin, avg(score) as avgScore from ((select f.vin, f.login ,f.score from Feedback f , " +
                    "((select login2 from Trust where login1 = '" + user + "' and isTrusted = 1) as t), " +
                    "((select c.vin from UD d, UC c where d.login = c.login) as hello) where f.login = t.login2 " +
                    "and hello.vin = f.vin ) as temp1) group by vin) as temp2) where c.vin = temp2.vin " +
                    "and (";
        }

        if(isAND){
            sql += " c.category = '"+ category + "'";
            sql += " and d.city = '" + city + "'";
            sql += " and d.state = '" + state + "'";
            sql += " and c.model = '" + model + "'";
        }else{
            sql += " c.category = '"+ category + "'";
            sql += " or d.city = '" + city + "'";
            sql += " or d.state = '" + state + "'";
            sql += " or c.model = '" + model + "'";
        }
        sql += " ) group by c.vin order by avgScore desc;";

        String output="";
        ResultSet rs = null;
//        System.out.println("executing "+sql);
        try{
            rs=stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                String[] UC_info = new String[5];
                UC_info[0] = rs.getString("vin");
                UC_info[1] = rs.getString("make");
                UC_info[2] = rs.getString("model");
                UC_info[3] = rs.getString("year");
                UC_info[4] = rs.getString("avgScore");
                UC_Info_List.add(UC_info);
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        return UC_Info_List;
    }

    /**
     * When a user records his/her reservations to a UC A, your system should give a list of other suggested UCs.
     * UC B is suggested, if there exist a user X that hired both A and B.
     * The suggested UCs should be sorted on decreasing total rides count (i.e., most popular first);
     * count only rides by users like X.
     * @param vin
     * @param login
     * @param stmt
     * @return
     */
    public static ArrayList<String[]> Suggest_Other_UC(String vin, String login, Statement stmt) {
        ArrayList<String[]> suggested_UC_Info_List = new ArrayList<>();

        String sql = "select distinct c.vin, c.category, c.make, c.model, c.year, c.login as OtherRentUser, count(r1.vin) as RidesCount " +
                "from Ride r1 join UC c on r1.vin = c.vin " +
                "where r1.login IN (" +
                "select r2.login " +
                "from Ride r2 " +
                "where r2.vin = '" + vin + "' and r2.login != '" + login +  "'" +
                ") " +
                "and r1.vin != " + "'" + vin + "' " +
                "group by c.vin " +
                "order by RidesCount DESC;" ;

        String output="";
        ResultSet rs = null;

        try{
            rs = stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                String[] suggested_UC_Info = new String[7];
                suggested_UC_Info[0] = rs.getString("vin");
                suggested_UC_Info[1] = rs.getString("category");
                suggested_UC_Info[2] = rs.getString("make");
                suggested_UC_Info[3] = rs.getString("model");
                suggested_UC_Info[4] = rs.getString("year");
                suggested_UC_Info[5] = rs.getString("OtherRentUser");
                suggested_UC_Info[6] = rs.getString("RidesCount");

                suggested_UC_Info_List.add(suggested_UC_Info);
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        return suggested_UC_Info_List;
    }

    /**
     * Helper method to determine whether two users are one degree away.
     * @param user1
     * @param user2
     * @param stmt
     * @return
     */
    private static boolean Check_One_Degree_Separation(String user1, String user2, Statement stmt){
        int mutual_UCs = 0;

        String sql = "select count(*) as Mutual_UCs " +
                "from Favorites f1 join Favorites f2 on f1.vin = f2.vin " +
                "where f1.login = '" + user1 + "' and f2.login = '" + user2 + "';";

        ResultSet rs = null;

        try{
            rs = stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                mutual_UCs = Integer.parseInt(rs.getString("Mutual_UCs"));
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        if(mutual_UCs > 0){
            return true;
        }
        return false;
    }

    /**
     * Helper method for separation function.
     * @param user Given username
     * @param stmt
     * @return List of other users who have favorited at least one same UC.
     */
    private static ArrayList<String> Get_one_degree_UU_Names(String user, Statement stmt){
        ArrayList<String> UU_Name_List = new ArrayList<>();

        String sql = "select distinct f1.login " +
                "from Favorites f1 " +
                "where f1.vin IN (" +
                "select f2.vin " +
                "from Favorites f2 " +
                "where f2.login = '" + user + "') " +
                "and f1.login != '" + user + "';";

        ResultSet rs = null;

        try{
            rs = stmt.executeQuery(sql);

            if (rs == null){
                System.out.println("Null detected");
            }

            int count = 0;
            while (rs.next()){
                String username = rs.getString("login");
                UU_Name_List.add(username);
            }

            rs.close();
        }
        catch(Exception e){
            System.out.println(e.getMessage());

            System.out.println("cannot execute the query");
        }
        finally {
            try{
                if (rs!=null && !rs.isClosed()){
                    rs.close();
                }
            }
            catch(Exception e){
                System.out.println("cannot close resultset");
            }
        }

        return UU_Name_List;
    }

    /**
     * Given two user names (logins), determine their degree of separation, defined as follows:
     * Two users A and B are 1-degree away if they have both favorited at least one common UC;
     * They are 2-degrees away if there exists an user C who is 1-degree away from each of A and B,
     * AND A and B are not 1-degree away at the same time.
     *
     * @param user1
     * @param user2
     * @param stmt
     * @return
     */
    public static int Check_Degree_Of_Separation(String user1, String user2, Statement stmt){
        if(Check_One_Degree_Separation(user1, user2, stmt)){
            return 1;
        }else{
            ArrayList<String> one_degree_from_user1 = Get_one_degree_UU_Names(user1, stmt);
            ArrayList<String> one_degree_from_user2 = Get_one_degree_UU_Names(user2, stmt);

            for (String username : one_degree_from_user1){
                if(one_degree_from_user2.contains(username)){
                    return 2;
                }
            }
        }

        return 0;
    }
}