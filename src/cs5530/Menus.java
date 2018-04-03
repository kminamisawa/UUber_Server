package cs5530;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by kojiminamisawa and Taku Sakikawa on 2018/03/13.
 */

public class Menus {

    private static String choice = "";
    private static String driver_choice = "";

    private static String user_username = "";
    private static String driver_username = "";

    private static String user_pw = "";
    private static String driver_pw = "";

    private static boolean logged_in = false;

    private static String sql;
    private static UUser logged_in_user = new UUser();
    private static UD logged_in_driver = new UD();

    private static int welcome_count = 0;
    private static int logged_in_user_count = 0;
    private static int logged_in_driver_count = 0;

    private static int pid=0;
//    private static int update_uc_count = 0;


    private static boolean is_welcome_screen = true;
    /**
     * @param args
     */
    public static void displayMenu() {
        System.out.println("\n        Welcome to UUber System       ");
        System.out.println("1. Log in as User");
        System.out.println("2. Log in as Driver");
        System.out.println("3. Create a UU account");
        System.out.println("4. Create a UD account");
        System.out.println("5. Admin User Login (password is 'omg')");
        System.out.println("6. exit:");
        System.out.println("Please enter your choice:");
    }

    public static void displayMenu_User(UUser user) {
        System.out.println("\nWelcome back " + user.getName() +"!");
        System.out.println("1. Make Reservation");
        System.out.println("2. Record a Ride");
        System.out.println("3. Add a Favorite Car");
        System.out.println("4. Give a Feedback");
        System.out.println("5. Rate a Feedback");
        System.out.println("6. Add a Trusted User");
        System.out.println("7. Browse UC");
        System.out.println("8. See Useful Feedback");
        System.out.println("9. See the Most Popular UC");
        System.out.println("10. See the Most Expensive UC");
        System.out.println("11. See Highly Rated UD");
        System.out.println("12. Check Degrees of Separation");
        System.out.println("13. exit:");
        System.out.println("Please enter your choice:");
    }

    /**
     * Displays the options for the admin user.
     */
    public static void displayMenu_Admin()
    {
        System.out.println("1. See m most trusted users");
        System.out.println("2. See m most useful users");
        System.out.println("3. exit:");
        System.out.println("Please enter your choice:");
    }

    public static void displayMenu_Driver(UD driver) {
        System.out.println("\nWelcome back " + driver.getName() +"!");
        System.out.println("1. Add New UC");
        System.out.println("2. Modifying Existing UC");
        System.out.println("3. Add Operation Hour");
        System.out.println("4. exit:");
        System.out.println("Please enter your choice:");
    }

    public static void displayMenu_UpdateUC() {
        System.out.println("Please select which information you would like to edit:");
        System.out.println("1. VIN Number");
        System.out.println("2. Category");
        System.out.println("3. Make");
        System.out.println("4. Model");
        System.out.println("5. Year");
        System.out.println("6. Exit");
        System.out.println("Please enter your choice:");
    }


    public static void welcome(BufferedReader in, Connector2 con) throws Exception{
        while(true) {
            displayMenu();

            while ((choice = in.readLine()) == null && choice.length() == 0) ;
            try {
                welcome_count = Integer.parseInt(choice);
            } catch (Exception e) {

                continue;
            }
            if (welcome_count < 1 | welcome_count > 5)
                continue;
            if (welcome_count == 1) {
                System.out.println("Please Enter Your Username:");
                while ((user_username = in.readLine()) == null && user_username.length() == 0) ;

                System.out.println("please Enter Your Password:");
                while ((user_pw = in.readLine()) == null && user_pw.length() == 0) ;

                logged_in_user = (UUser) API.Login_User(true, user_username, user_pw, con.stmt);
                if (logged_in_user == null){
                    System.err.println("Incorrect username or password. Please try again.");
                    continue;
                }else{
                    Handle_Logged_In_User(in, con);
                }

                break;
            } else if (welcome_count == 2) {
                System.out.println("Please Enter Your Username:");
                while ((driver_username = in.readLine()) == null && driver_username.length() == 0) ;

                System.out.println("please Enter Your Password:");
                while ((driver_pw = in.readLine()) == null && driver_pw.length() == 0) ;

                logged_in_driver = (UD) API.Login_User(false, driver_username, driver_pw, con.stmt);
                if (logged_in_driver == null){
                    System.err.println("Incorrect username or password. Please try again.");
                    continue;
                }else{
                    Handle_Logged_In_Driver(in, con);
                }

                break;
            } else if (welcome_count == 3) {
                UUser new_user = new UUser();
                if (!register_person(new_user, 1, con, in)) {
                    System.err.println("There was an error in input. Please try again.");
                    continue;
                }
            } else if (welcome_count == 4) {
                UD new_driver = new UD();
                if (!register_person(new_driver, 2, con, in)) {
                    System.err.println("There was an error in input. Please try again.");
                    continue;
                }
            }
            else if (welcome_count == 5) {
                String password = "";
                System.out.println("Password:");
                while ((password = in.readLine()) == null && password.length() == 0) ;

                if(password.equals("omg"))
                {
                    Handle_Admin_User(in, con);
                }
                else
                {
                    System.out.println("Incorrect Password");
                    continue;
                }

            }

            else {
                System.out.println("EoM");
                con.stmt.close();

                break;
            }
        }
    }



