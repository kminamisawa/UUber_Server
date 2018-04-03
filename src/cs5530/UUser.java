package cs5530;

import java.sql.Statement;

/**
 * Created by kojiminamisawa and Taku Sakikawa on 2018/03/10.
 */
public class UUser implements Person{
    private String login_ID;
    private String pw;
    private String name;
    private String address;
    private String city;
    private String state;
    private String phone;

    protected static final String[] data_sets = new String[]{"login_ID", "pw", "name","address", "city", "state", "phone"};


    public UUser(){

    }

    public UUser(String login_ID, String pw, String name, String address, String city, String state, String phone)
    {
        this.login_ID = login_ID;
        this.pw = pw;
        this.name = name;
        this.address = address;
        this.city = city;
        this.state= state;
        this.phone = phone;
    }

    @Override
    public void set_login(String login)
    {
        this.login_ID = login;
    }

    @Override
    public void set_pw(String pw)
    {
        this.pw = pw;
    }

    @Override
    public void set_name(String name)
    {
        this.name = name;
    }

    @Override
    public void set_address(String address)
    {
        this.address = address;
    }

    @Override
    public void set_phone(String phone)
    {
        this.phone = phone;
    }

    @Override
    public void set_state(String state){this.state = state; }

    @Override
    public void set_city(String city){this.city = city;}

    public String getLogin_ID() {
        return login_ID;
    }

    public String getPw() {
        return pw;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public String getCity(){return city; }

    public String getState(){return state; }

    public String getPhone() {
        return phone;
    }

}