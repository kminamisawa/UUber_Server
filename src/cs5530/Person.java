package cs5530;

/**
 * Created by kojiminamisawa on 2018/03/11.
 */
public interface Person {

    default void set_login(String login){}

    default void set_pw(String pw){}

    default void set_name(String name) {}

    default void set_address(String address) {}

    default void set_city(String city) {}

    default void set_state(String state) {}

    default void set_phone(String phone) {}
}