    /**
     * It registers user and driver to UUber Database System.
     *
     * @param person User or driver to be registered in DB
     * @param option :1 = user, 2=driver
     * @param con connector to DB system
     * @param in input from CLI
     * @return False if there is an error with input. True otherwise.
     * @throws Exception
     */
    public static boolean register_person(Person person, int option, Connector2 con, BufferedReader in) throws Exception{
        int count = 0;
        for(String s : UUser.data_sets){
            String input;
            System.out.println("\nEnter your "+ s +":");
            while ((input = in.readLine()) == null && input.length() == 0);

            if(input.isEmpty()){
                System.err.println("Null in input stream");
                return false;
            }

            switch (count) {
                case 0:
                    System.out.println(input);
                    person.set_login(input);
                    break;
                case 1:
                    person.set_pw(input);
                    break;
                case 2:
                    person.set_name(input);
                    break;
                case 3:
                    person.set_address(input);
                    break;
                case 4:
                    person.set_city(input);
                    break;
                case 5:
                    person.set_state(input);
                    break;
                case 6:
                    person.set_phone(input);
                    break;
                default:
                    break;

            }
            count++;
        }

        if(option == 1){
            API.Registration_UUser((UUser) person, con.stmt);
        }else if (option == 2){
            API.Registration_UDriver((UD) person, con.stmt);
        }
        return true;
    }

    /**
     * This method handles the admin user.
     * Displays the options for the admins and it does things based on the admin's choice
     * @param in
     * @param con
     * @throws Exception
     */
    private static void Handle_Admin_User(BufferedReader in, Connector2 con) throws Exception {
        while(true) {
            displayMenu_Admin();

            int count = 0 ;
            while ((choice = in.readLine()) == null && choice.length() == 0) ;
            try {
                count = Integer.parseInt(choice);
                System.out.println(count);
            } catch (Exception e) {
                continue;
            }

            switch (count)
            {
                case 1: // See m most trusted users
                    //TODO
                    Admin_See_Trust_User(in, con);
                    break;

                case 2:
                    //TODO
                    Admin_See_Useful_User(in, con);
                    //User_Record_Ride(in, con);
                    break;

                case 3:
                    welcome(in, con);
                    break;

                default:
                    break;
            }


        }

    }

