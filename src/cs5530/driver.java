package cs5530;


import java.lang.*;
import java.io.*;

public class driver {
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        System.out.println("Example for cs5530");
        Connector2 con=null;

        try
        {
            //remember to replace the password
            con= new Connector2();
            System.out.println ("Database connection established");

            BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
            Menus.welcome(in, con);

        }
        catch (Exception e)
        {
            e.printStackTrace();
            System.err.println ("Either connection error or query execution error!");
        }
        finally
        {
            if (con != null)
            {
                try
                {
                    con.closeConnection();
                    System.out.println ("Database connection terminated");
                }

                catch (Exception e) { /* ignore close errors */ }
            }
        }
    }
}
