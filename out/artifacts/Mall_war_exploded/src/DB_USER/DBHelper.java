package DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBHelper
{
    private static String db_url="jdbc:mysql://localhost:3306/User?useUnicode=true&characterEncoding=utf8";
    private static String db_user="root";
    private static String db_pwd="hzw13579";

    private static Connection db_con=null;

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection(){
        try
        {
            if(db_con==null)
                db_con = DriverManager.getConnection(db_url, db_user, db_pwd);
        }catch (Exception e){
            e.printStackTrace();
        }
        return db_con;
    }

    public static boolean close(){
        try
        {
            db_con.close();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