    /**
     * This is the home page for the logged in users.
     * This method directs to various features that user choose to use.
     * @param in
     * @param con
     * @throws Exception
     */
    public static void Handle_Logged_In_User(BufferedReader in, Connector2 con) throws Exception{

        while(true) {
            displayMenu_User(logged_in_user);
            while ((choice = in.readLine()) == null && choice.length() == 0) ;
            try {
                logged_in_user_count = Integer.parseInt(choice);
//                System.out.println(logged_in_user_count);
            } catch (Exception e) {
                continue;
            }

            switch (logged_in_user_count)
            {
                case 1: // make reservation
                    User_Add_Reservation(in, con);
                    break;

                case 2:
                    User_Record_Ride(in, con);
                    break;

                case 3: // favorite car
                    User_Add_FavoriteCar(in, con);
                    break;

                case 4: //Give a Feedback
                    User_Add_Feedback(in, con);
                    break ;

                case 5: // 5. Rate a Feedback
                    User_Rate_Feedback(in, con);
                    break;

                case 6: // add trusted user.
                    User_Add_Trusted(in, con);
                    break;

                case 7: // Search for UC
                    User_Browse_UC(in, con);
                    break;
                case 8:
                    User_See_Useful_Feedback(in, con);
                    break;

                case 9:
                    User_Stats(in, con, 1);
                    break;

                case 10:
                    User_Stats(in, con, 2);
                    break;

                case 11:
                    User_Stats(in, con, 3);
                    break;

                case 12:
                    Show_Degree_Of_Separation(in, con);
                    break;

            }

            if (logged_in_user_count == 13) {
                welcome(in, con);
                break;
            }
        }
    }



    public static void Handle_Logged_In_Driver(BufferedReader in, Connector2 con) throws Exception{
        while(true){
            displayMenu_Driver(logged_in_driver);
            while ((choice = in.readLine()) == null && choice.length() == 0) ;

            try {
                logged_in_driver_count = Integer.parseInt(choice);
            } catch (Exception e) {
                continue;
            }


            switch (logged_in_driver_count){
                case 1: // Add new UC
                    UC new_car = add_new_UC(in);
                    if (!new_car.equals(null)){
                        API.Add_New_Car(new_car, con.stmt);
                    }
                    break;
                case 2: // Update existing UC
                    update_UC(in, con);
                    break;
                case 3: // add operation hours
                    update_UD_hours(in, con);

                    break;
                case 4:
                    welcome(in, con);
                    break;
                default:
                    break;
            }
        }
    }

