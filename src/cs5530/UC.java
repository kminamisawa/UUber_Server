package cs5530;

import java.sql.Statement;

/**
 * Created by Taku Sakikawa on 2018/03/10.
 */
public class UC  {

    private String vin;
    private String category;
    private String make;
    private String model;
    private int year;
    private String login;
    protected static String[] data_sets = new String[]{"vin", "category","make", "model", "year"};


    public UC(){}
    public UC(String vin, String category, String make, String model, int year, String login)
    {
        this.vin = vin;
        this.category = category;
        this.make = make;
        this.model = model;
        this.year = year;
        this.login = login;
    }



    public String getVin() {
        return vin;
    }

    public String getCategory() {
        return category;
    }

    public String getMake() {
        return make;
    }

    public String getModel() {
        return model;
    }

    public int getYear() {
        return year;
    }

    public String getLogin() {
        return login;
    }



    public void set_vin(String vin)
    {
        this.vin = vin;
    }

    public void set_category(String category)
    {
        this.category = category;
    }

    public void set_make(String make) { this.make = make; }

    public void set_model(String model) { this.model = model; }

    public void set_year(int year ) { this.year = year; }

    public void set_login(String login) { this.login = login; }


}