    /**
     * User can decided whether other users are trustworthy or not.
     * They cannot review themselves. The user1 and user2 must be in the UU table.
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_Add_Trusted(BufferedReader in, Connector2 con) throws IOException
    {
        boolean b ;
        String login ;
        String Trust; // either Y or N
        int isTrusted =0; // 0= false, 1= true

        while (true)
        {
            b = true;
            System.out.println("Please Enter the login of other user");
            while ((login = in.readLine()) == null && login.length() == 0) ;
            if (login.equals(logged_in_user.getLogin_ID())) {
                System.out.println("You cannot review yourself");
                b = false;
            }
            if(b) {
                System.out.println("Do you trust this user? (Enter Y or N)");
                while ((Trust = in.readLine()) == null && Trust.length() == 0) ;
                if (Trust.equalsIgnoreCase("Y")) {
                    isTrusted = 1;
                } else if (Trust.equalsIgnoreCase("N")) {
                    isTrusted = 0;
                } else {
                    System.out.println("Please type either Y or N");
                    b = false;
                }
            }

            if(b)
                break;
        }

        API.Add_Trusted_User(logged_in_user.getLogin_ID(), login, isTrusted, con.stmt);


    }

    /**
     * User can add a feedback of the ride
     * Asks the information of the ride and insert the feedback into the database
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_Add_Feedback(BufferedReader in, Connector2 con) throws  IOException
    {


        String vin;
        int score = -1 ;
        String message ="";
        Date date;


        while(true) {
            boolean b = true ;

            System.out.println("Please Enter the Vin number of the car you want to review.");
            while ((vin = in.readLine()) == null && vin.length() == 0) ;
            if(vin.length() == 0 )
            {
                System.out.println("Please enter a valid vin number");
                b = false;
            }


            if(b) {
                System.out.println("Please enter the score from 0 - 10");
                String s = in.readLine();
                try {
                    score = Integer.parseInt(s);
                } catch (NumberFormatException e) {
                    System.out.println("please a number");
                    b = false;
                }
                if (score > 10 || score < 0) {
                    System.out.println("The score must be between 0 and 10");
                    b = false;
                }
                while (s == null && s.length() == 0) ;

                if(b){
                    System.out.println("Please enter some messages. When done, please hit the enter key."); // not sure what to put
                    while ((message = in.readLine()) == null && message.length() == 0) ;

                    if(message.length() < 6 ){
                        System.out.println("Please enter more than 5 characters");
                        b = false;
                    }
                }
            }


            if(vin.length() != 0 && message.length() != 0 && b)
                break;
        }


        date = new Date(Calendar.getInstance().getTime().getTime());
        System.out.println(date.toString());
        API.Add_Feedback(score, message,date,logged_in_user.getLogin_ID(),vin ,con.stmt);
    }

    /**
     * User can review the feedback and determine whether the feedback is useful
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_Rate_Feedback(BufferedReader in, Connector2 con) throws IOException
    {
        boolean b;
        String temp;

        String YesOrNo;
        int rateFid=-1;
        String rating ="";


        while(true)
        {
            b= true;

            System.out.println("Do you want to see all the Feedback? (Y/N)");
            while ((YesOrNo = in.readLine()) == null && YesOrNo.length() == 0) ;
            if (YesOrNo.equalsIgnoreCase("Y")) {
                API.Show_Feedack(con.stmt);

            } else if (YesOrNo.equalsIgnoreCase("N")) { }
            else {
                System.out.println("Please type either Y or N");
                b = false;
            }

            if(b)
            {
                System.out.println("Please enter the fid you want to give a rating");
                temp = in.readLine();
                try
                {
                    rateFid = Integer.parseInt(temp);
                }
                catch (NumberFormatException e)
                {
                    System.out.println("Fid is a number, please try again");
                    b = false;
                }
                while (temp == null && temp.length() == 0) ;

                if(b)
                {
                    System.out.println("Please rate the feedback (0 = useless, 1 = useful, 2 = very useful)");
                    while ((rating = in.readLine()) == null && rating.length() == 0) ;

                    if( !(rating.equals("0")) && !(rating.equals("1")) && !(rating.equals("2")))
                    {
                        b =false;
                        System.out.println("Please type either 0, 1, or 2");
                    }
                }
            }
            if(b)
                break;
        }
        API.ADD_Feedback_Rating(rateFid,logged_in_user.getLogin_ID(), rating, con.stmt);



    }

    /**
     * Drivers can add one or more operation hours.
     * @param in
     * @param con
     * @throws Exception
     */
    private static void update_UD_hours(BufferedReader in, Connector2 con) throws Exception
    {
        int startHour = 0 ;
        int endHour = 0 ;
        boolean IsValid ;

        while (true) {
            IsValid =true;
            System.out.println("Please enter the your starting hour:");
            String s = in.readLine();
            try {
                startHour = Integer.parseInt(s);
            }
            catch (NumberFormatException e)
            {
                IsValid = false;
            }
            while (s == null && startHour == 0) ;

            System.out.println("Please enter the your end hour:");
            s = in.readLine();
            try {
                endHour = Integer.parseInt(s);
            }
            catch (NumberFormatException e)
            {
                IsValid = false;
            }


            while (s == null && endHour == 0) ;

            if(startHour < endHour && IsValid)
                break;
            else
                System.out.println("invalid operation hour. Please try again");
        }

        API.Update_UD_OperationHour(startHour, endHour, logged_in_driver.getLogin_ID(), con.stmt);

    }

    /**
     * User can add their favorite car
     * Asks the user for the information of the car and insert the information into the database
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_Add_FavoriteCar(BufferedReader in, Connector2 con) throws IOException
    {

        boolean b;
        String vin;

        while(true)
        {
            b = true;

            System.out.println("Please enter your favorite car's vin number");
            while ((vin = in.readLine()) == null && vin.length() == 0) ;

            if(vin.isEmpty())
            {
                System.out.println("Please enter the vin number");
                b = false;
            }

            if(b)
                break;
        }
        Date date = new Date(Calendar.getInstance().getTime().getTime());
        API.Add_User_Favorite_Car(vin, logged_in_user.getLogin_ID(), date, con.stmt);


    }

    /**
     * Asks the user for the information of the reservation and insert the information into the database
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_Add_Reservation(BufferedReader in, Connector2 con) throws IOException
    {
        String vin;
        Date date = null ;
        String pid = "";
        ArrayList<String> availablePid = new ArrayList<>();
        double cost = -1 ;
        String y;
        String m;
        String d;

        String confirmation ;

        while (true)
        {
            boolean b= true;

            // ask for the vin
            System.out.println("Please Enter the vin number of the car you want to reserve");
            while ((vin = in.readLine()) == null && vin.length() == 0);
            if(vin.isEmpty())
            {
                b = false;
                System.out.println("Pleas type the vin number");
            }


            if(b) { // ask for the date
                System.out.println("Date Information:");
                System.out.println("Please Enter the Year");
                while ((y = in.readLine()) == null && y.length() == 0);

                System.out.println("Please Enter the Month");
                while ((m = in.readLine()) == null && m.length() == 0);

                System.out.println("Please Enter the Day");
                while ((d = in.readLine()) == null && d.length() == 0);

                System.out.println(y+"-"+m+"-"+d);

                try{
                    Date dd = new Date(Calendar.getInstance().getTime().getTime());

                    date = Date.valueOf(y+"-"+m+"-"+d);

                    if (dd.compareTo(date)>0) // past
                    {
                        System.out.println("The date you enter is in the past");
                        b = false;
                    }



                } catch (IllegalArgumentException e )
                {
                    System.out.println("Date information is not valid");
                    b = false;
                }
            }

            if(b)
            {
                availablePid = API.Show_Avaliable(vin, date, con.stmt);

                if(availablePid.isEmpty())
                {
                    System.out.println("This car is not available on this date \nPlease choose a different car");
                    b = false;
                }
                else
                {
                    System.out.println("Available pid:");
                    System.out.println("Please choose one of the pid from the above");
                }

            }


            if(b) // pid
            {

                while ((pid = in.readLine()) == null && pid.length() == 0);

                if(pid.isEmpty() || !availablePid.contains(pid))
                {
                    b = false;
                    System.out.println("Pid is not valid");
                }
            }

            if(b) // cost
            {
                System.out.println("Please Enter the cost of the ride:");
                String s = in.readLine();
                try {
                    cost = Double.parseDouble(s);
                } catch (NumberFormatException e) {
                    System.out.println("Please type the cost");
                    b = false;
                }
                while (s == null && s.length() == 0) ;
            }

            if(b) {
                System.out.println("vin: " + vin + "\tpid: " + pid + "\tcost: $" + cost + "\tdate: " + date.toString());
                System.out.println("Do you want to confirm the reservation? (y/n)");
            }

            if(b)
            {
                if (!askForConfirmation(in))
                {
                    System.out.println("Canceled your reservation");
                    return;
                }
                else
                {
                    System.out.println("Your reservation has been confirmed");
                    Show_Suggested_UC(vin, con);
                }
            }

            if(b)
                break;
        }

        API.User_Add_Reservation(logged_in_user.getLogin_ID(),vin, pid,cost, date, con.stmt);

    }

    private static UC add_new_UC(BufferedReader in) throws IOException{
        UC new_car = new UC();
        int count = 0;
        for(String s : UC.data_sets) {
            String input = null;
            System.out.println("\nEnter " + s + " of your vehicle:");
            while ((input = in.readLine()) == null && input.length() == 0) ;

            if(input.isEmpty()){
                System.err.println("Null in input stream");
                return null;
            }

            switch (count) {
                case 0:
                    new_car.set_vin(input);
                    break;
                case 1:
                    new_car.set_category(input);
                    break;
                case 2:
                    new_car.set_make(input);
                    break;
                case 3:
                    new_car.set_model(input);
                    break;
                case 4:
                    try{
                        int input_to_integer = Integer.parseInt(input);
                        new_car.set_year(input_to_integer);
                    }catch (NumberFormatException e){
                        System.err.println("You must enter the year in number.");
                        return null;
                    }
                    break;
                default:
                    break;

            }
            count++;
        }
        new_car.set_login(logged_in_driver.getLogin_ID());

        return new_car;

    }

    private static void User_Browse_UC(BufferedReader in, Connector2 con) throws IOException{
        String category = "";
        String city = "";
        String state = "";
        String model = "";

        boolean isAND = false;
        boolean isAndSet = false;

        boolean sortOpSet = false;
        boolean sortOpA = false;

        String choice = "";

        System.out.println("Please enter the category of the car");
        while ((category = in.readLine()) == null && category.length() == 0) ;

        System.out.println("Please enter the name of the city");
        while ((city = in.readLine()) == null && city.length() == 0) ;

        System.out.println("Please enter the name of the state");
        while ((state = in.readLine()) == null && state.length() == 0) ;

        System.out.println("Please enter the name of the model");
        while ((model = in.readLine()) == null && model.length() == 0) ;

        while(true && !isAndSet){
            isAndSet = true;

            System.out.println("Would you like to AND or OR these attributes? (AND/OR)");
            while ((choice = in.readLine()) == null && choice.length() == 0) ;

            if(choice.equalsIgnoreCase("AND")){
                isAND = true;
                break;
            }else if (choice.equalsIgnoreCase("OR")){
                break;
            }else{
                System.out.println("Please enter either (AND or OR)");
                isAndSet = false;
            }
        }

        while(true && !sortOpSet){
            sortOpSet = true;

            System.out.println("Would you like to sort the result by (a) by the average numerical score of the feedbacks, " +
                    "or (b) by the average numerical score of the trusted user feedbacks? (A/B)");
            while ((choice = in.readLine()) == null && choice.length() == 0) ;

            if(choice.equalsIgnoreCase("A")){
                sortOpA = true;
                break;
            }else if (choice.equalsIgnoreCase("B")){
                break;
            }else{
                System.out.println("Please enter either (A or B)");
                sortOpSet = false;
            }
        }

        ArrayList<String[]> result = API.UC_Browse(isAND, sortOpA, logged_in_user.getName(), category, city, state, model, con.stmt);
        if(result.size() <= 0){
            System.out.println("No matching result has found");
        }else{
            System.out.println("\nvin, make, model, year, avgScore");
            for(String[] each_uc : result){
                for(String each_string : each_uc){
                    System.out.print(each_string + ", ");
                }
                System.out.println("\n");
            }
        }
    }

    /**
     * Asks the user for needed information of the ride and record it in the databases
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_Record_Ride(BufferedReader in, Connector2 con) throws IOException
    {
        boolean b;
        ArrayList<String[]> past_reservation= new ArrayList<>();
        int no =-1;

        String cost="";
        Date date=null;
        String vin="";

        String pid;

        Time fromHour = null;
        Time toHour = null;

        boolean confirmation  ;

        while(true)
        {
            b = true;
            past_reservation = API.Show_Past_Reservation( logged_in_user.getLogin_ID(),con.stmt);
            if(past_reservation.size() == 0)
            {
                System.out.println("You have not ridden with UUber");
                return;
            }

            System.out.println("Select the number you want to record");
            String temp = in.readLine();
            try
            {
                no = Integer.parseInt(temp);
            }
            catch (NumberFormatException e)
            {
                System.out.println("Fid is a number, please try again");
                b = false;
            }
            while (temp == null && temp.length() == 0) ;

            if(b)
            {
                if(no < 1 || no > past_reservation.size())
                {
                    b = false;
                    System.out.println("Input is not valid");
                }
            }

            if(b)
            {
                vin = past_reservation.get(no-1)[0];
                pid = past_reservation.get(no-1)[1];
                cost = past_reservation.get(no-1)[2];
                date = Date.valueOf(past_reservation.get(no-1)[3]);

                String[] fromTo = API.GetFromToHour(pid, con.stmt);
                fromHour = Time.valueOf(fromTo[0]);
                toHour = Time.valueOf(fromTo[1]);
            }

            if(b) {
                System.out.println("cost: $" + cost + "\tdate: " + date.toString() + "\tvin: " + vin + "\tfromHour: " + fromHour.toString()+ "\ttoHour: " + toHour.toString());
                System.out.println("Do you want to confirm the Recording? (y/n)");
            }

            if(b)
            {
                if (!askForConfirmation(in))
                {
                    System.out.println("Canceled your recording");
                    return;
                }
                else
                {
                    System.out.println("Your recording has been confirmed");
                }
            }

            if(b)
                break;

        }

        API.User_Record_Ride(cost,date,vin,logged_in_user.getLogin_ID(),fromHour,toHour, con.stmt);

    }

    /**
     * user can see the statistics of the database
     * @param in
     * @param con
     * @param choice
     * @throws IOException
     */
    private static void User_Stats(BufferedReader in, Connector2 con, int choice) throws IOException
    {
        String num ="";
        int number =-1;

        switch (choice)
        {
            case 1:
                System.out.println("How many popular cars do you want to see for each category?");
                break;

            case 2:
                System.out.println("How many Expensive cars do you want to see for each category?");
                break;

            case 3:
                System.out.println("How many Highly rated drivers do you want to see for each category?");
                break;

        }

        number = ParseNum_Helper(in);

        switch (choice)
        {
            case 1:
                API.Show_Popular_UC(number, con.stmt);
                break;

            case 2:
                API.Show_Expensive_UC(number, con.stmt);
                break;
            case 3:
                API.Show_Highly_Rated_UD(number, con.stmt);
                break;

        }


    }

    /**
     * Admin user can see the the top m most useful users (the usefulness score of a user is the average usefulness of all of his/her feedbacks combined)
     * @param in
     * @param con
     * @throws Exception
     */
    private static void Admin_See_Useful_User(BufferedReader in, Connector2 con) throws Exception
    {
        System.out.println("How many Useful users do you want to see? (Please type a number)");
        int number = ParseNum_Helper(in);
        API.Admin_Show_Useful_User(number, con.stmt);
    }

    /**
     * Admin user can see the top m most trusted users (the trust score of a user is the count of users trusting him/her, minus the count of users not-trusting him/her)
     * @param in
     * @param con
     * @throws Exception
     */
    private static void Admin_See_Trust_User(BufferedReader in, Connector2 con) throws Exception
    {
        System.out.println("How many trusted users do you want to see? (Please type a number)");
        int number = ParseNum_Helper(in);
        API.Admin_Show_Trust_User(number, con.stmt);

    }

    /**
     * helper method to parse a string to a number
     * @param in
     * @return the number that user typed
     * @throws IOException
     */
    private static int ParseNum_Helper(BufferedReader in) throws IOException
    {
        int number = -1;
        String num ="";
        while (true)
        {
            boolean b = true;
            while ((num = in.readLine()) == null && num.length() == 0) ;

            try
            {
                number = Integer.parseInt(num);
            }
            catch (NumberFormatException e)
            {
                b = false;
                System.out.println("Input must be a number");
            }

            if(b)
            {
                if(number < 1)
                {
                    System.out.println("Input must be greater than 0");
                    b = false;
                }
            }

            if(b)
                break;
        }
        return number;
    }


    /**
     * Ask the user needed information and give them a useful feedback.
     * @param in
     * @param con
     * @throws IOException
     */
    private static void User_See_Useful_Feedback(BufferedReader in, Connector2 con) throws IOException
    {
        String login;
        String num;
        int number=-1;

        while (true)
        {
            boolean b = true;
            System.out.println("Please enter the Driver's login");
            while ((login = in.readLine()) == null && login.length() == 0) ;

            if(login.isEmpty())
                b = false;

            if(b)
            {
                System.out.println("How many Feedback do you want to see? (please type a number)");
                while ((num = in.readLine()) == null && num.length() == 0) ;

                try
                {
                    number = Integer.parseInt(num);
                }
                catch (NumberFormatException e)
                {
                    b = false;
                    System.out.println("Input must be a number");
                }

            }
            if(b)
            {
                if(number < 1)
                {
                    System.out.println("Input must be greater than 0");
                    b = false;
                }
            }

            if(b)
                break;

        }
        API.Show_Useful_Feedback(login , number, con.stmt);
    }

    /**
     * Helper method to ask the user for the confirmation
     * @param in
     * @return whether user confirms or not.
     * @throws IOException
     */
    private static boolean askForConfirmation( BufferedReader in) throws IOException
    {
        String confirmation;

        while(true)
        {
            while ((confirmation = in.readLine()) == null && confirmation.length() == 0) ;

            if(confirmation.equalsIgnoreCase("Y")){
                return true;
            }else if (confirmation.equalsIgnoreCase("N")){
                return false;
            }else{
                System.out.println("Please enter either (Y or N)");
            }
        }

    }


    /**
     * This method is used to update the UUber Car Information.
     * @param in
     * @param con
     * @throws Exception
     */
    private static void update_UC(BufferedReader in, Connector2 con) throws Exception{
        UC existing_car = new UC();
        existing_car.set_login(logged_in_driver.getLogin_ID());

        int update_uc_count = 0;
        String vin = "";

        System.out.println("Please Enter the VIN number of your vehicle:");
        while ((vin = in.readLine()) == null && vin.length() == 0) ;
        existing_car.set_vin(vin);

        if(!API.Login_Vin_Matches(con.stmt, logged_in_driver.getLogin_ID(), vin)){
            System.err.println("Your Username and VIN number does not match our record. " +
                    "Please verify your information again.");
            return;
        }

        outer_loop:
        while(true){
            displayMenu_UpdateUC();
            while ((choice = in.readLine()) == null && choice.length() == 0) ;

            try {
                update_uc_count = Integer.parseInt(choice);
            } catch (Exception e) {
                continue;
            }

            switch (update_uc_count){
                case 1: // Update VIN
                    String new_vin = "";
                    System.out.println("Please Enter the New VIN number of your vehicle:");
                    while ((new_vin = in.readLine()) == null && new_vin.length() == 0) ;
                    API.Update_UC_Info(existing_car, con.stmt, "vin", new_vin);
                    break outer_loop;
                case 2: // Update category
                    String category = "";
                    System.out.println("Please Enter the New Category of your vehicle:");
                    while ((category = in.readLine()) == null && category.length() == 0) ;
                    API.Update_UC_Info(existing_car, con.stmt, "category", category);
                    break outer_loop;
                case 3: // Update make
                    String make = "";
                    System.out.println("Please Enter the New Make of your vehicle:");
                    while ((make = in.readLine()) == null && make.length() == 0) ;
                    API.Update_UC_Info(existing_car, con.stmt, "make", make);
                    break outer_loop;
                case 4: // Update model
                    String model = "";
                    System.out.println("Please Enter the New Model of your vehicle:");
                    while ((model = in.readLine()) == null && model.length() == 0) ;
                    API.Update_UC_Info(existing_car, con.stmt, "model", model);
                    break outer_loop;
                case 5: // Update year
                    String year = "";
                    System.out.println("Please Enter the New Year of your vehicle:");
                    while ((year = in.readLine()) == null && year.length() == 0) ;
                    API.Update_UC_Info(existing_car, con.stmt, "year", year);
                    break outer_loop;
                case 6:
                    Handle_Logged_In_Driver(in, con);
                    break outer_loop;
                default:
                    break;
            }
        }

    }

    /**
     * It displays the suggested UUber cars based on the favorite cars of friends.
     * @param vin
     * @param con
     */
    public static void Show_Suggested_UC(String vin, Connector2 con){
        ArrayList<String[]> suggested_UC = API.Suggest_Other_UC(vin, logged_in_user.getName(), con.stmt);

        if(suggested_UC.size() > 0){
            System.out.print("\nFollowing is the UC Suggestion: \n");
            for(String[] each_suggested_uc : suggested_UC){
                System.out.print(
                        "VIN:\t" + each_suggested_uc[0] + "\n" +
                        "Category:\t" + each_suggested_uc[1] + "\n" +
                        "Make:\t" + each_suggested_uc[2] + "\n" +
                        "Model:\t" + each_suggested_uc[3] + "\n" +
                        "Year:\t" + each_suggested_uc[4] + "\n" +
                        "UU_Rented:\t" + each_suggested_uc[5] + "\n" +
                        "Ride_Count:\t" + each_suggested_uc[6] + "\n");
                System.out.print("\n");
            }
        }else{
            System.out.println("No UC suggestion is available.");
        }
    }

    /**
     * This method is used to show the degree of separation between the 2 users.
     * @param in
     * @param con
     * @throws IOException
     */
    public static void Show_Degree_Of_Separation(BufferedReader in, Connector2 con) throws IOException{
        String username1 = "";
        String username2 = "";
        int degree_between_user1_user2 = 0;

        System.out.println("Please Enter the login name for User 1");
        while ((username1 = in.readLine()) == null && username1.length() == 0) ;

        System.out.println("Please Enter the login name for User 2");
        while ((username2 = in.readLine()) == null && username2.length() == 0) ;

        degree_between_user1_user2 = API.Check_Degree_Of_Separation(username1, username2, con.stmt);

        System.out.println("The degree between " + username1 + " and " + username2 + " is " + degree_between_user1_user2 + ".");
    }
}

